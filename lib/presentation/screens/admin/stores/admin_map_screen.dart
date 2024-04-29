// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../util/location_helper.dart';

class AdminMapScreen extends StatefulWidget {
  const AdminMapScreen({super.key});

  @override
  State<AdminMapScreen> createState() => _AdminMapScreenState();
}

class _AdminMapScreenState extends State<AdminMapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
      markers.add(Marker(
          markerId: const MarkerId("store"), position: _pickedLocation!));
    });
  }

  Set<Marker> markers = <Marker>{};

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();

    return Scaffold(
        appBar: AppBar(
            title: const Text('Map'),
            actions: [
              IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: _pickedLocation == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_pickedLocation);
                        })
            ],
            centerTitle: true),
        body: FutureBuilder<Map<String, dynamic>>(
            future: LocationHelper.getSavedCurrentLocation(),
            builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.hasData) {
                markers.add(Marker(
                    markerId: const MarkerId('1'),
                    position: LatLng(snapshot.data!['latitude'],
                        snapshot.data!['longitude']!),
                    infoWindow: const InfoWindow(
                      title: 'My Position',
                    )));
                CameraPosition kGooglePlex = CameraPosition(
                    target: LatLng(snapshot.data!['latitude'],
                        snapshot.data!['longitude']!),
                    zoom: 14.4746);
                return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: kGooglePlex,
                    markers: markers,
                    onTap: _selectLocation,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
