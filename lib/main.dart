import 'package:flutter/material.dart';
void main()=>runApp(const ZohanApp());
class ZohanApp extends StatelessWidget{const ZohanApp({super.key}); @override Widget build(BuildContext c){return MaterialApp(debugShowCheckedModeBanner:false, home: const ZohanBazaar());}}
class ZohanBazaar extends StatefulWidget{const ZohanBazaar({super.key}); @override State<ZohanBazaar> createState()=>_ZohanBazaarState();}
class _ZohanBazaarState extends State<ZohanBazaar>{
  List<Map> cart=[]; String filter='Zohan Own';
  List<Map> products=[
    {'name':'Atta 10KG','price':1250,'owner':'Zohan Own','cat':'Grocery','icon':Icons.agriculture, 'comm':0},
    {'name':'Taza Sabzi 5KG','price':650,'owner':'Zohan Own','cat':'Vegetables','icon':Icons.eco, 'comm':0},
    {'name':'Bakery Cake','price':850,'owner':'Zohan Own','cat':'Bakery','icon':Icons.cake, 'comm':0},
    {'name':'Nashta Halwa Puri','price':280,'owner':'Zohan Own','cat':'Nashta','icon':Icons.breakfast_dining, 'comm':0},
    {'name':'Hand Made Bag','price':1200,'owner':'Ayesha - Nazimabad','cat':'Others','icon':Icons.shopping_bag, 'comm':10},
  ];
  int get total=>cart.fold(0, (s,i)=>s+(i['price'] as int));
  @override Widget build(BuildContext context){
    var list=filter=='All'?products:products.where((x)=>x['owner']==filter || (filter=='Others' && x['owner']!='Zohan Own')).toList();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: const Text('ZOHAN BAZAAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
      body: Column(children:[
        Container(color: Colors.green.shade50, padding: const EdgeInsets.all(10), child: Row(children:[
          Expanded(child: ChoiceChip(label: const Text('Zohan Own'), selected: filter=='Zohan Own', onSelected: (v)=>setState(()=>filter='Zohan Own'))),
          const SizedBox(width:8),
          Expanded(child: ChoiceChip(label: const Text('Logon ka Bazaar'), selected: filter=='Others', onSelected: (v)=>setState(()=>filter='Others'))),
        ])),
        Container(color: Colors.black, padding: const EdgeInsets.all(6), child: const Text('Apke paas paisa hai, market nahi? Zohan bech dega', style: TextStyle(color: Colors.white, fontSize: 10))),
        Expanded(child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemCount: list.length, itemBuilder: (ctx,i){
          var it=list[i]; return Card(child: Column(children:[Expanded(child: Icon(it['icon'], size: 50)), Text(it['name']), Text('Rs ${it['price']}'), ElevatedButton(onPressed: ()=>setState(()=>cart.add(it)), child: const Text('ADD'))]));
        })),
      ]),
    );
  }
}
