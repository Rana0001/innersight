import 'package:flutter/material.dart';
import 'package:innersight/services/services.dart';
import 'package:innersight/widgets/doctor_details_screen.dart';

import '../models/doctors.dart';

class PopularDoctors extends StatefulWidget {
  final double height;
  final double width;
  final double imageHeight;
  final double nameFont;
  final double titleFont;
  final double spacer;
  const PopularDoctors({
    required this.height,
    required this.width,
    required this.imageHeight,
    required this.nameFont,
    required this.titleFont,
    required this.spacer,
    Key? key,
  }) : super(key: key);

  @override
  State<PopularDoctors> createState() => _PopularDoctorsState();
}

class _PopularDoctorsState extends State<PopularDoctors> {
  List<Doctor> loadedDoctors = [];
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctors();
  }

  getDoctors() async {
    loadedDoctors = await Services().getAllDoctor();
    if (loadedDoctors != []) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SizedBox(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 20,
                mainAxisSpacing: 15,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: loadedDoctors.length,
              itemBuilder: (context, i) => Container(
                  width: widget.width,
                  margin: const EdgeInsets.only(right: 13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => DoctorDetailsScreen(
                                    doctor: loadedDoctors[i],
                                  )),
                          (route) => true);
                    },
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: widget.imageHeight,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0),
                              ),
                              child: Image.network(
                                loadedDoctors[i].profileURl!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          loadedDoctors[i].fullName != "Prashant Rana Magar"
                              ? Text(
                                  loadedDoctors[i].fullName!,
                                  style: TextStyle(
                                      fontSize: widget.nameFont,
                                      fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  "Prashant Magar",
                                  style: TextStyle(
                                      fontSize: widget.nameFont,
                                      fontWeight: FontWeight.w500),
                                ),
                          const SizedBox(height: 5),
                          loadedDoctors[i].speciality != ""
                              ? Text(loadedDoctors[i].speciality!,
                                  style: TextStyle(
                                      color: const Color(0xff677294),
                                      fontSize: widget.titleFont,
                                      fontWeight: FontWeight.w300))
                              : const Text(
                                  'Specialist Cardiologist ',
                                  style: TextStyle(
                                    color: Color(0xFF677294),
                                    fontSize: 14,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: -0.30,
                                  ),
                                ),
                          const SizedBox(height: 5),
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
                  )),
            ),
          );
  }
}
