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
  bool isGenrating = false;

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
    isGenrating = true;
    String responce = await ChatRepo.chatTextGenerator(messages);
    if (responce.length > 0) {
      messages.add(
        ChatBotModel(
          role: 'model',
          parts: [
            ChartPart(text: responce),
          ],
        ),
      );
      emit(
        ChatBotMessageSuccessState(messages: messages),
      );
    isGenrating = false;

    }
  }
}
