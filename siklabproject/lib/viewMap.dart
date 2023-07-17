import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:siklabproject/viewSingleReportPage.dart';

class ViewMapReport extends StatefulWidget {
  String reportID;
  double latitude, longitude;

  ViewMapReport(this.reportID, this.latitude, this.longitude);

  @override
  _ViewMapReportState createState() => _ViewMapReportState();
}

class _ViewMapReportState extends State<ViewMapReport> {
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
            builder: (context) => viewSingleReportPage(widget.reportID)));
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
    Future.delayed(Duration(milliseconds: 500), () {
      _addMarker();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'REPORTED FIRE LOCATION VIA MAP',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            const Text(
              'Pin marker may not be accurate',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
    );
  }
}
