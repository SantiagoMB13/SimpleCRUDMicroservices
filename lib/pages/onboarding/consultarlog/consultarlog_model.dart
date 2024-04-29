import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'consultarlog_widget.dart' show ConsultarlogWidget;
import 'package:flutter/material.dart';

class ConsultarlogModel extends FlutterFlowModel<ConsultarlogWidget> {
  ///  Local state fields for this page.

  bool showLog = true;

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

  // State field(s) for date widget.
  FocusNode? dateFocusNode;
  TextEditingController? dateTextController;
  String? Function(BuildContext, String?)? dateTextControllerValidator;
  String? _dateTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Este campo es requerido';
    }

    if (val.length < 10) {
      return 'Ingrese la fecha en formato dd-MM-yyyy';
    }
    if (val.length > 10) {
      return 'Ingrese la fecha en formato dd-MM-yyyy';
    }
    if (!RegExp('^\\d{2}-\\d{2}-\\d{4}\$').hasMatch(val)) {
      return 'Ingrese la fecha en formato dd-MM-yyyy';
    }
    return null;
  }

  DateTime? datePicked;
  // State field(s) for operation widget.
  String? operationValue;
  FormFieldController<String>? operationValueController;
  // Stores action output result for [Custom Action - callLogFunction] action in Button widget.
  dynamic resultadoFunc;

  @override
  void initState(BuildContext context) {
    idTextControllerValidator = _idTextControllerValidator;
    dateTextControllerValidator = _dateTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    idFocusNode?.dispose();
    idTextController?.dispose();

    dateFocusNode?.dispose();
    dateTextController?.dispose();
  }
}
