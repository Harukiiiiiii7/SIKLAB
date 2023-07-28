import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:siklabproject/user_viewHistory.dart';
import 'package:siklabproject/user_viewImage.dart';
import 'package:siklabproject/user_viewMapReport.dart';
import 'package:siklabproject/viewImage.dart';
import 'package:siklabproject/viewMap.dart';

class User_ViewSingleReportScreen extends StatefulWidget {
  String reportID;

  User_ViewSingleReportScreen(this.reportID, {super.key});

  @override
  State<User_ViewSingleReportScreen> createState() =>
      _User_ViewSingleReportScreen();
}

class _User_ViewSingleReportScreen extends State<User_ViewSingleReportScreen> {
  String get documentId => widget.reportID;

  void _BackButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserHistoryScreen()));
  }

  String _convertDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat('MMMM d, y').format(parsedDate);
    return formattedDate;
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
                'VIEW REPORT DETAILS',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _BackButton,
          ),
          backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('reports')
              .doc(documentId)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text('Document does not exist.');
            }

            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            Map<String, dynamic> location = data['userLocation'];
            double latitude = location['latitude'];
            double longitude = location['longitude'];
            String date = data['reportDate'];

            return ListView(
              children: [
                ListTile(
                  title: const Text('Date'),
                  subtitle: Text(_convertDate(date)),
                ),
                ListTile(
                  title: const Text('Severity'),
                  subtitle: Text('${data['severity']}'),
                ),
                ListTile(
                  title: const Text('Approximate Number of Victims'),
                  subtitle: Text('${data['numberOfVictims']}'),
                ),
                ListTile(
                  title: const Text('Report Remarks'),
                  subtitle: Text('${data['remarks']}'),
                ),
                ListTile(
                  onTap: () {
                    print(data['image']);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => User_ViewImage(
                                widget.reportID, data['image'])));
                  },
                  title: const Text('View Image'),
                  trailing: const Icon(Icons.arrow_forward),
                ),
                ListTile(
                  onTap: () {
                    print(latitude);
                    print(longitude);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => User_ViewMapReport(
                                widget.reportID, latitude, longitude)));
                  },
                  title: const Text('Location via Map'),
                  trailing: const Icon(Icons.arrow_forward),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
