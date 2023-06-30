import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:innersight/app/constant.dart';
import 'package:innersight/models/fake_models/chat_screen_widgets.dart';
import 'package:innersight/utils/app_gaps.dart';

import '../../component/message.dart';
import '../../models/chat_room.dart';
import '../../services/chat_room.dart';
import '../../utils/app_colors.dart';
import 'constants.dart';

class Body extends StatefulWidget {
  Body({super.key, this.doctorId});
  String? doctorId;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController? sendController = TextEditingController();

  List<dynamic> messages = [];

  sendMessage() async {
    ChatRoom chatRoom = ChatRoom();
    chatRoom.doctorId = widget.doctorId;
    chatRoom.dateTimeText = DateTime.now().toString();
    chatRoom.patientMsg = true;
    chatRoom.messages = sendController!.text;
    chatRoom.patientId = Constant.patient.id;
    try {
      await ChatRoomService().sendMessage(chatRoom);
    } catch (err) {
      Messages.errorMessage(err.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: StreamBuilder(
                stream: ChatRoomService().getMessage(widget.doctorId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot dataSnapshot =
                          snapshot.data as QuerySnapshot;

                      if (dataSnapshot.docs.isNotEmpty) {
                        return ListView.separated(
                          padding: const EdgeInsets.only(top: 17, bottom: 30),
                          separatorBuilder: (context, index) => AppGaps.hGap24,
                          itemCount: dataSnapshot.docs.length,
                          itemBuilder: (context, index) {
                            ChatRoom chatRoom = ChatRoom.fromJson(
                                dataSnapshot.docs[index].data()
                                    as Map<String, dynamic>);

                            return ChatScreenWidgets
                                .getCustomDeliveryChatWidget(
                                    chatMessage: chatRoom);
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("No Message"),
                        );
                      }
                    } else {
                      return const Center(
                        child: Text("No Message"),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }
                })),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                    blurRadius: 32,
                    offset: const Offset(0, 4),
                    color: const Color(0xff087949).withOpacity(0.3))
              ]),
          child: SafeArea(
              child: Row(
            children: [
              const Icon(Icons.mic, color: kPrimaryColor),
              const SizedBox(width: kDefaultPadding),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 0.75),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: kDefaultPadding / 2),
                      Expanded(
                        child: TextFormField(
                          controller: sendController,
                          onSaved: (newValue) {
                            sendController?.text = newValue!;
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type Message'),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          sendMessage();
                        },
                        icon: Icon(
                          Icons.send,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.color
                              ?.withOpacity(0.64),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        )
      ],
    );
  }
}
