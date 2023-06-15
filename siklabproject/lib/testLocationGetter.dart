import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:siklabproject/confirmAddressPage.dart';

import 'appConstants.dart';

class LocationScreen extends StatefulWidget {
  String reportID;

  LocationScreen({
    required this.reportID,
  });

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late String _lat;
  late String _long;
  late double lat, long;

  //late LatLng markerLocation = LatLng(14.55, 121.02);
  late LatLng markerLocation = LatLng(0, 0);
  MapController mapController = MapController();

  @override
  void initState() {
    print(widget.reportID);
    _getLocation();
    mapController = MapController();
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
    setState(() async {
      _lat = '${position.latitude}';
      _long = '${position.longitude}';

      lat = double.parse(_lat);
      long = double.parse(_long);

      markerLocation = LatLng(lat, long);

      // markerLocation = await mapController.addSymbol
      //   (
      //       SymbolOptions
      //       (
      //           geometry: location,
      //           iconImage: 'assets/images/location-pin.png',
      //           iconSize: 0.2,
      //       ),
      //   );
      print(lat);
      print(long);
      print(markerLocation);
    });
  }

  void _onMapMoved(MapPosition position, bool hasGesture) {
    if (hasGesture) {
      setState(() {
        markerLocation = position.center!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pin Location from Map'),
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
      ),
      body: Stack(children: [
        if (markerLocation.latitude != 0 &&
            markerLocation.longitude != 0) // Check if markerLocation is updated
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              zoom: 16,
              center: markerLocation,
              onPositionChanged: _onMapMoved,
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
                      width: 30.0,
                      height: 30.0,
                      point: markerLocation,
                      anchorPos: AnchorPos.align(AnchorAlign.top),
                      builder: (ctx) => const Icon(
                            Icons.location_pin,
                            color: Color.fromARGB(255, 223, 18, 18),
                            size: 45.0,
                          ))
                ],
              ),
            ],
          ),
        if (markerLocation.latitude == 0 &&
            markerLocation.longitude ==
                0) // Display a loading indicator or placeholder if markerLocation is not updated yet
          Center(child: CircularProgressIndicator()),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: ElevatedButton(
            onPressed: () {
              // print(markerLocation);
              // print(widget.reportID);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ConfirmAddressPage(
              //             reportID: widget.reportID,
              //             markerLocation: markerLocation)));
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(350, 50),
                shape: const StadiumBorder(),
                shadowColor: const Color.fromRGBO(105, 105, 105, 1),
                backgroundColor: const Color.fromRGBO(171, 0, 0, 1)),
            child: const Text("SET LOCATION",
                style: TextStyle(fontSize: 20, color: Colors.white)),
          ),
        ),
      ]),
    );
  }
}
