import 'dart:convert';
import 'dart:math' as math;

import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

const double radius = 6371;

class LocationHelper {
  static Future<LocationData?> getLocationPermisions() async {
    Location location = Location();
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;
    LocationData? locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    locationData = await location.getLocation();
    return locationData;
  }

  static Future<void> saveCurrentLocation(
      {required longitude, required latitude}) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('locationData')) {
      await prefs.remove('locationData');
    }
    final locationData =
        json.encode({'latitude': latitude, 'longitude': longitude});
    prefs.setString('locationData', locationData);
  }

  static Future<Map<String, dynamic>> getSavedCurrentLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocationData =
        json.decode(prefs.getString('locationData')!) as Map<String, dynamic>;
    return savedLocationData;
  }

  static Map<String, double> getCoordinateRange(
      {required double lat, required double lon, required double distance}) {
    // Radius of the Earth in kilometers
    double R = 6371.0;

    // Convert distance to kilometers
    distance = distance / 1000.0;

    // Convert latitude and longitude to radians
    double latRad = lat * (math.pi / 180);
    double lonRad = lon * (math.pi / 180);

    // Calculate the range
    double minLat = latRad - distance / R;
    double maxLat = latRad + distance / R;
    double minLon = lonRad - distance / (R * math.cos(latRad));
    double maxLon = lonRad + distance / (R * math.cos(latRad));

    // Convert back to degrees
    minLat = minLat * (180 / math.pi);
    maxLat = maxLat * (180 / math.pi);
    minLon = minLon * (180 / math.pi);
    maxLon = maxLon * (180 / math.pi);

    return {
      "min_lat": double.parse(minLat.toStringAsFixed(7)),
      "max_lat": double.parse(maxLat.toStringAsFixed(7)),
      "min_lon": double.parse(minLon.toStringAsFixed(7)),
      "max_lon": double.parse(maxLon.toStringAsFixed(7))
    };
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295; // Math.PI / 180
    var c = math.cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    return 12742 * math.asin(math.sqrt(a)) * 1000; // Distance in meters
  }

  static double calculateZoomLevel(
      double centerLat, double mapEdgeLengthInMeters) {
    double zoomLevelFloat = math.log(156543.03392 *
            math.cos(centerLat * math.pi / 180) /
            (mapEdgeLengthInMeters / 256)) /
        math.ln2;
    return zoomLevelFloat.ceilToDouble();
  }
}
