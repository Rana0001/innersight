import 'dart:io';

import 'package:flutter/material.dart';
import 'package:innersight/app/constant.dart';
import 'package:innersight/component/message.dart';
import 'package:innersight/services/services.dart';

import '../screens/all_records_screen.dart';

class Record extends StatefulWidget {
  Record({Key? key, this.issuedByController, this.images}) : super(key: key);
  TextEditingController? issuedByController = TextEditingController();
  List<File>? images;

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> {
  Widget _myTile(String title, String subtitle, BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: theme.primary,
        ),
      ),
    );
  }

  Widget _myTile2(
      String title, TextEditingController issuedBy, BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      subtitle: TextFormField(
        controller: issuedBy,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: theme.primary,
        ),
        decoration: const InputDecoration(
          helperText: 'Link Hospital, Doctor etc.',
        ),
      ),
    );
  }

  setRecord() async {
    try {
      bool result = await Services().setMedicalReport(
          "Reports", widget.images!, widget.issuedByController!.text);
      if (result) {
        setState(() {
          Messages.successMessage("Medical Reports Successful", context);
          Navigator.of(context).pushNamed(AllRecordsScreen.routeName);
        });
      } else {
        setState(() {
          Messages.errorMessage("Medical Reports Failed", context);
        });
      }
    } catch (err) {
      setState(() {
        Messages.errorMessage(err.toString(), context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
        height: 500,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 25,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.grey.withOpacity(0.3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _myTile(
                'Recent Medical Record of',
                '${Constant.patient.firstName} ${Constant.patient.lastName}',
                context),
            const SizedBox(height: 10),
            Divider(
              thickness: 1,
              color: const Color(0xffC4C4C4).withOpacity(0.3),
            ),
            const SizedBox(height: 10),
            const Text(
              'Type of record',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 15),
            Column(
              children: [
                Icon(
                  Icons.paste,
                  color: theme.primary,
                ),
                const SizedBox(height: 5),
                Text(
                  "Reports",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: theme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              thickness: 1,
              color: const Color(0xffC4C4C4).withOpacity(0.3),
            ),
            const SizedBox(height: 10),
            _myTile2("Issued by", widget.issuedByController!, context),
            const SizedBox(height: 10),
            Divider(
              thickness: 1,
              color: const Color(0xffC4C4C4).withOpacity(0.3),
            ),
            const SizedBox(height: 18),
            Container(
              height: 54,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () => setRecord(),
                child: const Text(
                  'Upload record',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ));
  }
}
