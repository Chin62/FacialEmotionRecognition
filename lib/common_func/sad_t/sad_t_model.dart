import '/flutter_flow/flutter_flow_util.dart';
import 'sad_t_widget.dart' show SadTWidget;
import 'package:flutter/material.dart';

class SadTModel extends FlutterFlowModel<SadTWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
