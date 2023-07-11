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

  void _BackButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(
                  title: '',
                )));
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
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'LOGIN',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
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
