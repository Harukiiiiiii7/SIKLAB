import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:siklabproject/ConfirmReport.dart';
import 'package:siklabproject/cameraPage.dart';
import 'package:siklabproject/userDashboard.dart';

class ReportPageMoreDetails extends StatefulWidget {
  String reportID, picture;

  ReportPageMoreDetails(this.reportID, this.picture, {super.key});

  @override
  State<ReportPageMoreDetails> createState() => _ReportPageMoreDetailsState();
}

class _ReportPageMoreDetailsState extends State<ReportPageMoreDetails> {
  final List<CameraDescription> cameras = [];

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
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 50, left: 25, bottom: 5),
                              child: Text(
                                "REPORT FIRE INCIDENT $reportID",
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            )),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 25, bottom: 5),
                              child: Text(
                                "Fill up the following information.",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            )),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 25, bottom: 20),
                            child: Text(
                              "Enable your camera for authentication",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: Color.fromRGBO(226, 226, 226, 1),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30))),
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(height: 25),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black)),
                                              hintText:
                                                  "Select Location from Map",
                                              hintStyle: TextStyle(
                                                  color: Colors.black),
                                              labelText: "Location",
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              contentPadding: EdgeInsets.only(
                                                  left: 20, right: 20)),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
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
                                      const SizedBox(height: 5),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ConfirmReport(
                                                            widget.reportID,
                                                            value!,
                                                            value2!,
                                                            _contactNumberController
                                                                .text,
                                                            widget.picture)));
                                            print(
                                                _contactNumberController.text);
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
