import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:siklabproject/loginPage.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:siklabproject/otp_pinput.dart';

class AdminMobileNumberScreen extends StatefulWidget {
  static String verifyID = "";
  @override
  State<AdminMobileNumberScreen> createState() =>
      _AdminMobileNumberScreenState();
}

class _AdminMobileNumberScreenState extends State<AdminMobileNumberScreen> {
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
      MaterialPageRoute(builder: (context) => loginPage()),
    );
  }

  void _nextPage(String phoneNumber) {
    const CircularProgressIndicator();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OTP_Screen(phoneNumber)),
    );
  }

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _backButton,
        ),
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 35),
                Image.asset('assets/mobile.png', height: 125, width: 125),
                const SizedBox(height: 20),
                const Text(
                  "Login With Mobile Number",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "We will send an OTP to verify.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0, //
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: mobileNumberController,
                          enabled: false,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                      ),
                      const Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.black),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            phone = value;
                          },
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    var xphone = '${mobileNumberController.text + phone}';
                    print(xphone);
                    print(xphone.length);
                    if ((mobileNumberController.text + phone).length == 13) {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: xphone,
                        timeout: const Duration(seconds: 60),
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {
                          print(e);
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          AdminMobileNumberScreen.verifyID = verificationId;
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                      _nextPage(xphone);
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
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(350, 50),
                    shape: const StadiumBorder(),
                    shadowColor: const Color.fromRGBO(105, 105, 105, 1),
                    backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
                  ),
                  child: const Text(
                    "Send OTP",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
