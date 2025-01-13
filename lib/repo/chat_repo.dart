import 'package:a/models/chatModel.dart';
import 'package:a/utils/constants.dart';
import 'package:dio/dio.dart';

class ChatRepo {
  static chatTextGenerator(List<ChatBotModel> previousMessage) async {
    Dio dio = Dio();

    try {
      final response = await dio.post(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent?key=${apiKey}',
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
      print(response.data.contents);
    } catch (e) {
      print(e);
    }
  }
}
