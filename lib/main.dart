import 'package:flutter/material.dart';
void main()=>runApp(const ZohanApp());
class ZohanApp extends StatelessWidget{
  const ZohanApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('ZOHAN - Malik ALLAH hai'), backgroundColor: Colors.green, centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.store, size: 100, color: Colors.green),
              const SizedBox(height: 20),
              const Text('Jo Bechna Chahte Ho,', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const Text('Zohan Par Becho', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green)),
              const SizedBox(height: 10),
              const Text('Har Legal Cheez Milegi', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
                onPressed: (){},
                child: const Text('SHURU KARO', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
