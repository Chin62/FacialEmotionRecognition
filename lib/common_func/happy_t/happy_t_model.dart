import '/flutter_flow/flutter_flow_util.dart';
import 'happy_t_widget.dart' show HappyTWidget;
import 'package:flutter/material.dart';

class HappyTModel extends FlutterFlowModel<HappyTWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
