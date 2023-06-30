import 'package:flutter/material.dart';
import 'package:innersight/app/constant.dart';
import 'package:innersight/component/message.dart';

import '../screens/appointment_calender_screen.dart';

class PatientInfo extends StatefulWidget {
  PatientInfo({Key? key, this.docID, this.patientName, this.contactNo})
      : super(key: key);
  String? docID;
  TextEditingController? patientName;
  TextEditingController? contactNo;

  @override
  State<PatientInfo> createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(widget.docID);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Container(
            height: 54,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 0),
              onPressed: () {
                if (widget.patientName!.text == "" ||
                    widget.contactNo!.text == "") {
                  Messages.errorMessage("Please Fill Both Field", context);
                } else {
                  debugPrint(widget.patientName!.text);
                  Constant.patientName = widget.patientName!.text;
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => AppointmentCalenderScreen(
                                contactNo: widget.contactNo,
                                patientName: widget.patientName,
                                docID: widget.docID,
                              )),
                      (route) => true);
                }
              },
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )),
        const SizedBox(height: kBottomNavigationBarHeight),
      ],
    );
  }
}
