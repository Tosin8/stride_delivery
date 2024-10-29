import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(title: const Text(
        
      'Hi, Jide', style: TextStyle(
        fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black
      ),),), 
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Column (
          children:[ Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Overview', style: TextStyle(fontSize: 24, 
              fontWeight: FontWeight.w500),),
              Text('This Week', style: TextStyle(color: Colors.grey),),
            ],
          ),
        ]),
      ), 
    );
  }
}
