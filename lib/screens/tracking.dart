import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  final MapController _mapController = MapController();
  List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    _fetchRoute();
  }

  Future<void> _fetchRoute() async {
    final uri = Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car');
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'YOUR_OPEN_ROUTE_SERVICE_API_KEY', // Replace with your API key
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'coordinates': [
          [8.681495, 49.41461], // Start coordinates
          [8.687872, 49.420318], // Destination coordinates
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _routePoints = (data['features'][0]['geometry']['coordinates'] as List)
            .map((point) => LatLng(point[1], point[0]))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const defaultPoint = LatLng(-8.923303951223144, 13.182696707942991);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracking - ${widget.customerName}'),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: const MapOptions(
          initialCenter: defaultPoint,  // Initial map center
          initialZoom: 13.0, 
                               // Initial map zoom level
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: _routePoints,
                strokeWidth: 4.0,
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
