import 'package:flutter/material.dart';

class TrackingScreen extends StatefulWidget {
  final String deliveryAddress;
  final String customerName;

  const TrackingScreen({
    super.key,
    required this.deliveryAddress,
    required this.customerName,
  });

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  Widget build(BuildContext context) {
    // Placeholder screen for tracking with Google Maps
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking - ${widget.customerName}'),
      ),
      body: const Center(
        child: Text(
          'Google Map tracking would go here for the delivery location.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}