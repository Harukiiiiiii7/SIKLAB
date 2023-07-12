import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class ViewMapReport extends StatefulWidget {
  String reportID;
  double latitude, longitude;

  ViewMapReport(this.reportID, this.latitude, this.longitude);

  @override
  _ViewMapReportState createState() => _ViewMapReportState();
}

class _ViewMapReportState extends State<ViewMapReport> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
