import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/doctors.dart';

class DoctorCard extends StatelessWidget {
  final String id;
  const DoctorCard({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<Doctors>(context, listen: false);

    doctorProvider.getAllDoctors();

    final loadedDoctor =
        Provider.of<Doctors>(context, listen: false).findDoctorById(id);
    return Container(
        height: 88,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [
                Row(children: [
                  Container(
                      height: 68.09,
                      width: 71,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(4)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            loadedDoctor.profileURl!,
                            fit: BoxFit.cover,
                          ))),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                loadedDoctor.fullName!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          loadedDoctor.speciality != ""
                              ? Text(
                                  loadedDoctor.speciality!,
                                  style: const TextStyle(
                                    //color: theme.primary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : const Text(
                                  "Special Psychologist",
                                  style: TextStyle(
                                    //color: theme.primary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                          const SizedBox(height: 4),
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
                ]),
              ]),
            ]));
  }
}
