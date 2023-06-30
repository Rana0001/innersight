import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart' show DateFormat;

class AppointmentCalender extends StatefulWidget {
  const AppointmentCalender({Key? key}) : super(key: key);

  @override
  _AppointmentCalenderState createState() => _AppointmentCalenderState();
}

class _AppointmentCalenderState extends State<AppointmentCalender> {
  DateTime _currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String _currentMonth = DateFormat('MMMM yyyy').format(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));

  DateTime _targetDateTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  bool _isSelectableDate(DateTime date) {
    final currentDate = DateTime.now();
    return !date.isBefore(currentDate);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final calendarCarouselNoHeader = CalendarCarousel<Event>(
      weekdayTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      todayBorderColor: theme.primary,
      onDayPressed: (date, events) {
        if (_isSelectableDate(date)) {
          setState(() => _currentDate = date);
          events.map((event) => print(event.title));
          print('pressed date $date');
        }
      },
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      weekFormat: false,
      height: 290,
      selectedDateTime: _currentDate,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      showHeader: false,
      todayTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      todayButtonColor: theme.primary.withOpacity(0.3),
      selectedDayTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      selectedDayButtonColor: theme.primary,
      minSelectedDate: _currentDate.subtract(const Duration(days: 1825)),
      maxSelectedDate: _currentDate.add(const Duration(days: 1825)),
      prevDaysTextStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.grey,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: theme.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          height: 52,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _currentMonth,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () {
                  setState(() {
                    _targetDateTime = DateTime(
                        _targetDateTime.year, _targetDateTime.month - 1);
                    _currentMonth =
                        DateFormat('MMMM yyyy').format(_targetDateTime);
                  });
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () {
                  setState(() {
                    _targetDateTime = DateTime(
                        _targetDateTime.year, _targetDateTime.month + 1);
                    _currentMonth =
                        DateFormat('MMMM yyyy').format(_targetDateTime);
                  });
                },
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: calendarCarouselNoHeader,
        ),
      ],
    );
  }
}
