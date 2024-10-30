import 'package:flutter/material.dart';

class Tracking extends StatefulWidget {
  const Tracking({super.key});

  @override
  State<Tracking> createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold( 
      appBar: AppBar(
         title: const Text(
          'Track',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: const Center(
        child: Text('No Tracking Delivery'),
      )
    );
  }
}