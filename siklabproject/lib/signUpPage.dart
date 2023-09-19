import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siklabproject/loginPage.dart';
import 'main.dart';

class signUpPage extends StatefulWidget {
  @override
  State<signUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<signUpPage> {
  void _BackButton() {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => loginPage()));
    Navigator.pushNamed(context, '/LoginPage');
  }

  late Color myColor;
  late Size mediaSize;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final barangays = [
    "San Andres (Pob.)",
    "San Isidro",
    "San Juan",
    "San Roque",
    "Santa Rosa",
    "Santo Domingo",
    "Santo Niño"
  ];
  String? barangay;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        _BackButton();
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
              Positioned(bottom: 0, child: _buildBottom()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
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
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hello!",
          style: TextStyle(
            color: Color.fromRGBO(171, 0, 0, 1),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildGreyText("Please fill up your information"),
        const SizedBox(height: 25),
        _buildGreyText("Name"),
        _buildInputField(nameController),
        const SizedBox(height: 20),
        _buildGreyText("Barangay"),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 2.0),
            ),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: barangay,
            items: barangays.map(_barangayItems).toList(),
            onChanged: (value) => setState(
              () {
                barangay = value;
                debugPrint(value);
              },
            ),
            hint: const Text("Select Barangay"),
          ),
        ),
        const SizedBox(height: 20),
        _buildGreyText("Mobile Number"),
        _buildInputField(mobileNumberController, isPhone: true),
        const SizedBox(height: 20),
        _buildGreyText("Password"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildGreyText("Confirm Password"),
        _buildInputField(confirmPasswordController, isPassword: true),
        const SizedBox(height: 20),
        _buildSignUpButton(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false, isPhone = false}) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 2.0),
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: isPassword
            ? TextInputType.text
            : isPhone
                ? TextInputType.phone
                : TextInputType.text,
        inputFormatters:
            isPhone ? [LengthLimitingTextInputFormatter(11)] : null,
        decoration: InputDecoration(
          suffixIcon: isPassword
              ? const Icon(Icons.remove_red_eye_rounded)
              : isPhone
                  ? const Icon(Icons.phone_android_sharp)
                  : null,
        ),
        obscureText: isPassword,
      ),
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Number: ${nameController.text}");
        debugPrint("Number: $barangay");
        debugPrint("Number: ${mobileNumberController.text}");
        debugPrint("Password: ${passwordController.text}");
        debugPrint("Password: ${confirmPasswordController.text}");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text("Sign Up"),
    );
  }

  DropdownMenuItem<String> _barangayItems(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      );
}
