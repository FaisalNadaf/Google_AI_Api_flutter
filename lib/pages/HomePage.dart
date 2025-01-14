// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:a/bloc/chat_bloc_bloc.dart';
import 'package:a/models/chatModel.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController textEditingController;
  late ScrollController scrollController;
  late ChatBlocBloc chatBlocBloc;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    scrollController = ScrollController();
    chatBlocBloc = ChatBlocBloc();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();
    chatBlocBloc.close();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBlocBloc, ChatBlocState>(
        bloc: chatBlocBloc,
        listener: (context, state) {
          if (state is ChatBotMessageSuccessState) {
            _scrollToBottom();
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatBotMessageSuccessState:
              List<ChatBotModel> messages =
                  (state as ChatBotMessageSuccessState).messages;

              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Bot',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // Icon(
                          //   Icons.image_search,
                          //   size: 30,
                          // )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: messages[index].role == 'user'
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              margin: const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 20,
                              ),
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7,
                              ),
                              decoration: BoxDecoration(
                                color: messages[index].role == 'user'
                                    ? Colors.blueAccent
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(20),
                                  topRight: const Radius.circular(20),
                                  bottomLeft: messages[index].role == 'user'
                                      ? const Radius.circular(20)
                                      : const Radius.circular(0),
                                  bottomRight: messages[index].role == 'user'
                                      ? const Radius.circular(0)
                                      : const Radius.circular(20),
                                ),
                              ),
                              child: Text(
                                messages[index].parts.first.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: messages[index].role == 'user'
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              style: const TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Type a message',
                                hintStyle: TextStyle(
                                  fontSize: 26,
                                  color: Colors.grey.shade400,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade800,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: InkWell(
                              onTap: () {
                                if (textEditingController.text.isNotEmpty) {
                                  chatBlocBloc.add(
                                    ChatGenetatorNewMessageEvent(
                                      inputMessage: textEditingController.text,
                                    ),
                                  );
                                  textEditingController.clear();
                                }
                              },
                              child: chatBlocBloc.isGenrating
                                  ? Container(
                                      height: 50,
                                      width: 50,
                                      child:
                                          Lottie.asset('assets/loading.json'),
                                    )
                                  : Icon(
                                      Icons.send,
                                      size: 50,
                                      color: Colors.deepPurple.shade300,
                                    ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
