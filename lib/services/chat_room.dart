import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:innersight/app/constant.dart';

import '../models/chat_room.dart';

class ChatRoomService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future sendMessage(ChatRoom chatRoom) async {
    await firebaseFirestore.collection('chatroom').add(chatRoom.toJson());
  }

  getMessage(String doctorId) {
    return firebaseFirestore
        .collection('chatroom')
        .where('patientId', isEqualTo: Constant.patient.id)
        .where('doctorId', isEqualTo: doctorId)
        .orderBy('dateTimeText', descending: false)
        .snapshots();
  }
}
