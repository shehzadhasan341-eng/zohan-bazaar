import 'package:flutter/material.dart';

void main() {
  runApp(const ZohanApp());
}

class ZohanApp extends StatelessWidget {
  const ZohanApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ZOHAN - Malik ALLAH hai'),
          backgroundColor: Colors.green,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Jo Bechna Chahte Ho,', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text('Zohan Par Becho', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green)),
              SizedBox(height: 20),
              Text('Har Legal Cheez Milegi'),
              SizedBox(height: 20),
              Icon(Icons.check_circle, size: 80, color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}
