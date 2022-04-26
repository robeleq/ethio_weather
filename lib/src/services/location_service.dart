import 'package:ethio_weather/src/models/user_location.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/lat_long.dart';

class LocationService {
  Future<LatLong> getUserCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // Permissions are granted and access the position of the device.
    Position _position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return LatLong(_position.latitude, _position.longitude);
  }

  Future<String> getAddressFromLatLong(LatLong position) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placeMarks[0];
    String address = '${place.subLocality}, ${place.locality}, ${place.isoCountryCode}';
    return address;
  }

  Future<UserLocation> getUserLocation(bool hasInternetConnection) async {
    LatLong _latLong = await getUserCurrentLocation();
    if (hasInternetConnection) {
      String _address = await getAddressFromLatLong(_latLong);
      return UserLocation(_latLong, _address);
    }
    return UserLocation(_latLong, "Unknown Address");
  }
}
