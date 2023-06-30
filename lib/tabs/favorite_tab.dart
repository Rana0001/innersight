import 'package:flutter/material.dart';

import 'components/body.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  final int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: buildAppBar(),
      body: Body(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (() {}),
      //   backgroundColor: kPrimaryColor,
      //   child: const Icon(Icons.person_add_alt_1, color: Colors.white),
      // ),
    );
  }
}
