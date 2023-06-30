
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:innersight/models/fake_models/chat_message_model.dart';


/* <-------- Fake data list --------> */
class FakeData {

  /// Sample delivery man chat data
  static List<FakeChatMessageModel> deliveryManChats = [
    FakeChatMessageModel(
      isMyMessage: false,
      message: 'Hey there?\nHow much time?',
      dateTimeText: '11:59 am',
    ),
    FakeChatMessageModel(
      isMyMessage: true,
      message: 'On my way sir.\nWill reach in 10 mins.',
      dateTimeText: '11:59 am',
    ),
    FakeChatMessageModel(
      isMyMessage: false,
      message: 'Ok come with carefully!\nRemember the address please!',
      dateTimeText: '11:59 am',
    ),
    FakeChatMessageModel(
      isMyMessage: true,
      message:
          'Btw, I want to know more about the room space and facilities & can I get some more picture of current.',
      dateTimeText: 'Sep 04 2020',
    ),
  ];

}
