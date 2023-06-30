import 'package:innersight/screens/select_time_screen.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  final String id;
  final String name;
  final String type;
  final String experience;
  final String rating;
  final String image;
  final String price;
  final String hospital;
  const SearchResult({
    required this.id,
    required this.name,
    required this.type,
    required this.experience,
    required this.rating,
    required this.image,
    required this.price,
    required this.hospital,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
        height: 175,
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        // onTap: () {
        //   check = true;
        //   // query = suggestionList[index].type;
        //   //close(context, suggestionList[index].type);
        //   showResults(context);
        // },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [
                Row(children: [
                  Container(
                      height: 87,
                      width: 92,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(4)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            image,
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
                                name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            type,
                            style: TextStyle(
                              color: theme.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          experience != ""
                              ? Text(
                                  '$experience Years experience ',
                                  style: const TextStyle(
                                    color: Color(0xff677294),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              : const Text(
                                  '5 Years experience ',
                                  style: TextStyle(
                                    color: Color(0xff677294),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                          const SizedBox(height: 7),
                          Row(children: [
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: theme.primary,
                            ),
                            Text(
                              '  $rating%',
                              style: const TextStyle(
                                color: Color(0xff677294),
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(width: 20),
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: theme.primary,
                            ),
                            const Text(
                              '  50 Patients',
                              style: TextStyle(
                                color: Color(0xff677294),
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ])
                        ]),
                  ),
                ]),
              ]),
              const Spacer(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                minVerticalPadding: 0,
                title: Text(
                  'Hospital',
                  style: TextStyle(
                    color: theme.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: RichText(
                  text: TextSpan(
                    text: hospital,
                    style: const TextStyle(
                        color: Color(0xff677294),
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                trailing: SizedBox(
                    height: 34,
                    width: 112,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              SelectTimeScreen.routeName,
                              arguments: id);
                        },
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ))),
              )
            ])
        // RichText(
        //   text: TextSpan(
        //     text: suggestionList[index].food.substring(0, query.length),
        //     style: const TextStyle(
        //         color: Colors.black, fontWeight: FontWeight.bold),
        //     children: [
        //       TextSpan(
        //         text: suggestionList[index].food.substring(query.length),
        //         style: const TextStyle(color: Colors.grey),
        //       ),
        //     ],
        //   ),
        // ),
        //trailing: Provider.of<Foods>(context, listen: false).findSearch(query).isEmpty ? Text("aa") : null,
        );
  }
}
