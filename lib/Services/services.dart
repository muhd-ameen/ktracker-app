import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
class LocationServices extends StatefulWidget {
  const LocationServices({key}) : super(key: key);

  @override
  LocationServicesState createState() => LocationServicesState();
}

class LocationServicesState extends State<LocationServices> {
  Position _position;
  StreamSubscription<Position> _streamSubscription;
   Address address;
  Future<Address> convertCoordinatesToAddress(Coordinates coordinates) async {
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

   location(String postalCode) {
    var locationOption =
    LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    _streamSubscription = Geolocator()
        .getPositionStream(locationOption)
        .listen((Position position) {
      setState(() {
        print(position);
        _position = position;
        final coordinates =
        new Coordinates(position.latitude, position.longitude);
        convertCoordinatesToAddress(coordinates)
            .then((value) => address = value);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
