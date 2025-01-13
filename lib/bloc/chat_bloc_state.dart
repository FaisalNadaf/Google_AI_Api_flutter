part of 'chat_bloc_bloc.dart';

@immutable
sealed class ChatBlocState {}

final class ChatBlocInitial extends ChatBlocState {}

class ChatBotMessageSuccessState extends ChatBlocState {
  final List<ChatBotModel> messages;
  ChatBotMessageSuccessState({
    required this.messages,
  });
}
