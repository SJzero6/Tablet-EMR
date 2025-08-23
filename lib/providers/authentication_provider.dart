import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _rememberPassword = true;
  bool _loginState = false;
  String _authToken = '';
  int _userId = 0;
  int _docId = 0;
  bool isLoading = false;
  int _treatmentid = 0;

  //Any APi running. This is true when any Api under this provider is running
  bool _isAnyApiRunning = false;

  int _apiCount = 0;

  String? _username;

  String? _doctorname;

  String? get username => _username;
  int get userId => _userId;

  void setUserInfo(String username, int userId) {
    _username = username;
    _userId = userId;
    notifyListeners(); // Notify listeners to update widgets consuming this data
  }

  String? get docname => _doctorname;
  int get docId => _docId;

  void setDoctorInfo(String docname, int docId) {
    _doctorname = docname;
    _docId = docId;
    notifyListeners(); // Notify listeners to update widgets consuming this data
  }

  int get treatmentId => _treatmentid;
  void setTreatmentInfo(int treatmentId) {
    _treatmentid = treatmentId;
    notifyListeners();
  }

  String? _appointDate;
  String? _appointTime;
  String? _appointId;
  int? _docid;

  String? get appointDate => _appointDate;
  String? get appointtime => _appointTime;
  String? get appointId => _appointId;
  int? get appointDocId =>_docid;

  void setAppointInfo(
      String appoinmentdate, String appoinmenttime, String appoinmentId, int doctorId ) {
    _appointDate = appoinmentdate;
    _appointTime = appoinmenttime;
    _appointId = appoinmentId;
    _docid =doctorId;
    notifyListeners(); // Notify listeners to update widgets consuming this data
  }

  anApiStarted() {
    _isAnyApiRunning = true;
    _apiCount++;
    isLoading = true;
    notifyListeners();
  }

  anApiStopped() {
    isLoading = false;
    if (_apiCount > 1) {
      _apiCount--;
    } else {
      _apiCount = 0;
      _isAnyApiRunning = false;
    }
    notifyListeners();
  }

  isAnyApiRunningClear() async {
    await Future.delayed(Duration.zero);
    _apiCount = 0;
    _isAnyApiRunning = false;
    notifyListeners();
  }

  bool get isAnyApiRunning => _isAnyApiRunning;

  set rememberPassword(bool remember) {
    _rememberPassword = remember;
    notifyListeners();
  }

  bool get rememberPassword => _rememberPassword;

  // setAuthToken(String token, userId) async {
  //   _authToken = token;
  //   _userId = userId;
  //   _loginState = true;
  //   notifyListeners();
  //   if (_rememberPassword) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     bool saved = await prefs.setString('token', token);
  //     await prefs.setInt('userId', userId);
  //     //TODO Remove and properly handle
  //     if (saved) {
  //       print('Token saved to shared preferance');
  //     }
  //   } else {
  //     print('Token not saved - remeber password false');
  //   }
  // }

  // removeAuthToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('token', '');
  //   _loginState = false;
  //   notifyListeners();
  // }

  bool get loginState => _loginState;

  String get authToken => _authToken;

  //To handle error from api to show on Toast
  String _errorMessage = '';

  set errorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  String get errorMessage => _errorMessage;

  clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  Future<void> saveCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  Future<Map<String, String>> getCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    return {
      'username': username ?? '',
      'password': password ?? '',
    };
  }

  Future<void> clearCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
  }
}
