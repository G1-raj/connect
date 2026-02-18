import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    //to check if location is enabled or not
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      throw Exception("Location service is disabled");
    }

    //check location permission is granted
    LocationPermission locationPermission = await Geolocator.checkPermission();

    //if their is no permission to use location then ask a permission
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied) {
        throw Exception("Location permission is denied");
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      throw Exception("Location permission is denied permanently");
    }

    //get longitude and latitude if permission is granted
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
