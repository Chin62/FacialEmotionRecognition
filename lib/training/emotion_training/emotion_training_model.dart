import '/flutter_flow/flutter_flow_util.dart';
import 'emotion_training_widget.dart' show EmotionTrainingWidget;
import 'package:flutter/material.dart';

class EmotionTrainingModel extends FlutterFlowModel<EmotionTrainingWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
