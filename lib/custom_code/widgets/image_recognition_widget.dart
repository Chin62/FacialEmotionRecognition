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
import 'dart:ui' as ui;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/widgets.dart';

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

  Future<void> loadModel() async {
    Tflite.close();
    try {
      String? res = await Tflite.loadModel(
        model: "assets/fyp.tflite",
        labels: "assets/labels.txt",
      );
      print("Load model: $res");
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  Future<void> grabImage() async {
    try {
      String? imageID = await ImageDownloader.downloadImage(_imageURL!);
      if (imageID == null) return;

      String? path = await ImageDownloader.findPath(imageID);
      print('Saved new image: $path');

      setState(() {
        _imageFile = File(path!);
      });

      await recognizeImage(_imageFile!);
    } catch (e) {
      print('Failed to download image: $e');
    }
  }

  Future<void> recognizeImage(File image) async {
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

  Future<void> saveResult() async {
    if (_recognitions == null || _imageFile == null) return;

    try {
      // Load the image to be drawn on
      final originalImage = await _imageFile!.readAsBytes();
      final codec = await ui.instantiateImageCodec(originalImage);
      final frame = await codec.getNextFrame();
      final image = frame.image;

      // Create a picture recorder to draw on
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder,
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));

      // Draw the original image
      canvas.drawImage(image, Offset.zero, Paint());

      // Draw the recognition results
      final textPainter = TextPainter(
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr, // Correct TextDirection
      );

      final textStyle = TextStyle(
        color: Colors.red,
        fontSize: 20,
      );

      final results = _recognitions!
          .map((res) =>
              "${res["index"]} - ${res["label"]}: ${res["confidence"].toStringAsFixed(3)}")
          .join("\n");

      textPainter.text = TextSpan(text: results, style: textStyle);
      textPainter.layout(maxWidth: image.width.toDouble());
      textPainter.paint(canvas, Offset(10, 10));

      // Get the final image
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      // Save the final image
      final directory = await getApplicationDocumentsDirectory();
      final resultImagePath = "${directory.path}/result_image.png";
      final resultImageFile = File(resultImagePath);
      await resultImageFile.writeAsBytes(pngBytes);

      Fluttertoast.showToast(msg: "Results image saved!");
    } catch (e) {
      print('Failed to save result image: $e');
    }
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
