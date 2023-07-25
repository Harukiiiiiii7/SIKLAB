import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:siklabproject/viewSingleReportPage.dart';

class viewImage extends StatefulWidget {
  String reportID;
  String imageString;

  viewImage(this.reportID, this.imageString, {super.key});

  @override
  State<viewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<viewImage> {
  void _BackButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => viewSingleReportPage(widget.reportID)));
  }

  @override
  Widget build(BuildContext context) {
    Uint8List imageBytes = base64.decode(widget.imageString);

    return WillPopScope(
      onWillPop: () async {
        _BackButton();
        // Prevent default back button behavior
        return false;
      },
      child: Scaffold(
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
                        viewSingleReportPage(widget.reportID)));
          },
          icon: const Icon(
            Icons.check,
          ),
          label: const Text("OK"),
        ),
      ),
    );
  }
}
