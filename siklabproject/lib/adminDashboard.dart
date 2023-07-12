import 'package:flutter/material.dart';
import 'package:siklabproject/historyPage.dart';
import 'package:siklabproject/loginAsPage.dart';
import 'package:siklabproject/viewReportPage.dart';

class AdminDashboard extends StatefulWidget {
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  void _BackButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginAsPage()));
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
              'ADMIN DASHBOARD',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            const Text(
              'View Fire Reports',
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
      resizeToAvoidBottomInset: false,
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
                                              viewReportPage())));
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
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text("VIEW LATEST",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1))),
                                      Text("FIRE REPORTS",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1)))
                                    ],
                                  ),
                                ])),
                            const SizedBox(height: 30),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              HistoryPage())));
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
                                  Image.asset('assets/history.png',
                                      height: 100, width: 100),
                                  const SizedBox(width: 25),
                                  const Text("VIEW HISTORY",
                                      style: TextStyle(
                                          fontSize: 24,
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
