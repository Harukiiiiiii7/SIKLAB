import 'package:flutter/material.dart';
import 'package:siklabproject/adminDashboard.dart';
import 'package:siklabproject/main.dart';
import 'package:siklabproject/userDashboard.dart';

class LoginAsPage extends StatefulWidget {
  @override
  State<LoginAsPage> createState() => _LoginAsPageState();
}

class _LoginAsPageState extends State<LoginAsPage> {
  TextEditingController _passwordController = TextEditingController();

  void _goToNextScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminDashboard()));
  }

  void _showPasswordDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Enter Admin Password"),
              content: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: "Password"),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_passwordController.text == "admin123") {
                        Navigator.of(context).pop();
                        _goToNextScreen();
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Wrong Password"),
                                content: const Text("Please try again."),
                                actions: <Widget>[
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("OK"))
                                ],
                              );
                            });
                      }
                    },
                    child: const Text("Submit"))
              ]);
        });
  }

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
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) => MyApp())));
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
                    padding: EdgeInsets.only(left: 25, bottom: 20),
                    child: Text(
                      "LOG IN AS...",
                      style: TextStyle(fontSize: 24, color: Colors.white),
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
                                              UserDashboard())));
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(275, 175),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    shadowColor:
                                        const Color.fromRGBO(105, 105, 105, 1),
                                    backgroundColor:
                                        const Color.fromRGBO(248, 248, 248, 1)),
                                child: Row(children: [
                                  Image.asset('assets/account.png',
                                      height: 100, width: 100),
                                  const SizedBox(width: 25),
                                  const Text("USER",
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Color.fromRGBO(0, 0, 0, 1)))
                                ])),
                            const SizedBox(height: 30),
                            ElevatedButton(
                                onPressed: () {
                                  _showPasswordDialog();
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(275, 175),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    shadowColor:
                                        const Color.fromRGBO(105, 105, 105, 1),
                                    backgroundColor:
                                        const Color.fromRGBO(248, 248, 248, 1)),
                                child: Row(children: [
                                  Image.asset('assets/admin.png',
                                      height: 100, width: 100),
                                  const SizedBox(width: 25),
                                  const Text("ADMIN",
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
