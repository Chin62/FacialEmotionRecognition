import '/flutter_flow/flutter_flow_util.dart';
import 'surprise_t_widget.dart' show SurpriseTWidget;
import 'package:flutter/material.dart';

class SurpriseTModel extends FlutterFlowModel<SurpriseTWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
