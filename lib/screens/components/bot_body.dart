import 'package:flutter/material.dart';
import 'package:innersight/data_storage/remote_data_storage/chat_data.dart';
import 'package:innersight/models/ChatMessage.dart';

import 'constants.dart';
import 'message.dart';

class BotBody extends StatefulWidget {
  const BotBody({super.key});

  @override
  State<BotBody> createState() => _BotBodyState();
}

class _BotBodyState extends State<BotBody> {
  TextEditingController sendController = TextEditingController();
  List<ChatMessage> chatMessages = [];
  String message = "";

  _getMessages() async {
    if (sendController.text.isNotEmpty) {
      setState(() {
        ChatMessage chatMessage = ChatMessage(
          text: sendController.text,
            messageType: ChatMessageType.text,
            messageStatus: MessageStatus.viewed,
            isSender: true);
        chatMessages.add(chatMessage);
      });
      message = await ChatData().getMessageResponse(sendController.text);
      setState(() {
        ChatMessage chatMessage = ChatMessage(

          text: message,
            messageType: ChatMessageType.text,
            messageStatus: MessageStatus.viewed,
            isSender: false);
        chatMessages.add(chatMessage);
      });
      sendController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a message")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) =>
                  Message(message: chatMessages[index]),
            ),
          )),
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
                              sendController.text = newValue!;
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type Message'),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _getMessages();
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
      ),
    );
  }
}
