import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/doctors.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final loadedDoctors =
        Provider.of<Doctors>(context, listen: false).getDoctors;
    final mediaQuery = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          'Category',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: mediaQuery * 0.6,
          child: ListView.builder(
            itemCount: loadedDoctors.length,
            itemBuilder: (_, i) => Container(
              height: 104,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(children: [
                      Row(children: [
                        Container(
                            height: 82,
                            width: 82,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  loadedDoctors[i].profileURl!,
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
                                      loadedDoctors[i].fullName!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                Text(
                                  loadedDoctors[i].hospital!,
                                  style: const TextStyle(
                                    //color: theme.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(children: [
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
                                ])
                              ]),
                        ),
                      ]),
                    ]),
                  ]),
            ),
          ),
        )

        //ListView.builder(itemCount: 10, itemBuilder: (_, i) => Text('Checker'))
      ],
    );
  }
}
