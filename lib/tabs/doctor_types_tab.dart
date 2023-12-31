import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/search_result.dart';

import '../provider/doctors.dart';
import '../widgets/doctor_types.dart';

class DoctorTypesTab extends StatefulWidget {
  const DoctorTypesTab({Key? key}) : super(key: key);

  @override
  _DoctorTypesTabState createState() => _DoctorTypesTabState();
}

class _DoctorTypesTabState extends State<DoctorTypesTab> {
  String query = '';
  final _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<Doctors>(context, listen: false);

    doctorProvider.getAllDoctors();

    final suggestionList = query.isEmpty
        ? Provider.of<Doctors>(context, listen: false).getDoctors
        : Provider.of<Doctors>(context, listen: false).searchDoctorType(query);
    String header =
        Provider.of<Doctors>(context, listen: false).getSearchHeader;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        const SizedBox(height: 20),
        Row(children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () => Provider.of<Doctors>(context, listen: false)
                  .setScreenState(false),
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          )
        ]),
        const SizedBox(height: 30),
        TextField(
          autofocus: true,
          onChanged: (val) => {
            setState(() {
              query = val;
            })
          },
          controller: _controller,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                  setState(() => query = '');
                },
                icon: const Icon(Icons.close, color: Color(0xff677294))),
            hintText: 'Search...(Eg. Dentist)',
            hintStyle: const TextStyle(
              color: Color(0xff677294),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const DoctorTypes(),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: suggestionList.length,
            itemBuilder: (context, i) => SearchResult(
              id: suggestionList[i].uid!,
              name: suggestionList[i].fullName!,
              type: suggestionList[i].speciality!,
              experience: suggestionList[i].experience!,
              rating: "5",
              price: suggestionList[i].price!,
              hospital: suggestionList[i].hospital!,
              image: suggestionList[i].profileURl!,
            ),
          ),
        ),
      ]),
    );
  }
}
