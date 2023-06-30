import 'package:flutter/material.dart';
import 'package:innersight/screens/select_time_screen.dart';
import 'package:innersight/widgets/background.dart';

import '../models/doctors.dart';
import '../screens/tabs_screen.dart';

class DoctorDetailsScreen extends StatelessWidget {
  DoctorDetailsScreen({
    Key? key,
    this.doctor,
  }) : super(key: key);
  Doctor? doctor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 50,
          leadingWidth: 48,
          title: const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                'Doctor Details',
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
              onPressed: () =>
                  Navigator.of(context).popAndPushNamed(TabsScreen.routeName),
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
          widget: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                const Positioned(
                  left: 20,
                  top: 450,
                  child: Text(
                    'Payment System',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 18,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.30,
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 480,
                  child: SizedBox(
                    width: 335,
                    height: 210,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: SizedBox(
                            width: 335,
                            height: 210,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    width: 335,
                                    height: 210,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x14000000),
                                          blurRadius: 30,
                                          offset: Offset(0, 0),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 8,
                                  top: 10,
                                  child: Container(
                                    width: 318,
                                    height: 190.06,
                                    decoration: ShapeDecoration(
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                            "https://via.placeholder.com/318x190"),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 19,
                  top: 250,
                  child: SizedBox(
                    width: 338,
                    height: 200,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 1,
                          top: 132,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '3.',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.30,
                                  ),
                                ),
                                const TextSpan(
                                  text: '   ',
                                  style: TextStyle(
                                    color: Color(0xE5677294),
                                    fontSize: 14,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: -0.30,
                                  ),
                                ),
                                const TextSpan(
                                  text:
                                      'Patient can reuse missed appointment until and \n       unless they have the valid reason.',
                                  style: TextStyle(
                                    color: Color(0xE5677294),
                                    fontSize: 14,
                                    overflow: TextOverflow.visible,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 1,
                          top: 85,
                          child: SizedBox(
                            width: 335,
                            height: 30,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 30,
                                  child: Container(
                                    width: 335,
                                    decoration: const ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 0.40,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: Color(0x19677294),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '2.',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 13,
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.30,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '   ',
                                          style: TextStyle(
                                            color: Color(0xE5677294),
                                            fontSize: 13,
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: -0.30,
                                          ),
                                        ),
                                        const TextSpan(
                                          text:
                                              'Available 24 hours for emergency work.',
                                          style: TextStyle(
                                            color: Color(0xE5677294),
                                            fontSize: 13,
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 1,
                          top: 38,
                          child: SizedBox(
                            width: 335,
                            height: 30,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 30,
                                  child: Container(
                                    width: 335,
                                    decoration: const ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 0.40,
                                          strokeAlign:
                                              BorderSide.strokeAlignCenter,
                                          color: Color(0x19677294),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '1.',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 13,
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.30,
                                          ),
                                        ),
                                        const TextSpan(
                                          text: '   ',
                                          style: TextStyle(
                                            color: Color(0xE5677294),
                                            fontSize: 13,
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: -0.30,
                                          ),
                                        ),
                                        const TextSpan(
                                          text:
                                              'Patient care is my number one priority.',
                                          style: TextStyle(
                                            color: Color(0xE5677294),
                                            fontSize: 13,
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 0,
                          top: 0,
                          child: Text(
                            'Services',
                            style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: 18,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 50,
                  child: SizedBox(
                    width: 335,
                    height: 170,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 335,
                            height: 170,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x14000000),
                                  blurRadius: 20,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 98,
                          top: 120,
                          child: SizedBox(
                            width: 140,
                            height: 32,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          SelectTimeScreen.routeName,
                                          arguments: doctor!.uid);
                                    },
                                    child: Container(
                                      width: 140,
                                      height: 32,
                                      decoration: ShapeDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  left: 37,
                                  top: 7,
                                  child: Text(
                                    'Book Now',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 123,
                          top: 25,
                          child: SizedBox(
                            width: 203,
                            height: 74,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 2,
                                  child: SizedBox(
                                    width: 203,
                                    height: 72,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 26,
                                          child: doctor!.speciality != ""
                                              ? Text(
                                                  '${doctor!.speciality} ',
                                                  style: const TextStyle(
                                                    color: Color(0xFF677294),
                                                    fontSize: 14,
                                                    fontFamily: 'Rubik',
                                                    fontWeight: FontWeight.w300,
                                                    letterSpacing: -0.30,
                                                  ),
                                                )
                                              : const Text(
                                                  'Psychologist Specialist',
                                                  style: TextStyle(
                                                    color: Color(0xFF677294),
                                                    fontSize: 14,
                                                    fontFamily: 'Rubik',
                                                    fontWeight: FontWeight.w300,
                                                    letterSpacing: -0.30,
                                                  ),
                                                ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Text(
                                            'Dr. ${doctor!.fullName}',
                                            style: const TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 18,
                                              fontFamily: 'Rubik',
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.30,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 126,
                                          top: 52,
                                          child: SizedBox(
                                            width: 77,
                                            height: 20,
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: '\$',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: 16,
                                                      fontFamily: 'Rubik',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -0.30,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: ' ',
                                                    style: TextStyle(
                                                      color: Color(0xFF333333),
                                                      fontSize: 16,
                                                      fontFamily: 'Rubik',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: -0.30,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text: '25.00/hr',
                                                    style: TextStyle(
                                                      color: Color(0xE5677294),
                                                      fontSize: 14,
                                                      fontFamily: 'Rubik',
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      letterSpacing: -0.30,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 57,
                                  child: SizedBox(
                                    width: 83,
                                    height: 12.45,
                                    child: Stack(children: [
                                      SizedBox(
                                        height: 20,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 5,
                                          itemBuilder: (_, i) => Icon(
                                            Icons.star,
                                            size: 16,
                                            color: i == 4
                                                ? Colors.grey
                                                : const Color(0xffF6D060),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 19,
                          top: 18,
                          child: Container(
                            width: 92,
                            height: 87,
                            decoration: ShapeDecoration(
                              image: doctor!.profileURl != null
                                  ? DecorationImage(
                                      image: NetworkImage(doctor!.profileURl!),
                                      fit: BoxFit.cover,
                                    )
                                  : const DecorationImage(
                                      image: NetworkImage(
                                          "https://via.placeholder.com/92x87"),
                                      fit: BoxFit.cover,
                                    ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
