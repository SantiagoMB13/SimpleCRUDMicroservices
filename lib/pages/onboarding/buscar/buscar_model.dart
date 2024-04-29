import '/components/userinfo_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'buscar_widget.dart' show BuscarWidget;
import 'package:flutter/material.dart';

class BuscarModel extends FlutterFlowModel<BuscarWidget> {
  ///  Local state fields for this page.

  bool showUser = true;

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

  // Stores action output result for [Custom Action - callReadFunction] action in Button widget.
  dynamic resultadoFunc;
  // Model for userinfo component.
  late UserinfoModel userinfoModel;

  @override
  void initState(BuildContext context) {
    idTextControllerValidator = _idTextControllerValidator;
    userinfoModel = createModel(context, () => UserinfoModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    idFocusNode?.dispose();
    idTextController?.dispose();

    userinfoModel.dispose();
  }
}
