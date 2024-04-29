import 'package:flutter/material.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _visibleuser = false;
  bool get visibleuser => _visibleuser;
  set visibleuser(bool value) {
    _visibleuser = value;
  }

  List<dynamic> _logs = [
    jsonDecode(
        '{\"id\":\"0\",\"fecha\":\"01-01-1000\",\"tipo\":\"placeholder\"}')
  ];
  List<dynamic> get logs => _logs;
  set logs(List<dynamic> value) {
    _logs = value;
  }

  void addToLogs(dynamic value) {
    _logs.add(value);
  }

  void removeFromLogs(dynamic value) {
    _logs.remove(value);
  }

  void removeAtIndexFromLogs(int index) {
    _logs.removeAt(index);
  }

  void updateLogsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    _logs[index] = updateFn(_logs[index]);
  }

  void insertAtIndexInLogs(int index, dynamic value) {
    _logs.insert(index, value);
  }
}
