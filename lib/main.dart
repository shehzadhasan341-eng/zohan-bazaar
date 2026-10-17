import 'package:flutter/material.dart';
void main()=>runApp(const ZohanApp());
class ZohanApp extends StatelessWidget{
  const ZohanApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData(primarySwatch: Colors.green), home: const MainScreen());
  }
}
class Product{String title, price, location; IconData icon; Product(this.title,this.price,this.location,this.icon);}
List<Product> products = [
  Product('iPhone 14 Pro Max','Rs 285,000','Karachi', Icons.phone_iphone),
  Product('Honda 125 2024','Rs 235,000','Lahore', Icons.motorcycle),
  Product('Sofa Set 5 Seater','Rs 85,000','Islamabad', Icons.chair),
  Product('【entity-Nike¦canonical_name=Nike】 Shoes Original','Rs 12,500','Karachi', Icons.checkroom),
];

class MainScreen extends StatefulWidget{const MainScreen({super.key}); @override State<MainScreen> createState()=>_MainScreenState();}
class _MainScreenState extends State<MainScreen>{
  int _index=0;
  final screens=[const HomeTab(), const SearchTab(), const SellTab(), const ChatTab(), const ProfileTab()];
  @override Widget build(BuildContext context){
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: BottomNavigationBar(currentIndex: _index, onTap: (i)=>setState(()=>_index=i), type: BottomNavigationBarType.fixed, selectedItemColor: Colors.green, items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Becho'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Mera'),
      ]),
    );
  }
}
class HomeTab extends StatelessWidget{const HomeTab({super.key}); @override Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: const Text('ZOHAN - Malik ALLAH hai'), backgroundColor: Colors.green, actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.notifications))]),
    body: Column(children: [
      Container(padding: const EdgeInsets.all(12), color: Colors.green.shade50, child: const TextField(decoration: InputDecoration(hintText: 'Zohan par dhoondo... Mobile, Bike, Ghar', prefixIcon: Icon(Icons.search), border: OutlineInputBorder(), filled: true, fillColor: Colors.white))),
      SizedBox(height: 80, child: ListView(scrollDirection: Axis.horizontal, children: [
        for(var c in ['Mobiles','Bikes','Cars','Fashion','Home','Jobs']) Padding(padding: const EdgeInsets.all(8), child: Chip(label: Text(c), avatar: const Icon(Icons.category, size: 16))),
      ])),
      Expanded(child: GridView.builder(padding: const EdgeInsets.all(8), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8), itemCount: products.length, itemBuilder: (c,i){
        var p=products[i]; return Card(child: Column(children: [Expanded(child: Icon(p.icon, size: 80, color: Colors.green)), Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(p.title, maxLines: 1, style: const TextStyle(fontWeight: FontWeight.bold)), Text(p.price, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)), Text(p.location, style: const TextStyle(fontSize: 12))]))]));
      })),
    ]),
  );
}}
class SearchTab extends StatelessWidget{const SearchTab({super.key}); @override Widget build(BuildContext context){return Scaffold(appBar: AppBar(title: const Text('Search'), backgroundColor: Colors.green), body: const Center(child: Text('Search ayega - Category filter ke sath')));}}
class SellTab extends StatefulWidget{const SellTab({super.key}); @override State<SellTab> createState()=>_SellTabState();}
class _SellTabState extends State<SellTab>{
  final _title=TextEditingController(); final _price=TextEditingController();
  @override Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: const Text('Kya Bechna Chahte Ho?'), backgroundColor: Colors.green),
      body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        const Icon(Icons.add_a_photo, size: 80, color: Colors.grey), const Text('Photo Add Karo'),
        const SizedBox(height: 20),
        TextField(controller: _title, decoration: const InputDecoration(labelText: 'Title - jaise iPhone 14', border: OutlineInputBorder())),
        const SizedBox(height: 10),
        TextField(controller: _price, decoration: const InputDecoration(labelText: 'Price - Rs', border: OutlineInputBorder())),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.all(15)), onPressed: (){
          if(_title.text.isNotEmpty){ setState(()=>products.insert(0, Product(_title.text, 'Rs ${_price.text}', 'Karachi', Icons.shopping_bag))); _title.clear(); _price.clear(); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Zohan par add ho gaya!')));}
        }, child: const Text('ZOHAN PAR BECHO', style: TextStyle(color: Colors.white)))),
      ])),
    );
  }
}
class ChatTab extends StatelessWidget{const ChatTab({super.key}); @override Widget build(BuildContext context){return Scaffold(appBar: AppBar(title: const Text('Chat - Kharidar se baat'), backgroundColor: Colors.green), body: ListView(children: [ListTile(leading: const CircleAvatar(child: Text('A')), title: const Text('Ahmed - iPhone ke liye'), subtitle: const Text('Bhai final kitne me doge?'), trailing: const Text('2m')), ListTile(leading: const CircleAvatar(child: Text('S')), title: const Text('Sara - Sofa'), subtitle: const Text('Location bhejo'), trailing: const Text('1h'))]));}}
class ProfileTab extends StatelessWidget{const ProfileTab({super.key}); @override Widget build(BuildContext context){return Scaffold(appBar: AppBar(title: const Text('Mera Zohan'), backgroundColor: Colors.green), body: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircleAvatar(radius: 40, child: Text('Z', style: TextStyle(fontSize: 30))), SizedBox(height: 10), Text('Shehzad Hasan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), Text('zohan-509106 User'), SizedBox(height: 20), Text('ZOHAN - Malik ALLAH hai', style: TextStyle(color: Colors.green))]))) ;}}
