import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:siklabproject/cameraPage.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class ConfirmAddressPage extends StatefulWidget {
  String reportID;
  LatLng markerLocation;

  ConfirmAddressPage({
    required this.reportID,
    required this.markerLocation,
  });

  @override
  State<ConfirmAddressPage> createState() => _confirmAddressPage();
}

class _confirmAddressPage extends State<ConfirmAddressPage> {
  String address = '';
  TextEditingController addressController = TextEditingController();

  final List<CameraDescription> cameras = [];

  Future<void> _initializeCameras() async {
    cameras.clear();
    cameras.addAll(await availableCameras());
  }

  @override
  void initState() {
    print(widget.reportID);
    print(widget.markerLocation);
    _convertLatLngToAddress();
    super.initState();
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
              'Confirm Address',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            Text(
              'Please enable Camera Permission.',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
      ),
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Expanded(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              color: const Color.fromRGBO(226, 226, 226, 1),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    address,
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 15),
                                  ElevatedButton(
                                      onPressed: () async {
                                        await _initializeCameras();
                                        final camera = cameras.first;
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CameraScreen(
                                                    camera: camera,
                                                    reportID: widget.reportID,
                                                    latLng:
                                                        widget.markerLocation,
                                                  )),
                                        );
                                        if (result != null) {
                                          print('Image saved to $result');
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(325, 175),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          shadowColor: const Color.fromRGBO(
                                              105, 105, 105, 1),
                                          backgroundColor: const Color.fromRGBO(
                                              248, 248, 248, 1)),
                                      child: Row(children: [
                                        const SizedBox(width: 15),
                                        Image.asset('assets/camera.png',
                                            height: 90, width: 90),
                                        const SizedBox(width: 25),
                                        const Text("OPEN CAMERA",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1)))
                                      ])),
                                ],
                              ),
                            ))),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _convertLatLngToAddress() async {
    double lat = widget.markerLocation.latitude;
    double long = widget.markerLocation.longitude;
    final placemarks = await placemarkFromCoordinates(lat, long);

    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      final formattedAddress =
          '${placemark.street}, ${placemark.locality} ${placemark.postalCode}';
      setState(() {
        address = formattedAddress;
      });
    }
  }
}
