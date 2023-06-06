import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import 'appConstants.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String _locationMessage = '';
  late String _lat;
  late String _long;
  late double lat, long;

  late LatLng markerLocation = LatLng(14.55, 121.02);

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied");
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _locationMessage =
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}';

      _lat = '${position.latitude}';
      _long = '${position.longitude}';

      lat = double.parse(_lat);
      long = double.parse(_long);

      markerLocation = LatLng(lat, long);

      print(lat);
      print(long);
      print(markerLocation);
      print(_locationMessage);
    });
    // var location = Location();

    // if (!await location.serviceEnabled()) {
    //   if (!await location.requestService()) {
    //     return;
    //   }
    // }

    // var permission = await location.hasPermission();
    // if (permission == PermissionStatus.denied) {
    //   permission = await location.requestPermission();
    //   if (permission != PermissionStatus.granted) {
    //     return;
    //   }
    // }

    // markerLocation = (await location.getLocation()) as LatLng;
    // print("${markerLocation.latitude} ${markerLocation.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pin Location from Map'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              zoom: 13,
              center: markerLocation,
              interactiveFlags:
                  InteractiveFlag.drag | InteractiveFlag.pinchZoom,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/ezekielcapz/clgivju5a006901qudqmrhmcu/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZXpla2llbGNhcHoiLCJhIjoiY2xnODdtcWxhMDcxdjNocWxpOTJpeXlvdCJ9.hYBJ8R_gc4RT9jx0R0nteg",
                additionalOptions: {
                  'mapStyleId': AppConstants.mapBoxStyleId,
                  'accessToken': AppConstants.mapBoxAccessToken,
                },
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                      width: 80.0,
                      height: 80.0,
                      point: markerLocation,
                      builder: (ctx) => Container(
                            child: Icon(
                              Icons.location_pin,
                              color: Colors.red,
                            ),
                          ))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
