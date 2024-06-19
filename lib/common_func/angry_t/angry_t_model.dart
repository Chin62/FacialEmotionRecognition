import '/flutter_flow/flutter_flow_util.dart';
import 'angry_t_widget.dart' show AngryTWidget;
import 'package:flutter/material.dart';

class AngryTModel extends FlutterFlowModel<AngryTWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
