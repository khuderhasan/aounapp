import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../config/error_model.dart';
import '../../config/result_class.dart';
import '../../util/location_helper.dart';
import '../models/store_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoresDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ResponseState<bool>> addStore(
      {required storeName, required latitude, required longitude}) async {
    try {
      await _firestore.collection('stores').add({
        "storeName": storeName,
        "latitude": latitude,
        "longitude": longitude,
      }).then((docRef) {
        docRef.update({
          "id": docRef.id,
        });
      });
      return ResponseState.success(true);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<List<StoreModel>>> getNearbyStores() async {
    await getLocation();
    final locationData = await LocationHelper.getSavedCurrentLocation();
    double userLat = locationData['latitude'];
    double userLon = locationData['longitude'];
    try {
      List<StoreModel> stores = [];
      await _firestore.collection('stores').get().then((value) {
        for (var element in value.docs) {
          double docLat = element.data()['latitude'].toDouble();
          double docLon = element.data()['longitude'].toDouble();
          int distance =
              LocationHelper.calculateDistance(userLat, userLon, docLat, docLon)
                  .toInt();
          stores.add(
            StoreModel(
              id: element.data()['id'],
              storeName: element.data()['storeName'],
              latitude: element.data()['latitude'],
              longitude: element.data()['longitude'],
              distance: distance,
            ),
          );
        }
      });
      stores.sort((a, b) => a.distance!.compareTo(b.distance!));

      return ResponseState.success(stores);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<List<StoreModel>>> getStores() async {
    await getLocation();
    try {
      List<StoreModel> stores = [];
      await _firestore.collection('stores').get().then((value) {
        for (var element in value.docs) {
          stores.add(StoreModel.fromMap(element.data()));
        }
      });
      return ResponseState.success(stores);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }
}

Future<void> getLocation() async {
  LocationData? locationData;
  locationData = await LocationHelper.getLocationPermisions();
  if (locationData != null) {
    await LocationHelper.saveCurrentLocation(
        longitude: locationData.longitude, latitude: locationData.latitude);
  } else {
    // Handle location retrieval failure (e.g., display an error message)
    debugPrint('Failed to get location');
    // You might consider showing an error message or retrying
  }
}
