import 'dart:async';

import 'package:a/models/chatModel.dart';
import 'package:a/repo/chat_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_bloc_event.dart';
part 'chat_bloc_state.dart';

class ChatBlocBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  ChatBlocBloc() : super(ChatBotMessageSuccessState(messages: [])) {
    on<ChatGenetatorNewMessageEvent>(chatGenetatorNewMessageEvent);
  }
  List<ChatBotModel> messages = [];

  FutureOr<void> chatGenetatorNewMessageEvent(
      ChatGenetatorNewMessageEvent event, Emitter<ChatBlocState> emit) async {
    messages.add(
      ChatBotModel(
        role: 'user',
        parts: [
          ChartPart(text: event.inputMessage),
        ],
      ),
    );
    emit(
      ChatBotMessageSuccessState(messages: messages),
    );
    // await ChatRepo.chatTextGenerator(messages);
  }
}
