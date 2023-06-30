import 'package:flutter/material.dart';
import 'package:innersight/models/doctors.dart';
import 'package:innersight/screens/video_call.dart';

import 'components/body.dart';
import 'components/constants.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, this.doctor});
  Doctor? doctor;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(doctorId: widget.doctor!.uid),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const BackButton(),
          widget.doctor!.profileURl != ""
              ? CircleAvatar(
                  backgroundImage: NetworkImage(widget.doctor!.profileURl!),
                )
              : const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/chat/user_2.png'),
                ),
          const SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.doctor!.fullName == "Prashant Rana Magar"
                  ? const Text('Prashant Magar', style: TextStyle(fontSize: 16))
                  : const Text('Kristin Watson',
                      style: TextStyle(fontSize: 16)),
              const Text('Active', style: TextStyle(fontSize: 12))
            ],
          )
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, Meeting.routeName,
                  arguments: "Call");
            },
            icon: const Icon(Icons.call)),
        IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, Meeting.routeName,
                  arguments: "Video");
            },
            icon: const Icon(Icons.videocam)),
        const SizedBox(
          width: kDefaultPadding / 2,
        )
      ],
    );
  }
}
