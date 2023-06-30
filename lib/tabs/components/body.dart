import 'package:flutter/material.dart';
import 'package:innersight/screens/chat_screen.dart';

import '../../models/doctors.dart';
import '../../services/services.dart';
import '../../widgets/top_bar2.dart';
import 'chat_card.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = true;
  List<Doctor> doctors = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctors();
  }

  Future<void> getDoctors() async {
    doctors = await Services().getAllDoctor();
    if (doctors != []) {
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
        : Column(
            children: [
              const Column(children: [
                TopBar2(),
              ]),
              Expanded(
                child: ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: ((context, index) => ChatCard(
                        chat: doctors[index],
                        press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                      doctor: doctors[index],
                                    ))),
                      )),
                ),
              )
            ],
          );
  }
}
