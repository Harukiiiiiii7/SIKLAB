import 'package:flutter/material.dart';
import 'package:siklabproject/addReportPage.dart';
import 'package:siklabproject/adminDashboard.dart';
import 'package:siklabproject/historyPage.dart';
import 'package:siklabproject/loginAsPage.dart';
import 'package:siklabproject/userDashboard.dart';
import 'package:siklabproject/viewReportPage.dart';
import 'hotlines.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Capston'), // main page
      //home: LoginAsPage(),
      //home: UserDashboard(),
      //home: AdminDashboard(),
      //home: ReportPage(),
      //home: Hotlines(),
      //home: viewReportPage(),
      //home: HistoryPage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginAsPage()));
        },
        child: Scaffold(
          body: Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 0, 0, .61),
                      Color.fromRGBO(255, 0, 0, 1),
                      Color.fromRGBO(255, 0, 0, .61),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.5, 1],
                    tileMode: TileMode.clamp)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/firefighter.png',
                      height: 175, width: 175),
                  const Text(
                    "SIKLAB",
                    style: TextStyle(fontSize: 48.0, color: Colors.white),
                  ),
                  const Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Tap the screen to continue",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      )),
                ]),
          ),
        ));
  }
}
