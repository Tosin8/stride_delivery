import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Deliveries extends StatefulWidget {
  const Deliveries({super.key});

  @override
  State<Deliveries> createState() => _DeliveriesState();
}

class _DeliveriesState extends State<Deliveries> {
  // Sample data for deliveries
  final List<Delivery> deliveries = [
    Delivery(orderId: '123', customerName: 'John Doe', status: 'Out for delivery', deliveryTime: '10:00 AM'),
    Delivery(orderId: '124', customerName: 'Jane Smith', status: 'Delivered', deliveryTime: '9:30 AM'),
    Delivery(orderId: '125', customerName: 'Tom Brown', status: 'Pending', deliveryTime: '11:00 AM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hello Jide, ',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: const [
          Icon(Iconsax.logout, color: Colors.black,),
          SizedBox(width: 10,), 
        ],
        
      ),
      body: deliveries.isEmpty 
          ? const Center(child: Text('No Orders to Deliver'))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                    const SizedBox(height: 16),
                    Column(
                      children: deliveries.map((delivery) => DeliveryCard(delivery: delivery)).toList(),
                    ),
                    const SizedBox(height: 24),
              
                  ],
                ),
              ),
            ),
    );
  }
}

class DeliveryTitle extends StatelessWidget {
  const DeliveryTitle({
    super.key,
    required this.title,
  });
  final String title; 
  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),);
  }
}

class Delivery {
  final String orderId;
  final String customerName;
  final String status;
  final String deliveryTime;

  Delivery({
    required this.orderId,
    required this.customerName,
    required this.status,
    required this.deliveryTime,
  });
}

class DeliveryCard extends StatelessWidget {
  final Delivery delivery;

  const DeliveryCard({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${delivery.orderId}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Customer: ${delivery.customerName}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Status: ${delivery.status}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              'Delivery Time: ${delivery.deliveryTime}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
