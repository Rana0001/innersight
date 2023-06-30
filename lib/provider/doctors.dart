import 'package:flutter/cupertino.dart';
import 'package:innersight/app/constant.dart';

import '../models/doctors.dart';
import '../services/services.dart';

class Doctors extends ChangeNotifier {
  bool _doctorSearchScreen = false;
  String _searchHeader = '';
  String _id = '';
  String _value = '';
  List<Doctor> _doctors = [];

  List<Doctor> get getDoctors {
    return Constant.doctors;
  }

  bool get getScreenState {
    return _doctorSearchScreen;
  }

  String get getSearchHeader {
    return _searchHeader;
  }

  void setScreenState(bool val, [String type = '']) {
    _doctorSearchScreen = val;
    _searchHeader = type;
    notifyListeners();
  }

  void edit(String myId, String myVal) {
    _id = myId;
    _value = myVal;
    notifyListeners();
  }

  String get getId {
    return _id;
  }

  String get getVal {
    return _value;
  }

  List<Doctor> searchDoctorType(String query) {
    return _doctors
        .where((element) =>
            element.fullName!.toLowerCase().startsWith(query.toLowerCase()) ||
            element.fullName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Doctor findDoctorById(String id) {
    return _doctors.firstWhere((doctor) => doctor.uid == id);
  }

  Future<List<Doctor>> getAllDoctors() async {
    try {
      Services services = Services();
      List<Doctor> doctors = await services.getAllDoctor();
      Constant.doctors = doctors;
      _doctors = doctors;
      notifyListeners();
      return doctors;
    } catch (error) {
      print('Error retrieving doctors: $error');
      return [];
    }
  }

  getAllDoctorList() {
    notifyListeners();
    return _doctors;
  }
}
