// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:aoun/data/models/store_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../util/location_helper.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({required this.stores, super.key});
  final List<StoreModel> stores;
  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> _controller =
        Completer<GoogleMapController>();

    Set<Marker> markers = <Marker>{};
    for (var store in stores) {
      markers.add(Marker(
          markerId: MarkerId(store.id),
          position: LatLng(store.latitude, store.longitude),
          infoWindow: InfoWindow(title: store.storeName)));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Maps'),
          centerTitle: true,
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: LocationHelper.getSavedCurrentLocation(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.hasData) {
              markers.add(
                Marker(
                    markerId: const MarkerId('1'),
                    position: LatLng(snapshot.data!['latitude'],
                        snapshot.data!['longitude']!),
                    infoWindow: const InfoWindow(
                      snippet: "My Current Location",
                      title: 'My Position',
                    )),
              );
              CameraPosition kGooglePlex = CameraPosition(
                target: LatLng(
                    snapshot.data!['latitude'], snapshot.data!['longitude']!),
                zoom: 14.4746,
              );
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: kGooglePlex,
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
