import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatBotModel {
  final String role;
  final List<ChartPart> parts;
  ChatBotModel({
    required this.role,
    required this.parts,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role': role,
      'parts': parts.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatBotModel.fromMap(Map<String, dynamic> map) {
    return ChatBotModel(
      role: map['role'] as String,
      parts: List<ChartPart>.from(
        (map['parts'] as List<int>).map<ChartPart>(
          (x) => ChartPart.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatBotModel.fromJson(String source) =>
      ChatBotModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ChartPart {
  final String text;
  ChartPart({
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
    };
  }

  factory ChartPart.fromMap(Map<String, dynamic> map) {
    return ChartPart(
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChartPart.fromJson(String source) =>
      ChartPart.fromMap(json.decode(source) as Map<String, dynamic>);
}
