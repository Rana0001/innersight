import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_components.dart';
import '../../utils/app_gaps.dart';
import '../chat_room.dart';

class ChatScreenWidgets {
  /// Get chat message widget based on who sent the message
  static Widget getCustomDeliveryChatWidget({required ChatRoom chatMessage}) {
    if (chatMessage.patientMsg!) {
      return MyMessageSingleWidget(chatMessage: chatMessage);
    } else {
      return RecipientMessageSingleWidget(chatMessage: chatMessage);
    }
  }
}

/// Chat message widget of my message
class MyMessageSingleWidget extends StatelessWidget {
  final ChatRoom chatMessage;
  const MyMessageSingleWidget({Key? key, required this.chatMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(chatMessage.dateTimeText!);
    DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormatter.format(dateTime);
    DateFormat timeFormatter = DateFormat('h:mm a');
    String formattedTime = timeFormatter.format(dateTime);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Spacer(flex: 2),
            Expanded(
              flex: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Builder(builder: (context) {
                    if (chatMessage.messages!.isEmpty) {
                      return AppGaps.emptyGap;
                    }
                    return Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: AppComponents.defaultBorderRadius,
                              topRight: AppComponents.defaultBorderRadius,
                              bottomLeft: AppComponents.defaultBorderRadius,
                              bottomRight: Radius.circular(0)),
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.25),
                                offset: const Offset(0, 8),
                                spreadRadius: -8,
                                blurRadius: 10)
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            chatMessage.messages!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                          AppGaps.hGap5,
                          Text(
                            "$formattedDate $formattedTime",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Chat message widget of recipient message
class RecipientMessageSingleWidget extends StatelessWidget {
  final ChatRoom chatMessage;
  const RecipientMessageSingleWidget({Key? key, required this.chatMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(chatMessage.dateTimeText!);
    DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormatter.format(dateTime);
    DateFormat timeFormatter = DateFormat('h:mm a');
    String formattedTime = timeFormatter.format(dateTime);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(builder: (context) {
                    if (chatMessage.messages!.isEmpty) {
                      return AppGaps.emptyGap;
                    }
                    return Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: AppComponents.defaultBorderRadius,
                              topRight: AppComponents.defaultBorderRadius,
                              bottomLeft: Radius.circular(0),
                              bottomRight: AppComponents.defaultBorderRadius),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                offset: const Offset(0, 8),
                                spreadRadius: -5,
                                blurRadius: 10)
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chatMessage.messages!,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                          AppGaps.hGap5,
                          Text(
                            "$formattedDate $formattedTime",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 10),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            const Spacer(flex: 2)
          ],
        ),
      ],
    );
  }
}
