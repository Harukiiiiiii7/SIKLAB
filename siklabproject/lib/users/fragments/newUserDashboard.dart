import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siklabproject/users/fragments/hotlines.dart';
import 'package:siklabproject/users/fragments/userProfile.dart';
import 'package:siklabproject/users/fragments/userReportPage.dart';
import 'package:siklabproject/users/fragments/userSettingsPage.dart';
//import 'package:siklabproject/users/fragments/testReport.dart';

import '../userPreferences/current_user.dart';

class newUserDashboard extends StatefulWidget {
  CurrentUser rememberCurrentUser = Get.put(CurrentUser());

  String _mobileNumber;

  newUserDashboard(this._mobileNumber, {super.key});

  @override
  State<newUserDashboard> createState() => _newUserDashboardState();
}

class _newUserDashboardState extends State<newUserDashboard> {
  /*void _backButton() {
    Navigator.pushNamed(context, '/LoginPage');
  }*/

  void _goToUserProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserProfile()),
    );
  }

  void _goToHotlines() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Hotlines(widget._mobileNumber)),
    );
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
        //_backButton();
        // Prevent default back button behavior
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("USER DASHBOARD"),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                _goToUserSettings();
              },
            ),
            IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  _goToUserProfile();
                }),
          ],
          backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
          elevation: 50.0,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: _buildTop(),
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      "Recent Reports from Antipolo City",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              _buildListView(),
            ],
          ),
        ),
      ),
    );
    /*return GetBuilder(
      init: CurrentUser(),
      initState: (currentState){
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller){
        return Scaffold(

        );
      },
    );*/
  }

  Widget _buildTop() {
    return SizedBox(
      //height: 150,
      width: mediaSize.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: const Color.fromARGB(255, 253, 250, 250),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _goToReportPage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 214, 212, 212),
                    shape: const StadiumBorder(),
                    elevation: 20,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.fire_truck_outlined),
                      SizedBox(width: 50),
                      Text("REPORT FIRE"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _goToHotlines();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 214, 212, 212),
                    shape: const StadiumBorder(),
                    elevation: 20,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 50),
                      Text("VIEW HOTLINES"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: 10,
      padding: const EdgeInsets.all(12.0),
      itemBuilder: (context, index) => const ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.fireplace),
            SizedBox(width: 30),
            Text("William Rey"),
          ],
        ),
      ),
    );
  }

  List<String> names = ['Taylor Swift', 'The Weeknd', 'William Rey'];
}
