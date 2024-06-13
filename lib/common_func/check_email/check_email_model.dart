import '/flutter_flow/flutter_flow_util.dart';
import 'check_email_widget.dart' show CheckEmailWidget;
import 'package:flutter/material.dart';

class CheckEmailModel extends FlutterFlowModel<CheckEmailWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
