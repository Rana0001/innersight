import 'package:flutter/material.dart';

class TopBar2 extends StatelessWidget {
  const TopBar2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0)),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              theme.colorScheme.primary,
              theme.primaryColor,
            ],
          ),
        ),
      ),
      const Positioned(
        top: 20,
        left: 15,
        right: 15,
        child: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Welcome',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
            Text(
              'Chat With Your Doctor',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
            ),
          ]),
        ]),
      ),
    ]);
  }
}
