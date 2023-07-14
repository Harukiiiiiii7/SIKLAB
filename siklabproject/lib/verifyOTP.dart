import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:siklabproject/adminDashboard.dart';
import 'package:siklabproject/loginAsPage.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'adminMobileNumberVerif.dart';

class VerifyOTP extends StatefulWidget {
  static String verifyID = "";
  @override
  State<VerifyOTP> createState() => _VerifyOTP();
}

class _VerifyOTP extends State<VerifyOTP> {
  TextEditingController otpController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  void _backButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginAsPage()),
    );
  }

  void _adminDashboard() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminDashboard()),
    );
  }

  var code = "";

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text("Enter OTP sent via SMS."),
              // !!PINPUT !! //
              content: TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter OTP',
                ),
                onChanged: (value) {
                  setState(() {
                    code = value;
                  });
                },
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: const Color.fromRGBO(105, 105, 105, 1),
                    backgroundColor: const Color.fromRGBO(110, 109, 109, 1),
                  ),
                  child: const Text('Close'),
                  onPressed: () {
                    _backButton();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: const Color.fromRGBO(105, 105, 105, 1),
                    backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
                  ),
                  onPressed: () async {
                    try {
                      print(otpController.text);
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: AdminMobileNumber.verifyID,
                              smsCode: code);

                      await auth.signInWithCredential(credential);
                      const CircularProgressIndicator();
                      _adminDashboard();
                    } catch (e) {
                      print(code);
                      print("mali otp mo pre");
                    }
                  },
                  child: const Text("Verify OTP"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Show the dialog box after the first frame is rendered
      _showDialog(context);
    });
    return Scaffold(
      body: Container(
        color: Colors.black,
      ),
    );
  }
}
