import 'dart:math';

import 'package:a/models/chatModel.dart';
import 'package:a/utils/constants.dart';
import 'package:dio/dio.dart';

class ChatRepo {
  static Future<String> chatTextGenerator(
      List<ChatBotModel> previousMessage) async {
    Dio dio = Dio();

    try {
      final response = await dio.post(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent?key=${API_KEY}',
        data: {
          "contents": previousMessage.map((e) => e.toMap()).toList(),
          "generationConfig": {
            "temperature": 0,
            "topK": 40,
            "topP": 0.95,
            "maxOutputTokens": 8192,
            "responseMimeType": "text/plain"
          }
        },
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response
            .data['candidates'].first['content']['parts'].first['text'];
      }
    } catch (e) {
      print(e);
    }
    return '';
  }
}
