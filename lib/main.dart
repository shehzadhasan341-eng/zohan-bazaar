import 'package:flutter/material.dart';
void main()=>runApp(const ZohanApp());
class ZohanApp extends StatelessWidget{const ZohanApp({super.key}); @override Widget build(BuildContext c){return MaterialApp(debugShowCheckedModeBanner:false, home: const ZohanBazaar());}}

class ZohanBazaar extends StatefulWidget{const ZohanBazaar({super.key}); @override State<ZohanBazaar> createState()=>_ZohanBazaarState();}
class _ZohanBazaarState extends State<ZohanBazaar>{
  List<Map> cart=[]; String filter='Zohan Own';
  List<Map> products=[
    // Phase 1 - Apni Products - Trust ke liye
    {'name':'Atta 10KG','price':1250,'owner':'Zohan Own','cat':'Grocery','icon':Icons.agriculture, 'comm':0},
    {'name':'Taza Sabzi 5KG','price':650,'owner':'Zohan Own','cat':'Vegetables','icon':Icons.eco, 'comm':0},
    {'name':'Bakery Cake','price':850,'owner':'Zohan Own','cat':'Bakery','icon':Icons.cake, 'comm':0},
    {'name':'Nashta Halwa Puri','price':280,'owner':'Zohan Own','cat':'Nashta','icon':Icons.breakfast_dining, 'comm':0},
    // Phase 2 - Logon ki Products - Commission par
    {'name':'Hand Made Bag','price':1200,'owner':'Ayesha - Nazimabad','cat':'Others','icon':Icons.shopping_bag, 'comm':10},
    {'name':'Wooden Chair','price':4500,'owner':'Irfan - Nagan','cat':'Others','icon':Icons.chair, 'comm':15},
    {'name':'Bachon ke Kapre','price':950,'owner':'Fatima - Nazimabad','cat':'Others','icon':Icons.child_care, 'comm':12},
  ];
  int get total=>cart.fold(0, (s,i)=>s+(i['price'] as int));
  int get commissionEarn=>cart.fold(0, (s,i)=>s+((i['price'] as int)*(i['comm'] as int)~/100));

  @override Widget build(BuildContext context){
    var list=filter=='All'?products:products.where((x)=>x['owner']==filter || (filter=='Others' && x['owner']!='Zohan Own')).toList();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Text('ZOHAN BAZAAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text('Pehle apna, phir sab ka - Malik ALLAH hai', style: TextStyle(color: Colors.amber, fontSize: 10))]), actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.storefront, color: Colors.amber))]),
      body: Column(children:[
        Container(color: Colors.green.shade50, padding: const EdgeInsets.all(10), child: Row(children:[
          Expanded(child: ChoiceChip(label: const Text('Zohan Own - Trust'), selected: filter=='Zohan Own', onSelected: (v)=>setState(()=>filter='Zohan Own'))),
          const SizedBox(width:8),
          Expanded(child: ChoiceChip(label: const Text('Logon ka Bazaar - Commission'), selected: filter=='Others', onSelected: (v)=>setState(()=>filter='Others'))),
        ])),
        Container(color: Colors.black, padding: const EdgeInsets.all(6), child: const Row(children:[Icon(Icons.info, color: Colors.amber, size: 14), SizedBox(width:6), Expanded(child: Text('Apke paas paisa hai, market nahi? Hamare paas market hai - Zohan bech dega, commission de do', style: TextStyle(color: Colors.white, fontSize: 10)))])),
        Expanded(child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.85), itemCount: list.length, itemBuilder: (ctx,i){
          var it=list[i]; bool own=it['owner']=='Zohan Own';
          return Card(child: Column(children:[
            Expanded(child: Container(color: own?Colors.green.shade50:Colors.amber.shade50, child: Center(child: Icon(it['icon'], size: 50, color: own?Colors.green:Colors.black)))),
            Padding(padding: const EdgeInsets.all(6), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
              Text(it['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text(it['owner'], style: TextStyle(fontSize: 9, color: own?Colors.green:Colors.orange, fontWeight: FontWeight.bold)),
              Row(children:[Text('Rs ${it['price']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)), const Spacer(), if(!own) Text('${it['comm']}% comm', style: const TextStyle(fontSize: 9, color: Colors.red)), InkWell(onTap: ()=>setState(()=>cart.add(it)), child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)), child: const Text('ADD', style: TextStyle(color: Colors.amber, fontSize: 10))))]),
            ])),
          ]));
        })),
        Container(color: Colors.amber.shade100, padding: const EdgeInsets.all(10), child: InkWell(onTap: (){
          showModalBottomSheet(context: context, builder: (ctx)=>Padding(padding: const EdgeInsets.all(16), child: Column(mainAxisSize: MainAxisSize.min, children:[
            const Text('Apni Product Bechni Hai?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height:8),
            const Text('Aap banao (Legal ho, Harmful na ho), Zohan bech dega. Aapke paas paisa hai, hamare paas market.', textAlign: TextAlign.center),
            const TextField(decoration: InputDecoration(labelText: 'Kya banate ho? ex: Handmade Bags')),
            const TextField(decoration: InputDecoration(labelText: 'Price kya hai?')),
            const SizedBox(height:10),
            SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black), onPressed: (){Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request Zohan ko mil gayi - 24h me contact karenge!')));}, child: const Text('ZOHAN PAR BECHO - COMMISSION DUNGA', style: TextStyle(color: Colors.amber, fontSize: 11)))),
          ])));
        }, child: const Row(mainAxisAlignment: MainAxisAlignment.center, children:[Icon(Icons.add_business, size: 18), SizedBox(width:6), Text('Tum jo chahe banao, Zohan bech dega - Yahan tap karo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))]))),
        if(cart.isNotEmpty) Container(padding: const EdgeInsets.all(10), color: Colors.black, child: Row(children:[
          Column(crossAxisAlignment: CrossAxisAlignment.start, children:[Text('Total: Rs $total', style: const TextStyle(color: Colors.white)), Text('Hamara Commission: Rs $commissionEarn', style: const TextStyle(color: Colors.amber, fontSize: 10))]),
          const Spacer(),
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), onPressed: (){setState(()=>cart.clear());}, child: const Text('ORDER - 30 MIN', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11))),
        ])),
      ]),
    );
  }
}
