import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:siklabproject/adminDashboard.dart';
import 'package:siklabproject/loginAsPage.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:siklabproject/verifyOTP.dart';

class AdminMobileNumber extends StatefulWidget {
  static String verifyID = "";
  @override
  State<AdminMobileNumber> createState() => _AdminMobileNumberState();
}

class _AdminMobileNumberState extends State<AdminMobileNumber> {
  bool enableTextField = true;
  TextEditingController mobileNumberController = TextEditingController();

  var phone = "";

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    mobileNumberController.text = "+63";
    super.initState();
  }

  void _backButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginAsPage()),
    );
  }

  void _nextPage() {
    const CircularProgressIndicator();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VerifyOTP()),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Enter your Mobile Number for Alerts and Notifications',
                  ),
                  Container(
                    child: Row(children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: mobileNumberController,
                          enabled: false,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      const Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextField(
                        keyboardType: TextInputType.phone,
                        enabled: enableTextField,
                        onChanged: (value) {
                          phone = value;
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: '9123456789'),
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      )),
                      const SizedBox(
                        width: 20,
                      )
                    ]),
                  ),
                ],
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
                    var xphone = '${mobileNumberController.text + phone}';
                    print(xphone);
                    print(xphone.length);
                    if ((mobileNumberController.text + phone).length == 13) {
                      setState(() {
                        enableTextField = false;
                      });

                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: xphone,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          AdminMobileNumber.verifyID = verificationId;

                          _nextPage();
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );

                      setState(() {
                        enableTextField = false;
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text(
                                'Please enter a valid mobile number.'),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shadowColor:
                                      const Color.fromRGBO(105, 105, 105, 1),
                                  backgroundColor:
                                      const Color.fromRGBO(171, 0, 0, 1),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Send OTP'),
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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
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
