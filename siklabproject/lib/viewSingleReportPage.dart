import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:siklabproject/historyPage.dart';
import 'package:siklabproject/viewImage.dart';
import 'package:siklabproject/viewMap.dart';

class viewSingleReportPage extends StatefulWidget {
  String reportID;

  viewSingleReportPage(this.reportID, {super.key});

  @override
  State<viewSingleReportPage> createState() => _viewSingleReportPageState();
}

class _viewSingleReportPageState extends State<viewSingleReportPage> {
  String get documentId => widget.reportID;

  void _BackButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HistoryPage()));
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
              'VIEW REPORT DETAILS',
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

          return ListView(
            children: [
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
                title: const Text('Reporter Contact Number'),
                subtitle: Text('${data['contactNumber']}'),
              ),
              ListTile(
                onTap: () {
                  print(data['image']);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              viewImage(widget.reportID, data['image'])));
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
                          builder: (context) => ViewMapReport(
                              widget.reportID, latitude, longitude)));
                },
                title: const Text('Location via Map'),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ],
          );
        },
      ),
    );
  }
}