import '/flutter_flow/flutter_flow_util.dart';
import 'emotion_detection_widget.dart' show EmotionDetectionWidget;
import 'package:flutter/material.dart';

class EmotionDetectionModel extends FlutterFlowModel<EmotionDetectionWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
