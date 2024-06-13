import '/flutter_flow/flutter_flow_util.dart';
import 'to_do_task_widget.dart' show ToDoTaskWidget;
import 'package:flutter/material.dart';

class ToDoTaskModel extends FlutterFlowModel<ToDoTaskWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
