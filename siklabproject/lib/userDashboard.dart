import 'package:flutter/material.dart';
import 'package:siklabproject/addReportPage.dart';
import 'package:siklabproject/hotlines.dart';
import 'package:siklabproject/loginAsPage.dart';

class UserDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                builder: ((context) => LoginAsPage())));
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
                      "DASHBOARD",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  )),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, bottom: 20),
                    child: Text(
                      "Report and View Emergency Hotlines",
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
