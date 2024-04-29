// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> callCreateFunction(
  String urlFoto,
  String tipoDocumento,
  String numeroDocumento,
  String primerNombre,
  String segundoNombre,
  String apellidos,
  String fechaNacimiento,
  String genero,
  String correo,
  String celular,
) async {
  try {
    final response = await http.post(
      Uri.parse(
          'https://us-central1-crud-db-e2974.cloudfunctions.net/createdb'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'data': {
          'urlFoto': urlFoto,
          'tipoDocumento': tipoDocumento,
          'numeroDocumento': numeroDocumento,
          'primerNombre': primerNombre,
          'segundoNombre': segundoNombre,
          'apellidos': apellidos,
          'fechaNacimiento': fechaNacimiento,
          'genero': genero,
          'correo': correo,
          'celular': celular,
        },
      }),
    );

    if (response.statusCode == 200) {
      // Si la función se ejecutó correctamente, devuelve el resultado.
      Map<String, dynamic> result = jsonDecode(response.body);
      return result['result'];
    } else {
      // Si la función falló, devuelve 'crash'.
      return 'crash';
    }
  } catch (e) {
    // Si ocurrió un error al hacer la solicitud, devuelve 'crash'.
    return 'crash';
  }
}
