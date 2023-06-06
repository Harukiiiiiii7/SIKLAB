import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siklabproject/ConfirmReport.dart';
import 'package:siklabproject/reportPageMoreDetails.dart';

import 'addReportPage.dart';

class ImagePreview extends StatefulWidget {
  String reportID;
  XFile file;

  ImagePreview(this.reportID, this.file, {super.key});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);

    List<int> imageBytes = picture.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    return Scaffold(
      appBar: AppBar(title: const Text("Image Preview")),
      body: Container(
          child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.file(picture),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //print(imageBytes);
          print(base64Image);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReportPageMoreDetails(widget.reportID, base64Image)));
        },
        icon: const Icon(Icons.check),
        label: const Text("OK"),
      ),
    );
  }
}
