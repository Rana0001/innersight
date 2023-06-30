import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:badges/badges.dart' as badges;
import 'package:innersight/app/constant.dart';
import 'package:innersight/component/message.dart';
import 'package:innersight/models/patient.dart';
import 'package:innersight/screens/tabs_screen.dart';
import 'package:innersight/services/services.dart';
import '../widgets/background.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = './profile-route';

  const ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? img;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  DateTime? selectedDate;

  Future updateProfile() async {
    Patient patient = Patient();
    patient.firstName = _firstNameController.text;
    patient.lastName = _lastNameController.text;
    patient.phone = _phoneController.text;
    patient.location = _locationController.text;

    if (img == null) {
      patient.profileUrl = Constant.patient.profileUrl;
      bool result =
          await Services().updateProfile(patient: patient, context: context);
      if (result) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const TabsScreen()),
            (Route<dynamic> route) => false);
      } else {
        Messages.errorMessage('Error on Updating Profile', context);
      }
    } else {
      bool result = await Services()
          .updateProfile(patient: patient, img: img!, context: context);
      if (result) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const TabsScreen()),
            (Route<dynamic> route) => false);
      } else {
        Messages.errorMessage('Error on Updating Profile', context);
      }
    }
  }

  Future _browseImage(ImageSource imageSource) async {
    try {
      // Source is either Gallary or Camera
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          // Open camera logic
                          _browseImage(ImageSource.camera);
                        },
                        title: const Text(
                          'Open Camera',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        onTap: () {
                          // Open gallery logic
                          _browseImage(ImageSource.gallery);
                        },
                        title: const Text(
                          'Open Gallery',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        title: const Center(child: Text('Cancel')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            leadingWidth: 40,
            leading: Container(
              height: 11,
              margin: const EdgeInsets.only(top: 10, left: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const TabsScreen()),
                      (route) => false);
                },
                padding: const EdgeInsets.only(left: 7),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 13,
                  color: Color(0xff677294),
                ),
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
            backgroundColor: theme.primary,
            title: const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )),
          )),
      body: SafeArea(
        child: BackGround(
          shadowTop: false,
          shadowBottom: false,
          widget: SingleChildScrollView(
            primary: false,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // ProfileEdit(value: myValue, title: myTitle),
              Container(
                height: 357,
                padding: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: theme.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Set up your profile',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Update your profile to connect your doctor with better impression.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.7,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                          height: 130,
                          width: 130,
                          child: badges.Badge(
                            badgeAnimation: const badges.BadgeAnimation.fade(),

                            //toAnimate: false,
                            badgeContent: CircleAvatar(
                                radius: 18,
                                backgroundColor:
                                    const Color(0xff677294).withOpacity(0.5),
                                child: IconButton(
                                  onPressed: () => _showOptionsDialog(context),
                                  icon: const Icon(Icons.camera_alt_rounded,
                                      color: Colors.white),
                                )),
                            badgeStyle: badges.BadgeStyle(
                              badgeColor:
                                  const Color(0xff677294).withOpacity(0.5),
                              padding: const EdgeInsets.all(4),
                            ),
                            position: badges.BadgePosition.bottomEnd(
                                bottom: 15, end: -7),
                            child:
                                Constant.patient.profileUrl != "" && img == null
                                    ? CircleAvatar(
                                        radius: 65,
                                        backgroundImage: NetworkImage(
                                            Constant.patient.profileUrl!),
                                      )
                                    : Constant.patient.profileUrl == "" &&
                                            img == null
                                        ? const CircleAvatar(
                                            radius: 65,
                                            backgroundImage: AssetImage(
                                                'assets/images/patient.png'),
                                          )
                                        : CircleAvatar(
                                            radius: 65,
                                            backgroundImage: FileImage(img!),
                                          ),
                          ))
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Personal Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _firstNameController,
                  onSaved: (newValue) {
                    _firstNameController.text = newValue!;
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'First Name',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      hintText: 'Enter your first name',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15),
                        child: SvgPicture.asset(
                          "assets/svg/profile.svg",
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _lastNameController,
                  onSaved: (newValue) {
                    _lastNameController.text = newValue!;
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Last Name',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      hintText: 'Enter your last name',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15),
                        child: SvgPicture.asset(
                          "assets/svg/profile.svg",
                        ),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _phoneController,
                  onSaved: (newValue) {
                    _phoneController.text = newValue!;
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Phone Number',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      hintText: 'Enter your phone number',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(Icons.phone),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _locationController,
                  onSaved: (newValue) {
                    _locationController.text = newValue!;
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Location',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      hintText: 'Enter your location',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(Icons.pin_drop),
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      updateProfile();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Update your Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
