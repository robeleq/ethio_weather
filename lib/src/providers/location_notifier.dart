import 'package:ethio_weather/src/models/lat_long.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_location.dart';
import '../services/location_service.dart';

class LocationNotifier extends ChangeNotifier {
  UserLocation _userLocation = UserLocation(LatLong(8.9, 38.0), "Unknown");
  UserLocation get userLocation => _userLocation;

  final bool _hasInternetConnection;

  LocationNotifier(this._hasInternetConnection) {
    _getUserLocation(_hasInternetConnection);
  }

  _getUserLocation(bool hasInternetConnection) async {
    _userLocation = await LocationService().getUserLocation(hasInternetConnection);
    notifyListeners();
  }
}
