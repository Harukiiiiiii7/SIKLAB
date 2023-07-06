import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:siklabproject/imagePreviewPage.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class CameraScreen extends StatefulWidget {
  String reportID;
  final CameraDescription camera;
  LatLng latLng;

  CameraScreen({
    required this.camera,
    required this.reportID,
    required this.latLng,
    super.key,
  });

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera"),
        backgroundColor: const Color.fromRGBO(171, 0, 0, 1),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final previewSize = _controller.value.previewSize!;
            final previewRatio = previewSize.height / previewSize.width;

            double scale;
            if (previewRatio > deviceRatio) {
              scale = previewRatio / deviceRatio;
            } else {
              scale = deviceRatio / previewRatio;
            }

            return Center(
              child: Transform.scale(
                scale: scale,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: previewRatio,
                    child: CameraPreview(_controller),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 235, 10, 10),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            XFile picture = await _controller.takePicture();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ImagePreview(widget.reportID, widget.latLng, picture)));
            print(widget.reportID);
            //Navigator.of(context).pop(path);
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
