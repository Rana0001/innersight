import 'package:flutter/material.dart';
import 'package:innersight/app/constant.dart';
import 'package:innersight/models/doctors.dart';
import 'package:innersight/services/services.dart';
import 'package:innersight/widgets/appointment_form.dart';
import 'package:innersight/widgets/patient_info.dart';

import '../screens/chat_screen.dart';

class NextAvailable extends StatefulWidget {
  NextAvailable({Key? key, this.doctorId}) : super(key: key);
  String? doctorId;
  @override
  _NextAvailableState createState() => _NextAvailableState();
}

class _NextAvailableState extends State<NextAvailable> {
  final currDt = DateTime.now();
  bool _switcher = true;
  TextEditingController patientName = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  Doctor doctor = Doctor();
  getDoctor() async {
    
    doctor = await Services().getDoctor(widget.doctorId!);
    
  }

  @override
  void initState() {
    super.initState();
    getDoctor();
  }

  void _openChatScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  ChatScreen(doctor:doctor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (_switcher)
            SizedBox(
              height: 54,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() => _switcher = false);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Check Available Date',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (!_switcher)
            AppointmentForm(contactName: contactNo, patientName: patientName),
          if (!_switcher)
            PatientInfo(
                docID: widget.doctorId,
                contactNo: contactNo,
                patientName: patientName),
          if (_switcher) const SizedBox(height: 20),
          if (_switcher)
            const Text(
              'OR',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff677294),
              ),
            ),
          if (_switcher) const SizedBox(height: 20),
          if (_switcher)
            SizedBox(
              height: 54,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _openChatScreen(context),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: BorderSide(
                    color: theme.primary,
                  ),
                ),
                child: Text(
                  'Chat with Me',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: theme.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
