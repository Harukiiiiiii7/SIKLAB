import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:siklabproject/historyPage.dart';
import 'package:siklabproject/viewImage.dart';
import 'package:siklabproject/viewMap.dart';

class viewLatestReportPage extends StatefulWidget {
  @override
  State<viewLatestReportPage> createState() => _viewLatestReportPageState();
}

class _viewLatestReportPageState extends State<viewLatestReportPage> {
  String reportID = '';
  String address = '';

  void _BackButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HistoryPage()));
  }

  Future<String> _fetchAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      return '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
    } catch (e) {
      print(e);
      return "Error fetching the address";
    }
  }

  Future<String> convertAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      return '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
    } catch (e) {
      print(e);
      return "Error fetching the address";
    }
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
              'VIEW LATEST REPORT DETAILS',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('reports')
            .orderBy('reportDate', descending: true)
            .limit(1)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text('Document does not exist.');
          }

          var latestDocument = snapshot.data!.docs.first;
          Map<String, dynamic> data =
              latestDocument.data() as Map<String, dynamic>;

          Map<String, dynamic> location = data['userLocation'];
          double latitude = location['latitude'];
          double longitude = location['longitude'];

          reportID = data['reportID'];

          return FutureBuilder<String>(
            future: _fetchAddress(latitude, longitude),
            builder:
                (BuildContext context, AsyncSnapshot<String> addressSnapshot) {
              if (addressSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (addressSnapshot.hasError) {
                return Text('Error: ${addressSnapshot.error}');
              }

              address = addressSnapshot.data ?? "Address not available";

              // Return the ListView with the fetched address and other details
              return ListView(
                children: [
                  ListTile(
                    title: const Text('Address'),
                    subtitle: Text(address),
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
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              viewImage(reportID, data['image']),
                        ),
                      );
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
                          builder: (context) =>
                              ViewMapReport(reportID, latitude, longitude),
                        ),
                      );
                    },
                    title: const Text('Location via Map'),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
