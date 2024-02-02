import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../customWidgets/customAppBar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  Set<Polygon> _polygon = HashSet<Polygon>();
  List<LatLng> points = [
    LatLng(29.01638908, 73.080646321),
    LatLng(29.016109667, 73.085775375),
    LatLng(29.013121103, 73.085736819),
    LatLng(29.013036368, 73.080674149),
    LatLng(29.01638908, 73.080646321),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(Polygon(
        polygonId: PolygonId('1'),
        points: points,
        strokeColor: Colors.blue.withOpacity(0.8),
        strokeWidth: 2,
        fillColor: Colors.green.withOpacity(0.4)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ' Google Map', screen: 'GMap'),
      body: GoogleMap(
        mapType: MapType.normal,
        polygons: _polygon,
        initialCameraPosition: const CameraPosition(
            target: LatLng(29.01638908, 73.080646321), zoom: 16),
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
      ),
    );
  }
}
