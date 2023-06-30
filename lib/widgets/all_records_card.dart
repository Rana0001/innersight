import 'package:flutter/material.dart';
import 'package:innersight/app/constant.dart';
import 'package:innersight/component/message.dart';
import 'package:innersight/services/services.dart';
import 'package:innersight/widgets/add_record_bottom_sheet.dart';

class AllRecordsCard extends StatefulWidget {
  const AllRecordsCard({Key? key}) : super(key: key);

  @override
  State<AllRecordsCard> createState() => _AllRecordsCardState();
}

class _AllRecordsCardState extends State<AllRecordsCard> {
  void _bottomSheet(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: ctx,
      builder: (_) {
        return const AddRecordButtomSheet();
      },
    );
  }

  _showDialogBox(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete Record'),
            content: const Text('Are you sure you want to delete this record?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () async {
                    bool value =
                        await Services().deleteReport(Constant.reportID[index]);
                    if (value) {
                      setState(() {
                        Navigator.pop(context);

                        Messages.successMessage("Record Deleted", context);
                      });
                    } else {
                      setState(() {
                        Messages.errorMessage(
                            "Error on deleting records", context);
                      });
                    }
                  },
                  child: const Text('Yes')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: Services().getReports(),
                  initialData: const [],
                  builder: (context, snapshot) {
                    if (snapshot.data!.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 107,
                                  backgroundColor: const Color(0xffC6EFE5),
                                  child: Icon(Icons.paste_rounded,
                                      color: theme.primary, size: 120)),
                              const SizedBox(height: 40),
                              const Text(
                                'Add a medical records',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'A detailed health history helps a doctor diagnose you btter.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff677294),
                                ),
                              ),
                              const SizedBox(height: 35),
                              Container(
                                height: 54,
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () => _bottomSheet(context),
                                  child: const Text(
                                    'Add a record',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                            ]),
                      );
                    } else {
                      debugPrint("hello");
                      return Column(
                        children: [
                          ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var e = snapshot.data![index];

                                return Container(
                                  height: 110,
                                  padding: const EdgeInsets.only(
                                      top: 11, left: 11, bottom: 11),
                                  margin: const EdgeInsets.only(bottom: 11),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5.0,
                                        color: Colors.grey.withOpacity(0.3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Column(children: [
                                              Container(
                                                  height: 60,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: theme.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          e.dateOfUpload!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ])),
                                              const Spacer(),
                                              Container(
                                                height: 22,
                                                width: 100,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: theme.primary
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                ),
                                                child: Text(
                                                  'NEW',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: theme.primary,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            const SizedBox(width: 10),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    'Reports added by you',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Issued by ${e.issuedBY}',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: theme.primary,
                                                    ),
                                                  ),
                                                ])
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _showDialogBox(context, index);
                                          },
                                          icon: const Icon(Icons.delete,
                                              size: 30,
                                              color: Color(0xff677294)))
                                    ],
                                  ),
                                );
                              }),
                          const SizedBox(height: 35),
                          Container(
                            height: 54,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () => _bottomSheet(context),
                              child: const Text(
                                'Add a record',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
