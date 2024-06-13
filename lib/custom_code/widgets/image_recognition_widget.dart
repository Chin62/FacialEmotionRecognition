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

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
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
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _imageURL = widget.imageURL;
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    try {
      String? res = await Tflite.loadModel(
        model: "assets/fyp.tflite",
        labels: "assets/label.txt",
      );
      print("Load model: " + res!);
    } catch (e) {
      print('Failed to load model: ' + e.toString());
    }
  }

  Future grabImage() async {
    try {
      String? imageID = await ImageDownloader.downloadImage(_imageURL!);
      if (imageID == null) return;

      String? path = await ImageDownloader.findPath(imageID);
      print('Saved new image: ' + path!);

      setState(() {
        _imageFile = File(path);
      });

      await recognizeImage(File(path));
    } catch (e) {
      print('Failed to download image: ' + e.toString());
    }
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

  Future saveResult() async {
    if (_recognitions == null) return;

    final directory = await getApplicationDocumentsDirectory();
    final resultsPath = '${directory.path}/results.txt';
    final resultsFile = File(resultsPath);
    String results = _recognitions!
        .map((res) =>
            "${res["index"]} - ${res["label"]}: ${res["confidence"].toStringAsFixed(3)}")
        .join("\n");
    await resultsFile.writeAsString(results);

    Fluttertoast.showToast(msg: "Results saved!");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () => grabImage(),
          child: Text("Recognize Emotion"),
        ),
        SizedBox(height: 20),
        _imageFile != null
            ? Image.file(
                _imageFile!,
                width: widget.width,
                height: widget.height,
              )
            : Container(),
        SizedBox(height: 20),
        _recognitions != null
            ? Expanded(
                child: ListView.builder(
                  itemCount: _recognitions!.length,
                  itemBuilder: (context, index) {
                    var res = _recognitions![index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          "${res["index"]} - ${res["label"]}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                        subtitle: Text(
                          "Confidence: ${res["confidence"].toStringAsFixed(3)}",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            : Container(),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => saveResult(),
          child: Text("Save Results"),
        ),
      ],
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
