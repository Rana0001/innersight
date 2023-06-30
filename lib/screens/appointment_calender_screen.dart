import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:innersight/app/constant.dart';
import 'package:innersight/models/appointment_book.dart';
import 'package:innersight/models/payment.dart';
import 'package:innersight/services/services.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:khalti_flutter/khalti_flutter.dart';

import '../widgets/background.dart';
import '../widgets/available_time.dart';
import '../screens/tabs_screen.dart';
import '../widgets/core.dart';

class AppointmentCalenderScreen extends StatefulWidget {
  static const routeName = './calender-route';

  AppointmentCalenderScreen(
      {Key? key, this.docID, this.patientName, this.contactNo})
      : super(key: key);
  String? docID;
  TextEditingController? patientName;
  TextEditingController? contactNo;

  @override
  State<AppointmentCalenderScreen> createState() =>
      _AppointmentCalenderScreenState();
}

class _AppointmentCalenderScreenState extends State<AppointmentCalenderScreen> {
  void _showSuccessDialog(BuildContext context, String date, String timeSlot) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              //contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              content: SizedBox(
                height: 520,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 78,
                        backgroundColor: const Color(0xffE7F8F2),
                        child: Icon(Icons.thumb_up,
                            size: 70,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      const Text(
                        'Thank You!',
                        style: TextStyle(
                            fontSize: 38, fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        'Your Appointment Successful',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff677294),
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'You booked an appointment on ${DateFormat('yyyy-MM-dd').format(selectedDate!)}, at ${Constant.timeSlot} with Dr.${Constant.doctor.fullName}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xff677294),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                          height: 54,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 0),
                            onPressed: () {
                              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyHomeScreen()), (Route<dynamic> route) => route.isFirst);
                              Navigator.of(context)
                                  .pushNamed(TabsScreen.routeName);
                            },
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          )),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0),
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const Text(
                            'Edit your appointment',
                            style: TextStyle(
                                color: Color(0xff677294),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ]),
              ),
            ));
  }

  List<String> availableDates = [];
  getAppointment(String selectedDate) async {
    debugPrint(selectedDate);
    debugPrint(widget.docID);
    availableDates =
        await Services().getAppointment(selectedDate, widget.docID!);
  }

  Future payment() async {
    Payment payment = Payment();
    payment.amount = "5000";
    payment.billDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    payment.contact = widget.contactNo!.text;
    payment.status = "Paid";
    payment.docID = widget.docID!;

    bool result = await Services().makePayment(payment, context);
    if (result) {
      debugPrint("Payment Successful");
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong!'),
            duration: Duration(seconds: 2),
          ),
        );
      });
    }
  }

  Future bookAppointment() async {
    payment();
    AppointmentBooked appointmentBooked = AppointmentBooked();
    appointmentBooked.doctorId = widget.docID;

    appointmentBooked.patientName = widget.patientName!.text;
    appointmentBooked.contactNo = widget.contactNo!.text;
    appointmentBooked.date = DateFormat('yyyy-MM-dd').format(selectedDate!);
    appointmentBooked.timeSlot = Constant.timeSlot;
    bool result = await Services().bookAppointment(appointmentBooked, context);
    if (result) {
      setState(() {
        _showSuccessDialog(
            context, appointmentBooked.date!, appointmentBooked.timeSlot!);
      });
    } else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong!'),
            duration: Duration(seconds: 2),
          ),
        );
      });
    }
  }

  DateTime? selectedDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(widget.docID);
  }

  String? selected = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScaffoldBodyWidget(
        child: SafeArea(
          child: BackGround(
            shadowTop: true,
            widget: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        padding: const EdgeInsets.only(left: 7),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 13,
                          color: Color(0xff677294),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Appointment',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            hintText: selectedDate != null
                                ? DateFormat('yyyy-MM-dd').format(
                                    selectedDate!) // Display the selected date
                                : "Select a date",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15),
                              child: SvgPicture.asset(
                                "assets/svg/calendar.svg",
                              ),
                            )),
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 100),
                          );

                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                              getAppointment(DateFormat('yyyy-MM-dd')
                                  .format(selectedDate!));
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  height: 220,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45),
                      topRight: Radius.circular(45),
                    ),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AvailableTime(
                            date: DateFormat('yyyy-MM-dd')
                                    .format(selectedDate!) ??
                                "",
                            docID: widget.docID ?? "",
                            selected: selected,
                            availableDates: availableDates,
                          ),
                        ),

                        /// Gap
                      ]),
                ),
                SizedBox(
                    height: 54,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: () {
                        KhaltiScope.of(context).pay(
                          config: PaymentConfig(
                            amount: 10000,
                            productIdentity: 'BookingTransaction',
                            productName: 'Appointment',
                          ),
                          preferences: [
                            PaymentPreference.khalti,
                            PaymentPreference.mobileBanking,
                            PaymentPreference.connectIPS,
                            PaymentPreference.eBanking
                          ],
                          onSuccess: (su) {
                            bookAppointment();
                            const successsnackBar = SnackBar(
                              content: Text(
                                'Payment Successful',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              backgroundColor: Colors.green,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(successsnackBar);
                          },
                          onFailure: (fa) {
                            const failedsnackBar = SnackBar(
                              content: Text(
                                'Payment Failed',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(failedsnackBar);
                          },
                          onCancel: () {
                            const cancelsnackBar = SnackBar(
                              content: Text(
                                'Payment Cancelled',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(cancelsnackBar);
                          },
                        );
                      },
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    )),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
