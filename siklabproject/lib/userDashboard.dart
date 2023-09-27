import 'package:flutter/material.dart';
import 'package:siklabproject/hotlines.dart';
import 'package:siklabproject/userReportPage.dart';
import 'package:siklabproject/userSettingsPage.dart';

class UserDashboard extends StatefulWidget {
  String _mobileNumber;

  UserDashboard(this._mobileNumber, {super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  void _backButton() {
    Navigator.pushNamed(context, '/LoginPage');
  }

  void _goToUserSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => userSettingsPage(widget._mobileNumber)),
    );
  }

  void _goToReportPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => userReportPage(widget._mobileNumber)),
    );
  }

  late Size mediaSize;
  late Color myColor;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        _backButton();
        // Prevent default back button behavior
        return false;
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/firetruck.png"),
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(myColor.withOpacity(0.4), BlendMode.dstATop),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Positioned(top: 0, child: _buildTop()),
              Positioned(bottom: 0, child: _buildBottom()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTop() {
    return Container(
      color: Colors.white.withOpacity(0.75),
      child: SizedBox(
        width: mediaSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 20.0, right: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/account.png', height: 35, width: 35),
                  const Text(
                    "User Dashboard",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _goToUserSettings(),
                    icon: const Icon(Icons.settings, size: 35),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Positioned(
        bottom: 0,
        child: Card(
          color: Colors.white.withOpacity(0.75),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: _buildButtons(),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildReportFireButton(),
        const SizedBox(height: 20),
        _buildHotlinesButton(),
      ],
    );
  }

  Widget _buildReportFireButton() {
    return ElevatedButton(
      onPressed: () {
        _goToReportPage();
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(325, 175),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: const Color.fromRGBO(105, 105, 105, 1),
        backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      ),
      child: Row(
        children: [
          Image.asset('assets/fire.png', height: 100, width: 100),
          const SizedBox(width: 25),
          const Text(
            "REPORT FIRE",
            style: TextStyle(fontSize: 20, color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget _buildHotlinesButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Hotlines(widget._mobileNumber)),
        );
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(325, 175),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: const Color.fromRGBO(105, 105, 105, 1),
        backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      ),
      child: Row(
        children: [
          Image.asset('assets/hotline.png', height: 100, width: 100),
          const SizedBox(width: 25),
          const Text(
            "VIEW HOTLINES",
            style: TextStyle(fontSize: 20, color: Colors.black),
          )
        ],
      ),
    );
  }
}
