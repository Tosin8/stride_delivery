

import 'package:flutter/material.dart';
import 'package:stride_delivery/screens/tracking.dart';
import 'package:url_launcher/url_launcher.dart';

class Deliveries extends StatefulWidget {
  const Deliveries({super.key});

  @override
  State<Deliveries> createState() => _DeliveriesState();
}

class _DeliveriesState extends State<Deliveries> {
  // Sample data for today's deliveries
  final List<Delivery> todayDeliveries = [
    Delivery(
      orderId: '123',
      customerName: 'John Doe',
      status: 'Out for delivery',
      deliveryTime: '10:00 AM',
      products: ['Product A', 'Product B'],
      address: '123 Main St',
      phone: '555-1234',
    ),
    Delivery(
      orderId: '124',
      customerName: 'Jane Smith',
      status: 'Delivered',
      deliveryTime: '9:30 AM',
      products: ['Product C'],
      address: '456 Maple Ave',
      phone: '555-5678',
    ),
  ];

  // Sample data for yesterday's deliveries
  final List<Delivery> yesterdayDeliveries = [
    Delivery(
      orderId: '125',
      customerName: 'Tom Brown',
      status: 'Pending',
      deliveryTime: '11:00 AM',
      products: ['Product D', 'Product E'],
      address: '789 Oak St',
      phone: '555-8765',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Deliveries',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomScrollView(
            slivers: [
              // Today's deliveries
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  minHeight: 60,
                  maxHeight: 60,
                  child: const DeliveryTitle(title: 'Today'),
                ),
                pinned: true,
              ),
              
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if(todayDeliveries.isNotEmpty){
                    return DeliveryCard(
                      delivery: todayDeliveries[index],
                      onTap: () => _navigateToDetail(context, todayDeliveries[index]),
                    );
                    } else {
                      return Container(); 
                    }
                  },
                  childCount: todayDeliveries.length,
                ),
              ),
              // Yesterday's deliveries
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  minHeight: 60,
                  maxHeight: 60,
                  child: const DeliveryTitle(title: 'Yesterday'),
                ),
                pinned: true,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if(yesterdayDeliveries.isNotEmpty){
                    return DeliveryCard(
                      delivery: yesterdayDeliveries[index],
                      onTap: () => _navigateToDetail(context, yesterdayDeliveries[index]),
                    );
                  }else {
                    return Container(); 
                  }
                  }, 
                  childCount: yesterdayDeliveries.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, Delivery delivery) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeliveryDetail(delivery: delivery),
      ),
    );
    }
}

class DeliveryTitle extends StatelessWidget {
  const DeliveryTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class Delivery {
  final String orderId;
  final String customerName;
  final String status;
  final String deliveryTime;
  final List<String> products; // List of products ordered
  final String address; // Delivery address
  final String phone; // Customer phone number

  Delivery({
    required this.orderId,
    required this.customerName,
    required this.status,
    required this.deliveryTime,
    required this.products,
    required this.address,
    required this.phone,
  });
}

class DeliveryCard extends StatelessWidget {
  final Delivery delivery;
  final VoidCallback onTap;

  const DeliveryCard({super.key, required this.delivery, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
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
      ),
    );
  }
}

class DeliveryDetail extends StatelessWidget {
  final Delivery delivery;

  const DeliveryDetail({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${delivery.orderId}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Customer: ${delivery.customerName}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${delivery.status}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Delivery Time: ${delivery.deliveryTime}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text(
              'Products Ordered:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            for (var product in delivery.products)
              Text(product, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 16),
            Text(
              'Address: ${delivery.address}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Phone: ${delivery.phone}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _makePhoneCall(delivery.phone),
              icon: const Icon(Icons.phone),
              label: const Text('Call Customer'),
            ),
            const Spacer(), // Pushes the button to the bottom
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrackingScreen(
                      deliveryAddress: delivery.address,
                      customerName: delivery.customerName,
                    ),
                  ),
                );
              },
              child: const Text('Initiate Delivery'),
            ),
          ],
        ),
      ),
    );
  }

  void _makePhoneCall(String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// SliverPersistentHeaderDelegate to create sticky headers
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
