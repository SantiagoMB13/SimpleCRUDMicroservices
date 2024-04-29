import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'crear_widget.dart' show CrearWidget;
import 'package:flutter/material.dart';

class CrearModel extends FlutterFlowModel<CrearWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for tipoid widget.
  String? tipoidValue;
  FormFieldController<String>? tipoidValueController;
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

  // State field(s) for firstname widget.
  FocusNode? firstnameFocusNode;
  TextEditingController? firstnameTextController;
  String? Function(BuildContext, String?)? firstnameTextControllerValidator;
  String? _firstnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Este campo es requerido';
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }
    if (val.length > 30) {
      return 'Máximo 30 caracteres';
    }
    if (!RegExp('^[a-zA-Z]+\$').hasMatch(val)) {
      return 'Solo puede contener letras';
    }
    return null;
  }

  // State field(s) for secondname widget.
  FocusNode? secondnameFocusNode;
  TextEditingController? secondnameTextController;
  String? Function(BuildContext, String?)? secondnameTextControllerValidator;
  String? _secondnameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'no deberia salir';
    }

    if (val.length < 0) {
      return '0 caracteres';
    }
    if (val.length > 30) {
      return 'Máximo 30 caracteres';
    }
    if (!RegExp('^[a-zA-Z\\s]*\$').hasMatch(val)) {
      return 'Solo puede contener letras';
    }
    return null;
  }

  // State field(s) for lastname widget.
  FocusNode? lastnameFocusNode;
  TextEditingController? lastnameTextController;
  String? Function(BuildContext, String?)? lastnameTextControllerValidator;
  String? _lastnameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Este campo es requerido';
    }

    if (val.isEmpty) {
      return 'Requires at least 1 characters.';
    }
    if (val.length > 60) {
      return 'Máximo 60 caracteres';
    }
    if (!RegExp('^[a-zA-Z\\s]+\$').hasMatch(val)) {
      return 'Solo puede contener letras';
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
  // State field(s) for genero widget.
  String? generoValue;
  FormFieldController<String>? generoValueController;
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  String? _emailAddressTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Este campo es requerido';
    }

    if (val.isEmpty) {
      return 'Este campo es requerido';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Debe ingresar un email válido';
    }
    return null;
  }

  // State field(s) for phone widget.
  FocusNode? phoneFocusNode;
  TextEditingController? phoneTextController;
  String? Function(BuildContext, String?)? phoneTextControllerValidator;
  String? _phoneTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Este campo es requerido';
    }

    if (val.length < 10) {
      return 'El número debe ser de 10 caracteres.';
    }
    if (val.length > 10) {
      return 'El número debe ser de 10 caracteres.';
    }
    if (!RegExp('^\\d+\$').hasMatch(val)) {
      return 'Solo puede contener dígitos';
    }
    return null;
  }

  // Stores action output result for [Custom Action - callCreateFunction] action in Button widget.
  String? resultadoFunc;

  @override
  void initState(BuildContext context) {
    idTextControllerValidator = _idTextControllerValidator;
    firstnameTextControllerValidator = _firstnameTextControllerValidator;
    secondnameTextControllerValidator = _secondnameTextControllerValidator;
    lastnameTextControllerValidator = _lastnameTextControllerValidator;
    dateTextControllerValidator = _dateTextControllerValidator;
    emailAddressTextControllerValidator = _emailAddressTextControllerValidator;
    phoneTextControllerValidator = _phoneTextControllerValidator;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    idFocusNode?.dispose();
    idTextController?.dispose();

    firstnameFocusNode?.dispose();
    firstnameTextController?.dispose();

    secondnameFocusNode?.dispose();
    secondnameTextController?.dispose();

    lastnameFocusNode?.dispose();
    lastnameTextController?.dispose();

    dateFocusNode?.dispose();
    dateTextController?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    phoneFocusNode?.dispose();
    phoneTextController?.dispose();
  }
}
