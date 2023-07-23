import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:siklabproject/user_viewSingleReportScreen.dart';
import 'package:siklabproject/viewSingleReportPage.dart';

class User_ViewImage extends StatefulWidget {
  String reportID;
  String imageString;

  User_ViewImage(this.reportID, this.imageString, {super.key});

  @override
  State<User_ViewImage> createState() => _User_ViewImageState();
}

class _User_ViewImageState extends State<User_ViewImage> {
  @override
  Widget build(BuildContext context) {
    Uint8List imageBytes = base64.decode(widget.imageString);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Preview"),
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.memory(imageBytes),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  User_ViewSingleReportScreen(widget.reportID),
            ),
          );
        },
        icon: const Icon(
          Icons.check,
        ),
        label: const Text("OK"),
      ),
    );
  }
}
