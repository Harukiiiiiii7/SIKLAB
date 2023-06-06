import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siklabproject/addReportPage.dart';

class ConfirmReport extends StatefulWidget {
  String reportID, severity, victims, contactNumber, picture;

  ConfirmReport(this.reportID, this.severity, this.victims, this.contactNumber,
      this.picture,
      {super.key});

  @override
  State<ConfirmReport> createState() => _ConfirmReportState();
}

class _ConfirmReportState extends State<ConfirmReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromRGBO(171, 0, 0, 1),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.only(top: 35, right: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ReportPage())));
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(35, 55),
                          shadowColor: const Color.fromRGBO(105, 105, 105, 1),
                          backgroundColor:
                              const Color.fromRGBO(248, 248, 248, 1)),
                      child: Image.asset('assets/log-out.png',
                          height: 50, width: 50),
                    )),
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, bottom: 5),
                    child: Text(
                      "VERIFY FIRE INCIDENT REPORT",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  )),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, bottom: 5),
                    child: Text(
                      "Please check the following information before pressing Submit",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  )),
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
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: TextField(
                                textAlign: TextAlign.center,
                                readOnly: true,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    // hintText: "Select Location from Map",
                                    // hintStyle: TextStyle(color: Colors.black),
                                    labelText: "Location",
                                    labelStyle: TextStyle(color: Colors.black),
                                    contentPadding:
                                        EdgeInsets.only(left: 20, right: 20)),
                              ),
                            ),
                            const SizedBox(height: 5),
                            //SEVERITY
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                    //labelText: "Fire Severity",
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                child: Text(widget.severity),
                              ),
                            ),
                            const SizedBox(height: 5),
                            //APPROX VICTIMS DROPDOWN
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                    //labelText: "Fire Severity",
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                child: Text(widget.victims),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                    //labelText: "Fire Severity",
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                child: Text(widget.contactNumber),
                              ),
                            ),
                            const SizedBox(height: 5),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(350, 50),
                                    shape: const StadiumBorder(),
                                    shadowColor:
                                        const Color.fromRGBO(105, 105, 105, 1),
                                    backgroundColor:
                                        const Color.fromRGBO(248, 248, 248, 1)),
                                child: const Text(
                                  "VIEW IMAGE",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                )),
                            const SizedBox(height: 5),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(350, 50),
                                    shape: const StadiumBorder(),
                                    shadowColor:
                                        const Color.fromRGBO(105, 105, 105, 1),
                                    backgroundColor:
                                        const Color.fromRGBO(248, 248, 248, 1)),
                                child: const Text(
                                  "SUBMIT REPORT",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ))
                          ],
                        ),
                      ))),
            ],
          )),
    );
  }
}
