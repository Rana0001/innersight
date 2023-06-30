import 'package:flutter/material.dart';
import 'package:innersight/app/constant.dart';
import 'package:innersight/services/services.dart';

import '../utils/app_colors.dart';
import '../utils/app_gaps.dart';

class AvailableTime extends StatefulWidget {
  AvailableTime({
    Key? key,
    this.date,
    this.docID,
    this.availableDates,
    this.selected,
  }) : super(key: key);

  String? date;
  String? docID;
  String? selected;
  List<String>? availableDates;

  @override
  _AvailableTimeState createState() => _AvailableTimeState();
}

class _AvailableTimeState extends State<AvailableTime> {
  late Future<List<String>> fetchData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SizedBox(
        child: FutureBuilder<List<String>>(
          future: Services().getAppointment(widget.date, widget.docID!),
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              );
            }

            if (snapshot.hasError) {
              return CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(child: AppGaps.hGap24),
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Available Appointment',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        AppGaps.hGap16,
                        Center(
                          child: Text(
                            'No available appointment',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            final availableDates = snapshot.data;
            return CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: AppGaps.hGap24),
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Appointment',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      AppGaps.hGap16,
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: availableDates!.map((date) {
                          final isBooked = (widget.selected == date);
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!isBooked) {
                                  widget.selected = date;
                                  Constant.timeSlot = date;
                                  debugPrint(widget.selected);
                                } else {
                                  widget.selected = '';
                                  Constant.timeSlot = '';
                                }
                              });
                            },
                            child: Container(
                              width: 100,
                              height: 50,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isBooked
                                    ? AppColors.primaryColor.withOpacity(0.5)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  date,
                                  style: TextStyle(
                                    color: isBooked
                                        ? Colors.white
                                        : AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
