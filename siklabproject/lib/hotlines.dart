import 'package:flutter/material.dart';
import 'package:siklabproject/userDashboard.dart';

class Hotlines extends StatelessWidget {
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
                                builder: ((context) => UserDashboard())));
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
                      "LOCAL HOTLINES",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  )),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, bottom: 20),
                    child: Text(
                      "Local and National Hotlines Available 24/7",
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
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(height: 30),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 25, bottom: 15),
                                child: Text(
                                  "NATIONAL HOTLINES",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 35),
                                child: Text(
                                  "911 (National Emergency Hotline)",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 35),
                                child: Text(
                                  "117 (PNP National Hotline)",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 35),
                                child: Text(
                                  "136 (MMDA National Hotline)",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 25, bottom: 15),
                                child: Text(
                                  "LOCAL HOTLINES",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 35),
                                child: Text(
                                  "ANTIPOLO CITY",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "8696-9911 (Emergency Hotline)",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "8697-2409 (PNP Antipolo)",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "8871-2865 (BFP Antipolo)",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 35),
                                child: Text(
                                  "TAYTAY, RIZAL",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "8661-9887 (BFP Taytay)",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "8571-4858 (Taytay Emergency Hospital)",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "8284-4770 (Office of the Mayor)",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 35),
                                child: Text(
                                  "CAINTA, RIZAL",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "8535-0131 (Rescue 131 24/7)",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "8650-6175 (PNP Cainta)",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "8654-4977 (Cainta Fire Department)",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))),
            ],
          )),
    );
  }
}
