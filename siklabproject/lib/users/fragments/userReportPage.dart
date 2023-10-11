import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:siklabproject/users/fragments/newUserDashboard.dart';
import 'package:http/http.dart' as http;
import '../../api_connection/api_connection.dart';

class userReportPage extends StatefulWidget {
  
  String _mobileNumber;// to get the contactNum

  userReportPage(this._mobileNumber, {super.key});
  
  @override
  State<userReportPage> createState() => _UserReportPageState();
}

class _UserReportPageState extends State<userReportPage> {
  void _backButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => newUserDashboard(widget._mobileNumber)),
    );
  }
  
  late String validNum;
  var contactNumController;

  var timeStamp = TextEditingController();

  late Size mediaSize;
  late Color myColor;

  String? _lat;
  String? _long;
  late double lat, long;

  late String address = '';

  final assistanceList = [
    "None",
    "Police Assistance Needed",
    "Advance Cardiac Life Support Needed"
  ];
  String? assistance;
  String? userIdFound;
  String? formattedDateTime;
  
  //Function here

  Future<String?> fetchUserID(String contactNum) async{
    final response = await http.post(
    Uri.parse(API.getID),
    body: {'contactNum': contactNum},
  );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData.containsKey('userID')) {
        userIdFound = jsonData['userID'].toString();
        submitReport();
      } else {
        
      }
    }else {
      throw Exception('Failed to fetch userID');
    }
  }

  submitReport() async {
    try{
      var res = await http.post(
        Uri.parse(API.subRep),
        body: {
          'userID' : userIdFound,
          'timeStamp' : formattedDateTime,
          'latitudeRep' : _lat,
          'longitudeRep' : _long,
          'addressRep' : address,
          'assistanceRep' : assistance,
        },
      );

      if(res.statusCode == 200){
        var resBodySign = jsonDecode(res.body);
        if(resBodySign['Success'] == true){
          Fluttertoast.showToast(msg: "Thank You for Submitting your Report!");
          _backButton();
        }else{
          Fluttertoast.showToast(msg: "Error Occured, Try Again");
        }
      }
    }catch(e){
      print("I FOUND HIM CHIEF");
      print(e.toString());
      print("HE OVER HERE");
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void initState() {
    _getLocation();
    super.initState();
    validNum = widget._mobileNumber;
    contactNumController = TextEditingController(text: validNum);
    DateTime now = DateTime.now();
    formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  }

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied");
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        debugPrint(
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}");
        lat = position.latitude;
        long = position.longitude;
        _lat = position.latitude.toString();
        _long = position.longitude.toString();
        _convertLatLngToAddress(lat, long);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _convertLatLngToAddress(double lat, double long) async {
    debugPrint(lat.toString());
    debugPrint(long.toString());
    final placemarks = await placemarkFromCoordinates(lat, long);

    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      final formattedAddress =
          '${placemark.street}, ${placemark.locality} ${placemark.postalCode}';
      setState(() {
        address = formattedAddress;
        debugPrint(address);
      });
    }
  }

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
                    "Report a Fire Incident",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.fire_truck_outlined,
                    size: 35,
                    color: Colors.black,
                  )
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
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGreyText("Address: $address"),
        const SizedBox(height: 20),
        _buildGreyText("Barangay: "),
        const SizedBox(height: 20),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 2.0),
            ),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: assistance,
            items: assistanceList.map(_assistanceItems).toList(),
            onChanged: (value) => setState(
              () {
                assistance = value;
                debugPrint(value);
              },
            ),
            hint: const Text("Select Special Assistance"),
          ),
        ),
        const SizedBox(height: 20),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () async{
        await fetchUserID(contactNumController.text);
        debugPrint("User ID: $userIdFound");
        debugPrint("Mobile Number: ${contactNumController?.text}");
        debugPrint("Time: $formattedDateTime");
        debugPrint("Latitude: $_lat");
        debugPrint("Longitude: $_long");
        debugPrint("Address: $address");
        debugPrint("Assistance: $assistance");
        debugPrint("-----------------------");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text("Submit Report"),
    );
  }

  DropdownMenuItem<String> _assistanceItems(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      );
}
