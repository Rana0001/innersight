import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../widgets/background.dart';
import '../widgets/add_images.dart';
import '../widgets/record.dart';

class AddRecordScreen extends StatefulWidget {
  static const routeName = './add-record-route';
  AddRecordScreen({Key? key, this.img}) : super(key: key);
  String? reportUrl;
  File? img;
  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  TextEditingController issuedByController = TextEditingController();
  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            toolbarHeight: 48,
            leadingWidth: 48,
            title: const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Add Records',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                )),
            leading: Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.only(left: 16, top: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                padding: const EdgeInsets.only(left: 7),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 13,
                  color: Color(0xff677294),
                ),
              ),
            ),
          ),
          body: BackGround(
            shadowTop: true,
            widget: SingleChildScrollView(
              child: (Column(children: [
                const SizedBox(height: 10),
                AddImage(img: widget.img!, images: images),
                const SizedBox(height: 40),
                Record(issuedByController: issuedByController,images: images),
              ])),
            ),
          )),
    );
  }
}
