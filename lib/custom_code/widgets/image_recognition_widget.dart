// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:io';

import 'package:image_downloader/image_downloader.dart';
import 'package:tflite/tflite.dart';

class ImageRecognitionWidget extends StatefulWidget {
  const ImageRecognitionWidget({
    Key? key,
    this.width,
    this.height,
    this.imageURL,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? imageURL;

  @override
  ImageRecognitionWidgetState createState() => ImageRecognitionWidgetState();
}

class ImageRecognitionWidgetState extends State<ImageRecognitionWidget> {
  String? _imageURL;
  List? _recognitions;

  @override
  void initState() {
    super.initState();

    _imageURL = widget.imageURL;
    loadModel();
    if (_imageURL != null && _imageURL != '') {
      grabImage();
    }
  }

  Future<void> loadModel() async {
    Tflite.close();
    try {
      String? res = await Tflite.loadModel(
        model: "assets/fyp.tflite",
        labels: "assets/labels.txt",
      );
      print("Load model: " + res!);
    } catch (e) {
      print('Failed to load model: ' + e.toString());
    }
  }

  Future<void> grabImage() async {
    try {
      String? imageID = await ImageDownloader.downloadImage(_imageURL!);
      if (imageID == null) {
        print("Failed to download image.");
        return;
      }

      String? path = await ImageDownloader.findPath(imageID);
      if (path != null) {
        print('Saved new image: ' + path!);
        await recognizeImage(File(path));
      }
    } catch (e) {
      print('Failed to download image: $e');
    }
  }

  Future<void> recognizeImage(File image) async {
    try {
      var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 6,
        threshold: 0.1,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      setState(() {
        _recognitions = recognitions;
      });
    } catch (e) {
      print('Failed to recognize image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];

    stackChildren.add(Center(
      child: Column(
        children: _recognitions != null
            ? _recognitions!.map((res) {
                return Text(
                  "${res["index"]} - ${res["label"]}: ${res["confidence"].toStringAsFixed(3)}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    background: Paint()..color = Colors.white,
                  ),
                );
              }).toList()
            : [],
      ),
    ));

    return Column(children: stackChildren);
  }
}
