import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siklabproject/main.dart';
import 'package:siklabproject/signUpPage.dart';
import 'package:siklabproject/userDashboard.dart';

class loginPage extends StatefulWidget {
  @override
  State<loginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<loginPage> {
  void _BackButton() {
    Navigator.pushNamed(context, '/Home');
  }

  late Color myColor;
  late Size mediaSize;
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;

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
        _buildGreyText("Please login with your information"),
        const SizedBox(height: 30),
        _buildGreyText("Mobile Number"),
        _buildInputField(mobileNumberController),
        const SizedBox(height: 20),
        _buildGreyText("Password"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildRememberForgot(),
        const SizedBox(height: 10),
        _buildLoginButton(),
        const SizedBox(height: 10),
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
      {isPassword = false}) {
    return TextField(
      controller: controller,
      keyboardType: isPassword ? TextInputType.text : TextInputType.phone,
      inputFormatters:
          isPassword ? null : [LengthLimitingTextInputFormatter(11)],
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? const Icon(Icons.remove_red_eye_rounded)
            : const Icon(Icons.phone_android_sharp),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            _buildGreyText("Remember Me"),
          ],
        ),
        TextButton(
          onPressed: () {
            debugPrint("Me forgot password huhu help");
          },
          child: _buildGreyText("I forgot my password"),
        )
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Number: ${mobileNumberController.text}");
        debugPrint("Password: ${passwordController.text}");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserDashboard()));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text("LOGIN"),
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Signing up fool!");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => signUpPage()));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text("Don't have an account? Sign up"),
    );
  }
}
