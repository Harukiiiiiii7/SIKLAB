import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:siklabproject/historyPage.dart';
import 'package:siklabproject/viewImage.dart';
import 'package:siklabproject/viewMap.dart';
import 'package:url_launcher/url_launcher.dart';

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

  String _convertDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat('MMMM d, y').format(parsedDate);
    return formattedDate;
  }

  void _deleteDocument(String reportID) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete fire report'),
            content: const Text(
                "Are you sure you want to delete this fire report? Deleting a report will be gone forever."),
            actions: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: const Color.fromRGBO(105, 105, 105, 1),
                      backgroundColor: const Color.fromRGBO(171, 0, 0, 1)),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('reports')
                        .doc(reportID)
                        .delete();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Fire Report is successfully deleted.')));
                    _BackButton();
                  },
                  child: const Text("OK"))
            ],
          );
        });
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
                  title: const Text('Reporter Contact Number'),
                  subtitle: Text('${data['contactNumber']}'),
                  trailing: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(255, 11, 11, 1),
                          offset: Offset.zero,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.phone,
                      ),
                      onPressed: () {
                        // ignore: deprecated_member_use
                        launch('tel:${data['contactNumber']}');
                      },
                      color: Colors.white,
                    ),
                  ),
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
                ListTile(
                  onTap: () {
                    _deleteDocument(widget.reportID);
                  },
                  title: const Text('Delete Report'),
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
