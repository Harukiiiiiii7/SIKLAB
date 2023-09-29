import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class sign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController contactNumController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> registerUser() async {
    // Make an HTTP POST request to your PHP backend
    final response = await http.post(
      Uri.parse('https://siklabcentral.000webhostapp.com/index.php'),
      body: {
        'username': usernameController.text,
        'barangay': barangay,
        'contactNum': contactNumController.text,
        'password': passwordController.text,
      },
    );

    var data = json.decode(response.body);
    if(data == "Error"){
      Fluttertoast.showToast(
        msg: "This user already exits!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }else{
      Fluttertoast.showToast(
        msg: "Registration Successful! Welcome!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  List<String> items = ["Brgy. Bagong Nayon",
    "Brgy. Beverly Hills",
    "Brgy. Cupang",
    "Brgy. Dalig",
    "Brgy. Dela Paz",
    "Brgy. Inarawan",
    "Brgy. Mambugan",
    "Brgy. Mayamot",
    "Brgy. San Isidro",
    "Brgy. San Jose",
    "Brgy. San Luis",
    "Brgy. San Roque",
    "Brgy. Santa Cruz"];
  String barangay = 'Brgy. Bagong Nayon'; // Initially selected item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            DropdownButtonFormField(
              
              value: barangay,
              onChanged: (String? newValue) {
                setState(() {
                  barangay = newValue ?? '';
                });
              },
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value), // Provide a child Text widget here
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Select an item',
              ),
            ),
            TextField(
              controller: contactNumController,
              decoration: InputDecoration(labelText: 'Contact Number'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: (){
                if(barangay != null){
                  registerUser();
                }else{
                  print('Please select an barangay.');
                }
                debugPrint("Name: ${usernameController.text}");
                debugPrint("Barangay: $barangay");
                debugPrint("Mobile Number: ${contactNumController.text}");
                debugPrint("Password: ${passwordController.text}");
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
