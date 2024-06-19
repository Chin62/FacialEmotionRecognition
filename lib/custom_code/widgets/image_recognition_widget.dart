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

import 'package:tflite/tflite.dart';
import 'package:image_downloader/image_downloader.dart';

class ImageRecognitionWidget extends StatefulWidget {
  const ImageRecognitionWidget({
    Key? key,
    this.width,
    this.height,
    this.imageUrl,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String? imageUrl;

  @override
  ImageRecognitionWidgetState createState() => ImageRecognitionWidgetState();
}

class ImageRecognitionWidgetState extends State<ImageRecognitionWidget> {
  String? _imageUrl;
  List? _recognitions;

  void initState() {
    super.initState();

    _imageUrl = widget.imageUrl;
    loadModel();
    if (_imageUrl != null && _imageUrl != '') {
      grabImage();
    }
  }

  Future loadModel() async {
    Tflite.close();

    try {
      String? res = await Tflite.loadModel(
        model: "assets/images/mobilenet_v1_1.0_224.tflite",
        labels: "assets/images/labels.txt",
      );
      print("Loaded model:" + res!);
    } catch (e) {
      print('Failed to load model.' + e.toString());
    }
  }

  Future grabImage() async {
    String? imageId = await ImageDownloader.downloadImage(_imageUrl!);

    if (imageId == null) {
      return;
    }

    String? path = await ImageDownloader.findPath(imageId);
    print('saved new image:' + path!);

    await recognizeImage(File(path));
  }

  Future recognizeImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _recognitions = recognitions;
    });
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
