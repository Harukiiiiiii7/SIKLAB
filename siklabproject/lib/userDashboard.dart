import 'package:flutter/material.dart';
import 'package:siklabproject/addReportPage.dart';
import 'package:siklabproject/hotlines.dart';

class UserDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'DASHBOARD',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            const Text(
              'Report Incident and View Hotlines.',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
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
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(height: 110),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              ReportPage())));
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(325, 175),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    shadowColor:
                                        const Color.fromRGBO(105, 105, 105, 1),
                                    backgroundColor:
                                        const Color.fromRGBO(248, 248, 248, 1)),
                                child: Row(children: [
                                  Image.asset('assets/fire.png',
                                      height: 100, width: 100),
                                  const SizedBox(width: 25),
                                  const Text("REPORT FIRE",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromRGBO(0, 0, 0, 1)))
                                ])),
                            const SizedBox(height: 30),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => Hotlines())));
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(325, 175),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    shadowColor:
                                        const Color.fromRGBO(105, 105, 105, 1),
                                    backgroundColor:
                                        const Color.fromRGBO(248, 248, 248, 1)),
                                child: Row(children: [
                                  Image.asset('assets/hotline.png',
                                      height: 100, width: 100),
                                  const SizedBox(width: 25),
                                  const Text("VIEW HOTLINES",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromRGBO(0, 0, 0, 1)))
                                ]))
                          ],
                        ),
                      ))),
            ],
          )),
    );
  }
}
