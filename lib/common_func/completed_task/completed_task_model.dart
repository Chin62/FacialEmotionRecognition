import '/flutter_flow/flutter_flow_util.dart';
import 'completed_task_widget.dart' show CompletedTaskWidget;
import 'package:flutter/material.dart';

class CompletedTaskModel extends FlutterFlowModel<CompletedTaskWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
