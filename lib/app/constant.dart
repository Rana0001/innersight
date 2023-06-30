import 'package:flutter/material.dart';
import 'package:innersight/models/appointment.dart';
import 'package:innersight/models/patient.dart';

import '../models/doctors.dart';

class Constant {
  static String chatUrl = "http://10.0.2.2:5000/";
  static String message = "api/send-message";

  static String voiceMessage = "api/send-voice-message";

  static String speek = "api/speak";

  static Patient patient = Patient();

  static double height = 0;
  static double width = 0;

  static List<String> reportID = [];

  static List<Doctor> doctors = [];
  static Doctor doctor = Doctor();
  static Appointment appointment = Appointment();
  static String timeSlot = "";
  static String patientName = "";
  dimension(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}
