import 'package:ethio_weather/src/models/lat_long.dart';

class UserLocation {
  final LatLong latLong;
  final String address;

  UserLocation(this.latLong, this.address);
}
