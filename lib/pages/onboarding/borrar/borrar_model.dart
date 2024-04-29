import '/flutter_flow/flutter_flow_util.dart';
import 'borrar_widget.dart' show BorrarWidget;
import 'package:flutter/material.dart';

class BorrarModel extends FlutterFlowModel<BorrarWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for id widget.
  FocusNode? idFocusNode;
  TextEditingController? idTextController;
  String? Function(BuildContext, String?)? idTextControllerValidator;
  String? _idTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Este campo es requerido';
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }
    if (val.length > 10) {
      return 'Máximo 10 caracteres';
    }
    if (!RegExp('^\\d+\$').hasMatch(val)) {
      return 'Solo puede contener dígitos';
    }
    return null;
  }

  // Stores action output result for [Custom Action - callDeleteFunction] action in Button widget.
  String? resultadoFuncDel;

  @override
  void initState(BuildContext context) {
    idTextControllerValidator = _idTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    idFocusNode?.dispose();
    idTextController?.dispose();
  }
}
