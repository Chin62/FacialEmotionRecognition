import '/flutter_flow/flutter_flow_util.dart';
import 'disgust_t_widget.dart' show DisgustTWidget;
import 'package:flutter/material.dart';

class DisgustTModel extends FlutterFlowModel<DisgustTWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
