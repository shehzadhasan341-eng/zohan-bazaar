import 'package:flutter/material.dart';
void main()=>runApp(const ZohanApp());
class ZohanApp extends StatelessWidget{const ZohanApp({super.key}); @override Widget build(BuildContext c){return MaterialApp(debugShowCheckedModeBanner:false, home: const ZohanBazaar());}}
class ZohanBazaar extends StatefulWidget{const ZohanBazaar({super.key}); @override State<ZohanBazaar> createState()=>_ZohanBazaarState();}
class _ZohanBazaarState extends State<ZohanBazaar>{
  List<Map> cart=[];
  List<Map> products=[
    {'name':'Atta 10KG','price':1250,'owner':'Zohan Own','icon':Icons.agriculture},
    {'name':'Taza Sabzi','price':650,'owner':'Zohan Own','icon':Icons.eco},
    {'name':'Bakery Cake','price':850,'owner':'Zohan Own','icon':Icons.cake},
    {'name':'Nashta Pack','price':280,'owner':'Zohan Own','icon':Icons.breakfast_dining},
    {'name':'Handmade Bag','price':1200,'owner':'Seller Nazimabad','icon':Icons.shopping_bag},
  ];
  int get total=>cart.fold(0, (s,i)=>s+(i['price'] as int));
  @override Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Text('ZOHAN BAZAAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
      body: Column(children:[
        Container(color: Colors.black, padding: const EdgeInsets.all(8), child: const Text('Nagan & Nazimabad - 30-45 Min - 4KM Rs100 +20/KM - 4.5=4KM 4.6=5KM', style: TextStyle(color: Colors.white, fontSize: 10))),
        Expanded(child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.85), itemCount: products.length, itemBuilder: (ctx,i){
          var it=products[i]; return Card(child: Column(children:[Expanded(child: Icon(it['icon'], size: 50, color: it['owner']=='Zohan Own'?Colors.green:Colors.orange)), Text(it['name'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)), Text(it['owner'], style: const TextStyle(fontSize: 8)), Text('Rs ${it['price']}', style: const TextStyle(fontWeight: FontWeight.bold)), ElevatedButton(onPressed: ()=>setState(()=>cart.add(it)), child: const Text('ADD'))]));
        })),
        Container(padding: const EdgeInsets.all(10), color: Colors.amber.shade100, child: Column(children:[
          if(cart.isNotEmpty) Row(children:[Text('Total: Rs $total + Delivery', style: const TextStyle(fontWeight: FontWeight.bold)), const Spacer(), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black), onPressed: (){}, child: const Text('ORDER NOW - 30 MIN', style: TextStyle(color: Colors.amber, fontSize: 11)))]),
          const SizedBox(height:8),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.black), icon: const Icon(Icons.add_business, color: Colors.amber), label: const Text('APNI PRODUCT BECHNI HAI? Yahan Click Karo', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)), onPressed: (){
            showModalBottomSheet(context: context, builder: (ctx)=>Padding(padding: const EdgeInsets.all(16), child: Column(mainAxisSize: MainAxisSize.min, children:[
              const Text('Zohan Par Becho', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const Text('Apke paas paisa hai, market nahi? Ham bech denge, commission lenge', style: TextStyle(fontSize: 11)),
              const TextField(decoration: InputDecoration(labelText: 'Kya product hai? Legal & Safe ho')),
              const TextField(decoration: InputDecoration(labelText: 'Price?')),
              const SizedBox(height:10),
              SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black), onPressed: (){Navigator.pop(ctx); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request Admin ko chali gayi - Link alag hai, secure hai!')));}, child: const Text('REQUEST BHEJO', style: TextStyle(color: Colors.amber)))),
            ])));
          })),
        ])),
      ]),
    );
  }
}
