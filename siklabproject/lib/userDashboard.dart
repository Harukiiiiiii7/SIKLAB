import 'package:flutter/material.dart';
import 'package:siklabproject/addReportPage.dart';
import 'package:siklabproject/hotlines.dart';
import 'package:siklabproject/loginAsPage.dart';
import 'package:siklabproject/user_viewHistory.dart';

class UserDashboard extends StatefulWidget {
  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  void _BackButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginAsPage()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _BackButton();
        // Prevent default back button behavior
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DASHBOARD',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              Text(
                'Report Incident and View Hotlines.',
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _BackButton,
          ),
          backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
        ),
        body: SingleChildScrollView(
          // Wrap the main container with SingleChildScrollView
          child: Container(
            height: MediaQuery.of(context)
                .size
                .height, // Use MediaQuery to set the height to the screen height
            width: double.infinity,
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
                          const SizedBox(height: 30),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => ReportPage())));
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(325, 175),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
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
                                      borderRadius: BorderRadius.circular(12)),
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
                              ])),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => UserHistoryScreen()),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(325, 175),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                shadowColor:
                                    const Color.fromRGBO(105, 105, 105, 1),
                                backgroundColor:
                                    const Color.fromRGBO(248, 248, 248, 1)),
                            child: Row(
                              children: [
                                Image.asset('assets/history.png',
                                    height: 100, width: 100),
                                const SizedBox(width: 25),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "VIEW OTHER",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                    ),
                                    Text(
                                      "FIRE REPORTS",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
