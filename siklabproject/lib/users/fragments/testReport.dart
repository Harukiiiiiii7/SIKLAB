import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:siklabproject/users/fragments/newUserDashboard.dart';

class userReportPagev2 extends StatefulWidget {
  String _mobileNumber;

  userReportPagev2(this._mobileNumber);

  @override
  State<userReportPagev2> createState() => _UserReportPagev2State();
}

class _UserReportPagev2State extends State<userReportPagev2> {
  late String _lat;
  late String _long;
  late double lat, long;

  //late LatLng markerLocation = LatLng(14.55, 121.02);
  late LatLng markerLocation;
  late MapboxMapController mapController;
  late Symbol marker;

  late LatLng coordinates;

  late String address = '';

  final assistanceList = [
    "None",
    "Police Assistance Needed",
    "Advance Cardiac Life Support Needed"
  ];
  String? assistance;

  @override
  void initState() {
    print(widget._mobileNumber);
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

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        debugPrint(
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}");
        lat = position.latitude;
        long = position.longitude;
        _lat = position.latitude.toString();
        _long = position.longitude.toString();
        _convertLatLngToAddress(lat, long);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _convertLatLngToAddress(double lat, double long) async {
    debugPrint(lat.toString());
    debugPrint(long.toString());
    final placemarks = await placemarkFromCoordinates(lat, long);

    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      final formattedAddress =
          '${placemark.street}, ${placemark.locality} ${placemark.postalCode}';
      setState(() {
        address = formattedAddress;
        debugPrint(address);
      });
    }
  }

  void _onMapCreated(MapboxMapController mapController) {
    this.mapController = mapController;
  }

  void _goToDashboard() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => newUserDashboard(widget._mobileNumber)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'REPORT A FIRE INCIDENT',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ],
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              _goToDashboard();
            }),
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildMap(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 8.0),
              child: _buildSetLocationButton(),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: _buildForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMap() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: MapboxMap(
          accessToken:
              'sk.eyJ1IjoiZXpla2llbGNhcHoiLCJhIjoiY2xpd2t2aTB5MGpwZzNzbjV3a20ycWpidSJ9.nCx9DsseQnku9gaDSmim9w',
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(14.6760, 121.0437),
            zoom: 14,
          ),
          styleString: 'mapbox://styles/ezekielcapz/cliwlgup1004t01qqg0avgzeq',
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
            mapController.updateSymbol(marker, SymbolOptions(geometry: coord));

            var lat = coordinates.latitude;
            var long = coordinates.longitude;
            _convertLatLngToAddress(lat, long);
          },
          onUserLocationUpdated: (UserLocation location) {}),
    );
  }

  Widget _buildSetLocationButton() {
    return ElevatedButton(
      onPressed: () {
        print("Coordinates $coordinates");
        // var lat = coordinates.latitude;
        // var long = coordinates.longitude;
        // debugPrint("Lat: $lat");
        // debugPrint("Long: $long");
        // _convertLatLngToAddress(lat, long);
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        shadowColor: const Color.fromRGBO(105, 105, 105, 1),
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text("Set Location",
          style: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGreyText("Address: $address"),
        const SizedBox(height: 20),
        _buildGreyText("Barangay: "),
        const SizedBox(height: 20),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 2.0),
            ),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: assistance,
            items: assistanceList.map(_assistanceItems).toList(),
            onChanged: (value) => setState(
              () {
                assistance = value;
                debugPrint(value);
              },
            ),
            hint: const Text("Select Special Assistance"),
          ),
        ),
        const SizedBox(height: 20),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        DateTime now = DateTime.now();
        String formattedDateTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

        debugPrint("Mobile Number: ${widget._mobileNumber}");
        debugPrint("Time: $formattedDateTime");
        debugPrint("Latitude: $_lat");
        debugPrint("Longitude: $_long");
        debugPrint("Address: $address");
        debugPrint("Assistance: $assistance");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
        shape: const StadiumBorder(),
        elevation: 20,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "Submit Report",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  DropdownMenuItem<String> _assistanceItems(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      );
}
