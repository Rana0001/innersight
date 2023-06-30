import 'package:flutter/material.dart';

class GoogleFacebookCard extends StatelessWidget {
  GoogleFacebookCard({Key? key, this.name}) : super(key: key);
  String? name;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Colors.grey.withOpacity(0.3),
          ),
        ],
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 25,
                child: Image.asset('assets/images/google-logo.png')),
            const SizedBox(width: 10),
            Text(
              name!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Color(0xff677294),
              ),
            ),
          ]),
    );
  }
}
