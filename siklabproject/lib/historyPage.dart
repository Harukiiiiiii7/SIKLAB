import 'package:flutter/material.dart';
import 'package:siklabproject/adminDashboard.dart';

class HistoryPage extends StatelessWidget {
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
                                builder: ((context) => AdminDashboard())));
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
                      "FIRE INCIDENT HISTORY",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  )),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, bottom: 25),
                    child: Text(
                      "Press a report to view details.",
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
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(350, 50),
                                    shape: const StadiumBorder(),
                                    shadowColor:
                                        const Color.fromRGBO(105, 105, 105, 1),
                                    backgroundColor:
                                        const Color.fromRGBO(248, 248, 248, 1)),
                                child: const Text("APRIL 3, 2023 - CAINTA",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black))),
                            const SizedBox(height: 10),
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
                                  "MARCH 29, 2023 - ANTIPOLO",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                )),
                            const SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(350, 50),
                                    shape: const StadiumBorder(),
                                    shadowColor:
                                        const Color.fromRGBO(105, 105, 105, 1),
                                    backgroundColor:
                                        const Color.fromRGBO(248, 248, 248, 1)),
                                child: const Text("MARCH 24, 2023 - TAYTAY",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black))),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ))),
            ],
          )),
    );
  }
}
