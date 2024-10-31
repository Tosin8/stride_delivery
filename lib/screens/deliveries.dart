import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Deliveries extends StatefulWidget {
  const Deliveries({super.key});

  @override
  State<Deliveries> createState() => _DeliveriesState();
}

class _DeliveriesState extends State<Deliveries> {
  final List<Delivery> deliveries = [
    Delivery(orderId: '123', customerName: 'John Doe', status: 'Out for delivery', deliveryTime: '10:00 AM'),
    Delivery(orderId: '124', customerName: 'Jane Smith', status: 'Delivered', deliveryTime: '9:30 AM'),
    Delivery(orderId: '125', customerName: 'Tom Brown', status: 'Pending', deliveryTime: '11:00 AM'),
     Delivery(orderId: '123', customerName: 'John Doe', status: 'Delivered', deliveryTime: '10:00 AM'),
    Delivery(orderId: '124', customerName: 'Jane Smith', status: 'Delivered', deliveryTime: '9:30 AM'),
    Delivery(orderId: '125', customerName: 'Tom Brown', status: 'Pending', deliveryTime: '11:00 AM'),
  ];

  @override
  void initState() {
    super.initState();
    sortDeliveriesByStatus();
  }

  void sortDeliveriesByStatus() {
    // Define the order of statuses
    const statusOrder = ['Out for delivery', 'Delivered', 'Pending'];
    // Sort deliveries based on status
    deliveries.sort((a, b) => statusOrder.indexOf(a.status).compareTo(statusOrder.indexOf(b.status)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hello Jide,',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: const [
          Icon(Iconsax.logout, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),
      body: deliveries.isEmpty
          ? const Center(child: Text('No Orders to Deliver'))
          : CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    minHeight: 50.0,
                    maxHeight: 50.0,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Your Deliveries',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return DeliveryCard(delivery: deliveries[index]);
                    },
                    childCount: deliveries.length,
                  ),
                ),
              ],
            ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
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
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
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
