import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:siklabproject/adminDashboard.dart';
import 'package:siklabproject/adminMobileNumberVerif.dart';
import 'package:siklabproject/loginAsPage.dart';

class OTP_Screen extends StatefulWidget {
  static String verifyID = "";
  String phoneNumber;

  OTP_Screen(this.phoneNumber, {super.key});

  @override
  State<OTP_Screen> createState() => _OTP_ScreenState();
}

class _OTP_ScreenState extends State<OTP_Screen> {
  String? mtoken = "";
  final pinController = TextEditingController();

  late int _countdownSeconds = 69;
  Timer? _countdownTimer;

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(fontSize: 22, color: Colors.black),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 241, 241, 241),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      border: Border.all(color: Colors.black),
    ),
  );

  void _BackButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginAsPage()));
  }

  void _VerificationComplete() {
    const CircularProgressIndicator();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminDashboard()));
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference adminsCollection =
      FirebaseFirestore.instance.collection('admins');

  @override
  void initState() {
    super.initState();
    requestPermission();
    getToken();

    if (_countdownTimer == null) {
      startCountdownTimer();
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel(); // Cancel the timer if it exists
    super.dispose();
  }

  void startCountdownTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownSeconds > 0) {
          _countdownSeconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted Permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
    } else {
      print("User denied permission");
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print("Token: $mtoken");
      });
      saveAdminCreds(token!, widget.phoneNumber);
    });
  }

  void saveAdminCreds(String token, String phoneNumber) async {
    final json = {'phone': phoneNumber, 'token': token};

    await FirebaseFirestore.instance
        .collection('admins')
        .doc(widget.phoneNumber)
        .set(json);
  }

  void _resendOTP() async {
    try {
      // Call verifyPhoneNumber again to resend OTP
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // Handle verification completion if auto-retrieval is enabled
          // Not needed in this case since we're using manual code entry
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) async {
          OTP_Screen.verifyID = verificationId;
          print("OTP Resent!");
          _countdownSeconds = 60;
          startCountdownTimer();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // This callback will be invoked when the auto-retrieval of OTP times out
          // Not needed in this case since we're using manual code entry
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      print("Error resending OTP: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          // children: [
          //   Text(
          //     'VIEW REPORT DETAILS',
          //     style: TextStyle(color: Colors.white, fontSize: 20.0),
          //   ),
          // ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _BackButton,
        ),
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "VERIFICATION",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Enter the code sent to your phone number.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.phoneNumber,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(height: 30),
              Pinput(
                //androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                controller: pinController,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.black),
                  ),
                ),
                onCompleted: (pin) async {
                  print(pin);
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: AdminMobileNumber.verifyID,
                      smsCode: pin,
                    );

                    await auth.signInWithCredential(credential);

                    const CircularProgressIndicator();
                    _VerificationComplete();
                  } catch (e) {
                    defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    );
                    print(pin);
                    print("Mali otp mo pre");
                  }
                },
              ),
              const SizedBox(height: 20),
              Text(
                _countdownSeconds > 0
                    ? 'Did not receive OTP? Resend in $_countdownSeconds seconds'
                    : 'Did not receive OTP? Resend now!',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              ElevatedButton(
                onPressed: _countdownSeconds > 0 ? null : _resendOTP,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(350, 50),
                  shape: const StadiumBorder(),
                  shadowColor: const Color.fromRGBO(105, 105, 105, 1),
                  backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
                ),
                child: const Text(
                  "Resend OTP",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}