import '/flutter_flow/flutter_flow_util.dart';
import 'fear_t_widget.dart' show FearTWidget;
import 'package:flutter/material.dart';

class FearTModel extends FlutterFlowModel<FearTWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
