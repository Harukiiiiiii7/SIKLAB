import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
  String currentTime = '';

  final items = ["Alarm 1", "Alarm 2", "Alarm 3"];
  String? value;
  final items2 = ["10-50", "51-100", "101-150", "151-200", "200+"];
  String? value2;

  void getCurrentTime() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now();
      setState(() {
        currentTime = '${now.hour}:${now.minute}:${now.second}';
      });
    });
  }

  void _goToNextScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Hotlines()));
  }

  void sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAr-Ab4QU:APA91bFktIXJCxmPZHoZ1907zxk5pB2IJmX5PZIEvMeV6Hby7AKBWcJBtjug9YXoungsoCKSTqLNtbTWk2ugraodXDO6cQViPOOla1oTWgJnrcF41Z-6-HE39rRkAuPdj-H0ZLiES83U',
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": "dbfood"
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("ERROR PARE");
      }
    }
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
                    onPressed: () async {
                      if (_contactNumberController.text != "" &&
                          _contactNumberController.text.length == 11) {
                        print(_contactNumberController.text.length);
                        DocumentSnapshot snap = await FirebaseFirestore.instance
                            .collection('admins')
                            .doc('+639190012251')
                            .get();

                        String token = snap['token'];
                        print(token);

                        // token, body, title
                        sendPushMessage(
                          token,
                          _remarksController.text,
                          'FIRE ALARM EMERGENCY - ${value!}',
                        );

                        DateTime now = DateTime.now();
                        String formattedDateTime =
                            DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

                        final report = FirebaseFirestore.instance
                            .collection('reports')
                            .doc(widget.reportID);

                        final json = {
                          'reportID': widget.reportID,
                          'time': currentTime,
                          'reportDate': formattedDateTime,
                          'userLocation': {
                            'latitude': widget.markerLocation.latitude,
                            'longitude': widget.markerLocation.longitude
                          },
                          'image': widget.image,
                          'contactNumber': _contactNumberController.text,
                          'severity': value,
                          'numberOfVictims': value2,
                          'remarks': _remarksController.text
                        };

                        report.set(json);

                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Report is successfully submitted. Please wait for a call from the authorities.')));
                        _goToNextScreen();
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("ERROR SUBMITTING REPORT"),
                                content: const Text(
                                    "Please fill up the necessary details."),
                                actions: <Widget>[
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shadowColor: const Color.fromRGBO(
                                              105, 105, 105, 1),
                                          backgroundColor: const Color.fromRGBO(
                                              171, 0, 0, 1)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("OK"))
                                ],
                              );
                            });
                      }
                    },
                    child: const Text("Yes"))
              ]);
        });
  }

  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _remarksController = TextEditingController();

  String formattedDate = '';

  @override
  void initState() {
    super.initState();
    getCurrentTime();
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
                                      //REMARKS FIELD
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: TextField(
                                          controller: _remarksController,
                                          decoration: const InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              labelText: "Remarks",
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              contentPadding: EdgeInsets.only(
                                                  left: 20, right: 20)),
                                          keyboardType: TextInputType.text,
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
