import '/components/userinfo_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'buscar_model.dart';
export 'buscar_model.dart';

class BuscarWidget extends StatefulWidget {
  const BuscarWidget({
    super.key,
    bool? visible,
  }) : visible = visible ?? true;

  final bool visible;

  @override
  State<BuscarWidget> createState() => _BuscarWidgetState();
}

class _BuscarWidgetState extends State<BuscarWidget> {
  late BuscarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BuscarModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Buscar'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('BUSCAR_PAGE_Buscar_ON_INIT_STATE');
      logFirebaseEvent('Buscar_update_page_state');
      _model.showUser = false;
      setState(() {});
    });

    _model.idTextController ??= TextEditingController();
    _model.idFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 24.0, 0.0, 30.0),
                            child: Text(
                              'Buscar un usuario',
                              style: FlutterFlowTheme.of(context)
                                  .displaySmall
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          Form(
                            key: _model.formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 18.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 4.0),
                                          child: Text(
                                            'Número de documento',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Inter',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _model.idTextController,
                                        focusNode: _model.idFocusNode,
                                        autofocus: false,
                                        autofillHints: const [AutofillHints.name],
                                        textCapitalization:
                                            TextCapitalization.words,
                                        textInputAction: TextInputAction.next,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                              lineHeight: 1.0,
                                            ),
                                        minLines: 1,
                                        maxLength: 10,
                                        maxLengthEnforcement:
                                            MaxLengthEnforcement.enforced,
                                        buildCounter: (context,
                                                {required currentLength,
                                                required isFocused,
                                                maxLength}) =>
                                            null,
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        validator: _model
                                            .idTextControllerValidator
                                            .asValidator(context),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[0-9]'))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 24.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                logFirebaseEvent(
                                    'BUSCAR_PAGE_BUSCAR_USUARIO_BTN_ON_TAP');
                                var shouldSetState = false;
                                logFirebaseEvent('Button_update_page_state');
                                _model.showUser = false;
                                setState(() {});
                                logFirebaseEvent('Button_validate_form');
                                if (_model.formKey.currentState == null ||
                                    !_model.formKey.currentState!.validate()) {
                                  return;
                                }
                                logFirebaseEvent('Button_custom_action');
                                _model.resultadoFunc =
                                    await actions.callReadFunction(
                                  _model.idTextController.text,
                                );
                                shouldSetState = true;
                                if (functions.stringContains(
                                        getJsonField(
                                          _model.resultadoFunc,
                                          r'''$['mensaje']''',
                                        ).toString(),
                                        'verificar') ||
                                    functions.stringContains(
                                        getJsonField(
                                          _model.resultadoFunc,
                                          r'''$['mensaje']''',
                                        ).toString(),
                                        'exito')) {
                                  if (functions.stringContains(
                                      getJsonField(
                                        _model.resultadoFunc,
                                        r'''$['mensaje']''',
                                      ).toString(),
                                      'verificar')) {
                                    if (functions.stringContains(
                                        getJsonField(
                                          _model.resultadoFunc,
                                          r'''$['mensaje']''',
                                        ).toString(),
                                        'vacio')) {
                                      if (shouldSetState) setState(() {});
                                      return;
                                    }

                                    logFirebaseEvent('Button_show_snack_bar');
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'No hay un usuario registrado con ese número de documento.',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                        ),
                                        duration: const Duration(milliseconds: 4000),
                                        backgroundColor: const Color(0xFFEE1010),
                                      ),
                                    );
                                    if (shouldSetState) setState(() {});
                                    return;
                                  }
                                  logFirebaseEvent('Button_reset_form_fields');
                                  setState(() {
                                    _model.idTextController?.clear();
                                  });
                                  logFirebaseEvent('Button_update_page_state');
                                  _model.showUser = true;
                                  setState(() {});
                                  if (shouldSetState) setState(() {});
                                  return;
                                } else {
                                  logFirebaseEvent('Button_show_snack_bar');
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Este servicio no está disponible por el momento, por favor intenta más tarde.',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                      ),
                                      duration: const Duration(milliseconds: 4000),
                                      backgroundColor: const Color(0xFFEE1010),
                                    ),
                                  );
                                  if (shouldSetState) setState(() {});
                                  return;
                                }

                                if (shouldSetState) setState(() {});
                              },
                              text: 'Buscar usuario',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                          if (_model.showUser)
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (_model.showUser)
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 30.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              width: 100.0,
                                              height: 580.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                              ),
                                              child: wrapWithModel(
                                                model: _model.userinfoModel,
                                                updateCallback: () =>
                                                    setState(() {}),
                                                child: UserinfoWidget(
                                                  name: getJsonField(
                                                    _model.resultadoFunc,
                                                    r'''$['usuario']['primerNombre']''',
                                                  ).toString(),
                                                  secondname: getJsonField(
                                                    _model.resultadoFunc,
                                                    r'''$['usuario']['segundoNombre']''',
                                                  ).toString(),
                                                  lastnames: getJsonField(
                                                    _model.resultadoFunc,
                                                    r'''$['usuario']['apellidos']''',
                                                  ).toString(),
                                                  idtype: getJsonField(
                                                    _model.resultadoFunc,
                                                    r'''$['usuario']['tipoDocumento']''',
                                                  ).toString(),
                                                  id: getJsonField(
                                                    _model.resultadoFunc,
                                                    r'''$['usuario']['numeroDocumento']''',
                                                  ).toString(),
                                                  birthdate: getJsonField(
                                                    _model.resultadoFunc,
                                                    r'''$['usuario']['fechaNacimiento']''',
                                                  ).toString(),
                                                  gender: getJsonField(
                                                    _model.resultadoFunc,
                                                    r'''$['usuario']['genero']''',
                                                  ).toString(),
                                                  email: getJsonField(
                                                    _model.resultadoFunc,
                                                    r'''$['usuario']['correo']''',
                                                  ).toString(),
                                                  phone: getJsonField(
                                                    _model.resultadoFunc,
                                                    r'''$['usuario']['celular']''',
                                                  ).toString(),
                                                  img: getJsonField(
                                                    _model.resultadoFunc,
                                                    r'''$['usuario']['urlFoto']''',
                                                  ).toString(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
