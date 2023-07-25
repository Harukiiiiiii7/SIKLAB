import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:siklabproject/confirmAddressPage.dart';

class MapBoxLocationScreen extends StatefulWidget {
  String reportID;

  MapBoxLocationScreen({
    required this.reportID,
  });

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<MapBoxLocationScreen> {
  late String _lat;
  late String _long;
  late double lat, long;

  //late LatLng markerLocation = LatLng(14.55, 121.02);
  late LatLng markerLocation;
  late MapboxMapController mapController;
  late Symbol marker;

  late LatLng coordinates;

  @override
  void initState() {
    print(widget.reportID);
    _getLocation();
    //mapController = MapboxMapController();
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
      _lat = '${position.latitude}';
      _long = '${position.longitude}';

      lat = double.parse(_lat);
      long = double.parse(_long);

      markerLocation = LatLng(lat, long);

      mapController
          .addSymbol(
            SymbolOptions(
              geometry: markerLocation,
              iconImage: 'assets/marker.png',
              iconSize: 0.2,
              // iconRotate: data['routes'][0]['legs'][0]['steps'][0]['intersections'][0]['bearings'][0].toDouble()
            ),
          )
          .then((value) => {marker = value});
    });
  }

  // void _onMapMoved(MapPosition position, bool hasGesture) {
  //   if (hasGesture) {
  //     setState(() {
  //       markerLocation = position.center as LatLng;
  //     });
  //   }
  // }

  void _onMapCreated(MapboxMapController mapController) {
    this.mapController = mapController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pin Location from Map'),
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
      ),
      body: Stack(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: MapboxMap(
              accessToken:
                  'sk.eyJ1IjoiZXpla2llbGNhcHoiLCJhIjoiY2xpd2t2aTB5MGpwZzNzbjV3a20ycWpidSJ9.nCx9DsseQnku9gaDSmim9w',
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(14.6760, 121.0437),
                zoom: 14,
              ),
              styleString:
                  'mapbox://styles/ezekielcapz/cliwlgup1004t01qqg0avgzeq',
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: false,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              dragEnabled: true,
              doubleClickZoomEnabled: true,
              myLocationTrackingMode: MyLocationTrackingMode.TrackingCompass,
              myLocationRenderMode: MyLocationRenderMode.COMPASS,
              onMapClick: (a, coord) {
                coordinates = coord;
                print(coord);
                mapController.updateSymbol(
                    marker, SymbolOptions(geometry: coord));
              },
              onUserLocationUpdated: (UserLocation location) {}),
        ),

        // Center(child: CircularProgressIndicator()),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: ElevatedButton(
            onPressed: () {
              print(markerLocation);
              print(widget.reportID);
              if (coordinates != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConfirmAddressPage(
                              reportID: widget.reportID,
                              markerLocation: coordinates,
                            )));
              }
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
