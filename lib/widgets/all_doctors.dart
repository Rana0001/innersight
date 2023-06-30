import 'package:flutter/material.dart';
import 'package:innersight/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

import './search_result.dart';

import '../provider/doctors.dart';
import '../widgets/doctor_types.dart';

class AllDoctor extends StatefulWidget {
  static String routeName = "/all-doctors";
  final bool state;
  const AllDoctor({Key? key, this.state = false}) : super(key: key);

  @override
  _AllDoctors createState() => _AllDoctors();
}

class _AllDoctors extends State<AllDoctor> {
  String query = '';
  final _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Doctors>(context, listen: false).getAllDoctors();
    final suggestionList = query.isEmpty
        ? Provider.of<Doctors>(context, listen: false).getDoctors
        : Provider.of<Doctors>(context, listen: false).searchDoctorType(query);
    String header =
        Provider.of<Doctors>(context, listen: false).getSearchHeader;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          if (widget.state)
            const Text(
              'Doctors',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          if (!widget.state)
            Row(children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const TabsScreen()),
                      (route) => false),
                  padding: const EdgeInsets.only(left: 7),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 13,
                    color: Color(0xff677294),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                header,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )
            ]),
          const SizedBox(height: 30),
          if (widget.state) const DoctorTypes(),
          if (widget.state) const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              primary: false,
              padding: EdgeInsets.zero,
              itemCount: suggestionList.length,
              itemBuilder: (context, i) => SearchResult(
                id: suggestionList[i].uid!,
                name: suggestionList[i].fullName!,
                type: suggestionList[i].speciality!,
                experience: suggestionList[i].experience!,
                rating: "5",
                hospital: suggestionList[i].hospital!,
                price: suggestionList[i].price!,
                image: suggestionList[i].profileURl!,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
