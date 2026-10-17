import 'package:flutter/material.dart';
void main()=>runApp(const ZohanApp());
class ZohanApp extends StatelessWidget{const ZohanApp({super.key}); @override Widget build(BuildContext c){return MaterialApp(debugShowCheckedModeBanner:false, home: const ZohanQuickMart());}}

// Delivery Charge Logic - Tumhari Planning
int calculateDelivery(double km){
  int effectiveKm;
  double fraction = km - km.floor();
  if(fraction <= 0.5){ effectiveKm = km.floor(); } else { effectiveKm = km.ceil(); }
  if(effectiveKm <= 4) return 100;
  return 100 + (effectiveKm - 4) * 20;
}

class ZohanQuickMart extends StatefulWidget{const ZohanQuickMart({super.key}); @override State<ZohanQuickMart> createState()=>_ZohanQuickMartState();}
class _ZohanQuickMartState extends State<ZohanQuickMart>{
  List<Map> cart=[]; double distance=3.2; // Example: Nagan se customer 3.2 KM
  List<Map> items=[
    {'name':'Atta 10KG','price':1250,'cat':'Atta Cheeni','icon':Icons.agriculture},
    {'name':'Cheeni 5KG','price':550,'cat':'Atta Cheeni','icon':Icons.cake},
    {'name':'Ghee 5KG','price':2850,'cat':'Ghee Oil','icon':Icons.water_drop},
    {'name':'Daal 1KG','price':380,'cat':'Daal Chawal','icon':Icons.grain},
    {'name':'Sabzi Mix 5KG','price':650,'cat':'Sabzi','icon':Icons.eco},
    {'name':'Nashta Pack','price':280,'cat':'Nashta','icon':Icons.breakfast_dining},
    {'name':'Pampers','price':1850,'cat':'Bachon ki','icon':Icons.child_care},
    {'name':'Ladies Private Pack','price':650,'cat':'Ladies Private','icon':Icons.privacy_tip, 'private':true},
  ];
  String cat='All';
  int get deliveryCharge => calculateDelivery(distance);
  int get subtotal => cart.fold(0, (s,i)=>s+(i['price'] as int));
  int get grandTotal => subtotal + deliveryCharge;

  @override Widget build(BuildContext context){
    var filtered=cat=='All'?items:items.where((x)=>x['cat']==cat).toList();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Text('ZOHAN - 30 Min Bazaar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.my_location, color: Colors.amber))]),
      body: Column(children:[
        Container(color: Colors.amber.shade100, padding: const EdgeInsets.all(10), child: Column(children:[
          Row(children:[const Icon(Icons.delivery_dining, size: 18), const SizedBox(width:6), Expanded(child: Text('Delivery: 4KM tak Rs 100, har KM Rs 20 izafa - Distance: ${distance}KM = Rs $deliveryCharge', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)))]),
          const SizedBox(height:6),
          Slider(value: distance, min: 1, max: 10, divisions: 18, label: '${distance.toStringAsFixed(1)} KM', onChanged: (v)=>setState(()=>distance=v)),
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[Text('1 KM', style: TextStyle(fontSize: 10)), Text('Nagan Point se tumhara ghar', style: TextStyle(fontSize: 10)), Text('10 KM', style: TextStyle(fontSize: 10))]),
        ])),
        SizedBox(height:45, child: ListView(scrollDirection: Axis.horizontal, children:[
          for(var c in ['All','Atta Cheeni','Ghee Oil','Daal Chawal','Sabzi','Nashta','Bachon ki','Ladies Private']) Padding(padding: const EdgeInsets.all(4), child: ChoiceChip(label: Text(c, style: const TextStyle(fontSize: 11)), selected: cat==c, onSelected: (v)=>setState(()=>cat=c))),
        ])),
        Expanded(child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.82), itemCount: filtered.length, itemBuilder: (ctx,i){
          var it=filtered[i]; return Card(child: Column(children:[Expanded(child: Icon(it['icon'], size: 50, color: it['private']==true?Colors.pink:Colors.green)), Text(it['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), Text('Rs ${it['price']}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black, minimumSize: const Size(80, 30)), onPressed: ()=>setState(()=>cart.add(it)), child: const Text('ADD', style: TextStyle(color: Colors.amber, fontSize: 10)))]));
        })),
        if(cart.isNotEmpty) Container(padding: const EdgeInsets.all(12), color: Colors.black, child: Column(children:[
          Row(children:[Text('Saman: Rs $subtotal + Delivery (${distance.toStringAsFixed(1)}KM): Rs $deliveryCharge', style: const TextStyle(color: Colors.white, fontSize: 11)), const Spacer(), Text('Total: Rs $grandTotal', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold))]),
          const SizedBox(height:6),
          SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), onPressed: (){
            showDialog(context: context, builder: (ctx)=>AlertDialog(title: const Text('Order Final?'), content: Text('Distance: ${distance.toStringAsFixed(1)} KM\n4.5=4KM, 4.6=5KM ke hisab se\nDelivery: Rs $deliveryCharge\nTotal: Rs $grandTotal\nLadies items 100% Private\n30-45 min me ghar par'), actions: [TextButton(onPressed: (){setState(()=>cart.clear()); Navigator.pop(ctx);}, child: const Text('ORDER KARO'))]));
          }, child: const Text('30 MIN ME CHAHIYE - ORDER KARO', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)))),
        ])),
      ]),
    );
  }
}
