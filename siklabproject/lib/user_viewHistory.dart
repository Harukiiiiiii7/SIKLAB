import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:siklabproject/userDashboard.dart';
import 'package:siklabproject/user_viewSingleReportScreen.dart';

class UserHistoryScreen extends StatefulWidget {
  @override
  State<UserHistoryScreen> createState() => _UserHistoryScreenState();
}

class _UserHistoryScreenState extends State<UserHistoryScreen> {
  List<String> addresses = [];
  List<DocumentSnapshot> sortedDocuments = [];

  String formatReportIDToDateString(String reportID) {
    String year = reportID.substring(0, 4);
    String month = reportID.substring(4, 6);
    String day = reportID.substring(6, 8);

    DateTime dateTime =
        DateTime(int.parse(year), int.parse(month), int.parse(day));
    return DateFormat('MMM d, yyyy').format(dateTime);
  }

  void _BackButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserDashboard()));
  }

  late Stream<QuerySnapshot> _documentsStream;

  Future<void> convertAddresses() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('reports')
          .orderBy('reportDate', descending: true)
          .get();

      sortedDocuments = querySnapshot.docs;

      for (DocumentSnapshot doc in sortedDocuments) {
        Map<String, dynamic> location = doc['userLocation'];
        double latitude = location['latitude'];
        double longitude = location['longitude'];

        await getAddressFromLatLng(latitude, longitude);
      }
    } catch (e) {
      setState(() {
        addresses.add('Error: $e');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _documentsStream =
        FirebaseFirestore.instance.collection('reports').snapshots();
    convertAddresses();
  }

  List<DocumentSnapshot> sortDocumentsByReportDate(
      List<DocumentSnapshot> documents) {
    documents.sort((a, b) {
      var aData = a.data() as Map<String, dynamic>;
      var bData = b.data() as Map<String, dynamic>;

      DateTime aDate = DateTime.parse(aData['reportDate']);
      DateTime bDate = DateTime.parse(bData['reportDate']);

      return bDate.compareTo(aDate);
    });

    return documents;
  }

  Future<void> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      String address =
          '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
      setState(() {
        addresses.add(address);
      });
    } catch (e) {
      setState(() {
        addresses.add('Error: $e');
      });
    }
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
                'VIEW FIRE REPORTS',
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
        body: StreamBuilder<QuerySnapshot>(
          stream: _documentsStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            List<DocumentSnapshot> documents = snapshot.data!.docs;
            documents = sortDocumentsByReportDate(documents);

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final document = documents[index];
                final data = document.data() as Map<String, dynamic>;
                final reportID = data['reportID'];
                final severity = data['severity'];
                final time = data['time'];

                String address =
                    index < addresses.length ? addresses[index] : '';
                String formattedReportID = formatReportIDToDateString(reportID);

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListTile(
                    onTap: () {
                      print(reportID);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              User_ViewSingleReportScreen(reportID),
                        ),
                      );
                    },
                    title: Text(
                        formattedReportID + ' - ' + time + ' - ' + severity),
                    subtitle: Text(address),
                    trailing: const Icon(Icons.arrow_forward));
              },
            );
          },
        ),
      ),
    );
  }
}
