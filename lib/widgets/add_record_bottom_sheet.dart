import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

import '../screens/add_record_screen.dart';

class AddRecordButtomSheet extends StatefulWidget {
  const AddRecordButtomSheet({Key? key}) : super(key: key);

  @override
  State<AddRecordButtomSheet> createState() => _AddRecordButtomSheetState();
}

class _AddRecordButtomSheetState extends State<AddRecordButtomSheet> {
  Widget buildListTile(IconData icon, String title, VoidCallback tapHandler,
      BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: const Color(0xff677294),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xff677294),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: tapHandler,
    );
  }

  File? img;
  _browseImage(ImageSource imageSource) async {
    try {
      // Source is either Gallary or Camera
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => AddRecordScreen(
                        img: img,
                      )),
              (route) => true);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 5,
              width: 130,
              decoration: BoxDecoration(
                color: const Color(0xffC4C4C4),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Add a record',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          buildListTile(Icons.camera_alt_rounded, 'Take a photo', () {
            _browseImage(ImageSource.camera);
          }, context),
          buildListTile(Icons.photo, 'Upload from gallery', () {
            _browseImage(ImageSource.gallery);
          }, context),
          const SizedBox(height: 10),
        ]));
  }
}
