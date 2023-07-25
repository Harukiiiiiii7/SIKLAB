import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:siklabproject/user_viewHistory.dart';
import 'package:siklabproject/user_viewSingleReportScreen.dart';

class User_ViewMapReport extends StatefulWidget {
  String reportID;
  double latitude, longitude;

  User_ViewMapReport(this.reportID, this.latitude, this.longitude);

  @override
  _User_ViewMapReportState createState() => _User_ViewMapReportState();
}

class _User_ViewMapReportState extends State<User_ViewMapReport> {
  late double lat, long;

  LatLng markerLocation = LatLng(0.0, 0.0);
  late MapboxMapController mapController;
  late Symbol marker;

  @override
  void initState() {
    super.initState();
  }

  void _BackButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                User_ViewSingleReportScreen(widget.reportID)));
  }

  void _addMarker() {
    if (mapController == null) {
      print("MapController is null. Cannot add marker.");
      return;
    }

    print("Adding marker at ${widget.latitude}, ${widget.longitude}");
    lat = widget.latitude;
    long = widget.longitude;

    markerLocation = LatLng(lat, long); // Move this line outside of setState

    mapController.addSymbol(SymbolOptions(
      geometry: markerLocation,
      iconImage: 'assets/marker2.png',
      iconSize: 0.2,
    ));
  }

  void _onMapCreated(MapboxMapController mapController) {
    this.mapController = mapController;
    print("Map created.");

    // Adding a slight delay to give the mapController enough time to initialize fully
    Future.delayed(const Duration(milliseconds: 500), () {
      _addMarker();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _BackButton();
        // Prevent default back button behavior
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FIRE LOCATION VIA MAP',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              Text(
                'Pin marker may not be accurate',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _BackButton,
          ),
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
                target: LatLng(widget.latitude, widget.longitude),
                zoom: 14,
              ),
              styleString:
                  'mapbox://styles/ezekielcapz/cliwlgup1004t01qqg0avgzeq',
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: false,
              //myLocationEnabled: true,
              zoomGesturesEnabled: true,
              dragEnabled: true,
              doubleClickZoomEnabled: true,
              //myLocationTrackingMode: MyLocationTrackingMode.TrackingCompass,
              //myLocationRenderMode: MyLocationRenderMode.COMPASS,
              //onUserLocationUpdated: (UserLocation location) {}
            ),
          ),
        ]),
      ),
    );
  }
}
