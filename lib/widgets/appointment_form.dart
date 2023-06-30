import 'package:flutter/material.dart';

class AppointmentForm extends StatelessWidget {
  const AppointmentForm({Key? key, this.patientName, this.contactName})
      : super(key: key);
  final TextEditingController? patientName;
  final TextEditingController? contactName;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        'Appointment For',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 15),
      TextFormField(
        onSaved: (newValue) {
          patientName!.text = newValue ?? "";
        },
        controller: patientName,
        decoration: InputDecoration(
          hintText: 'Patient Name',
          hintStyle: const TextStyle(
            color: Color(0xff677294),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: const Color(0xff677294).withOpacity(0.12),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: const Color(0xff677294).withOpacity(0.12),
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      TextFormField(
        onSaved: (newValue) {
          contactName!.text = newValue ?? '';
        },
        controller: contactName,
        decoration: InputDecoration(
          hintText: 'Contact Number',
          hintStyle: const TextStyle(
            color: Color(0xff677294),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: const Color(0xff677294).withOpacity(0.12),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: const Color(0xff677294).withOpacity(0.12),
            ),
          ),
        ),
      ),
    ]);
  }
}
