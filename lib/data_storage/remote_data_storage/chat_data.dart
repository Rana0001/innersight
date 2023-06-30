import 'package:dio/dio.dart';
import 'package:innersight/app/constant.dart';
import 'package:innersight/helper/http_services.dart';

class ChatData {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<String> getMessageResponse(String message) async {
    try {
      final response = await _httpServices.post(
        Constant.chatUrl + Constant.message,
        data: {
          "message": message,
        },
      );
      if (response.statusCode != 200) {
        return "Something might wrong here.";
      }
      return response.data['response'];
    } catch (err) {
      return err.toString();
    }
  }

  Future<String> getVoiceResponse(String message) async {
    try {
      final response = await _httpServices.post(
        Constant.chatUrl + Constant.voiceMessage,
        data: {
          "message": message,
        },
      );
      if (response.statusCode != 200) {
        return "Something might wrong here.";
      }
      return response.data['message'];
    } catch (err) {
      return err.toString();
    }
  }
}
