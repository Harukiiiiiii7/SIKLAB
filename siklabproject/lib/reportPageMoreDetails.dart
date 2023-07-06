import 'dart:math';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:siklabproject/hotlines.dart';

class ReportPageMoreDetails extends StatefulWidget {
  String reportID;
  String image;
  LatLng markerLocation;

  ReportPageMoreDetails(this.reportID, this.image, this.markerLocation,
      {super.key});

  @override
  State<ReportPageMoreDetails> createState() => _ReportPageMoreDetailsState();
}

class _ReportPageMoreDetailsState extends State<ReportPageMoreDetails> {
  final List<CameraDescription> cameras = [];

  void _goToNextScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Hotlines()));
  }

  void _showConfirmDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Confirm Fire Incident Report"),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: const Color.fromRGBO(105, 105, 105, 1),
                      backgroundColor: Color.fromARGB(255, 110, 109, 109)),
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: const Color.fromRGBO(105, 105, 105, 1),
                        backgroundColor: const Color.fromRGBO(171, 0, 0, 1)),
                    onPressed: () {
                      FirebaseFirestore.instance.collection('reports').add({
                        'reportID': reportID,
                        'userLocation': {
                          'latitude': widget.markerLocation.latitude,
                          'longitude': widget.markerLocation.longitude
                        },
                        'image': widget.image,
                        'contactNumber': _contactNumberController.text,
                        'severity': value,
                        'numberOfVictims': value2
                      });
                      Navigator.of(context).pop();
                      _goToNextScreen();
                    },
                    child: const Text("Yes"))
              ]);
        });
  }

  Future<void> _initializeCameras() async {
    cameras.clear();
    cameras.addAll(await availableCameras());
  }

  final items = [
    "Fire Severity 1",
    "Fire Severity 2",
    "Fire Severity 3",
    "Fire Severity 4",
    "Fire Severity 5",
    "Fire Severity 6",
    "Fire Severity 7",
    "Fire Severity 8",
    "Fire Severity 9",
    "Fire Severity 10"
  ];
  String? value;
  final items2 = ["10-50", "51-100", "101-150", "151-200", "200+"];
  String? value2;

  TextEditingController _contactNumberController = TextEditingController();

  String formattedDate = '';
  String reportID = '';

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);

    Random random = Random();
    int randomNumber = random.nextInt(100);

    reportID = formattedDate + randomNumber.toString();
    reportID = reportID.replaceAll("-", "");
    print(reportID);
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
              'MORE DETAILS',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
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
                child: Container(
                    color: const Color.fromRGBO(171, 0, 0, 1),
                    child: Column(
                      children: [
                        Expanded(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(226, 226, 226, 1),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //SEVERITY DROPDOWN
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            isExpanded: true,
                                            value: value,
                                            items: items
                                                .map(buildSeverityItem)
                                                .toList(),
                                            onChanged: (value) => setState(
                                              () {
                                                this.value = value;
                                                print(value);
                                              },
                                            ),
                                            hint: const Text(
                                                "Select Fire Severity"),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      //APPROX VICTIMS DROPDOWN
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: value2,
                                              items: items2
                                                  .map(buildVictimsItem)
                                                  .toList(),
                                              onChanged: (value2) =>
                                                  setState(() {
                                                    this.value2 = value2;
                                                    print(value2);
                                                  }),
                                              hint: const Text(
                                                  "Select Approx Number of Victims")),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 30, right: 30),
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: TextField(
                                          controller: _contactNumberController,
                                          decoration: const InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              labelText: "Contact Number",
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              contentPadding: EdgeInsets.only(
                                                  left: 20, right: 20)),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      ElevatedButton(
                                          onPressed: () {
                                            _showConfirmDialog();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: const Size(350, 50),
                                              shape: const StadiumBorder(),
                                              shadowColor: const Color.fromRGBO(
                                                  105, 105, 105, 1),
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      248, 248, 248, 1)),
                                          child: const Text(
                                            "SUBMIT REPORT",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          )),
                                    ],
                                  ),
                                ))),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildSeverityItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      );
  DropdownMenuItem<String> buildVictimsItem(String item2) => DropdownMenuItem(
        value: item2,
        child: Text(
          item2,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      );
}
