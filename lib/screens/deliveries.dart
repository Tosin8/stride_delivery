import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class Deliveries extends StatefulWidget {
  const Deliveries({super.key});

  @override
  State<Deliveries> createState() => _DeliveriesState();
}

class _DeliveriesState extends State<Deliveries> {
  final List<Delivery> deliveries = [
    Delivery(
      orderId: '123',
      customerName: 'John Doe',
      status: 'Out for delivery',
      deliveryTime: '10:00 AM',
      address: '123 Street, City, Country',
      phoneNumber: '+1234567890',
      productItems: ['Shoes', 'Shirts'],
    ),
    Delivery(
      orderId: '124',
      customerName: 'Jane Smith',
      status: 'Delivered',
      deliveryTime: '9:30 AM',
      address: '456 Avenue, City, Country',
      phoneNumber: '+0987654321',
      productItems: ['Jacket', 'Pants'],
    ),
    Delivery(
      orderId: '125',
      customerName: 'Tom Brown',
      status: 'Pending',
      deliveryTime: '11:00 AM',
      address: '789 Boulevard, City, Country',
      phoneNumber: '+1230984567',
      productItems: ['Hat', 'Gloves'],
    ),
  ];

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
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _StickyHeaderDelegate(),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeliveryDetails(
                                  delivery: deliveries[index],
                                ),
                              ),
                            );
                          },
                          child: DeliveryCard(delivery: deliveries[index]),
                        );
                      },
                      childCount: deliveries.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 50;
  @override
  double get maxExtent => 50;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: const Text(
        'Your Deliveries',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class Delivery {
  final String orderId;
  final String customerName;
  final String status;
  final String deliveryTime;
  final String address;
  final String phoneNumber;
  final List<String> productItems;

  Delivery({
    required this.orderId,
    required this.customerName,
    required this.status,
    required this.deliveryTime,
    required this.address,
    required this.phoneNumber,
    required this.productItems,
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

class DeliveryDetails extends StatelessWidget {
  final Delivery delivery;

  const DeliveryDetails({super.key, required this.delivery});

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
            const Text('Product Items:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            ...delivery.productItems
                .map((item) => Text('- $item', style: const TextStyle(fontSize: 16)))
                ,
            const SizedBox(height: 16),
            const Text('Address:', style: TextStyle(fontSize: 18)),
            Text(
              delivery.address,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Phone:', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text(
                  delivery.phoneNumber,
                  style: const TextStyle(fontSize: 16, color: Colors.blue),
                ),
                IconButton(
                  icon: const Icon(Iconsax.call, color: Colors.green),
                  onPressed: () async {
                    final url = 'tel:${delivery.phoneNumber}';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Initiate delivery logic
                },
                child: const Text('Initiate Order Delivery'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
