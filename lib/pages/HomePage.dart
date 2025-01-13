import 'package:a/bloc/chat_bloc_bloc.dart';
import 'package:a/models/chatModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    ChatBlocBloc chatBlocBloc = ChatBlocBloc();
    return Scaffold(
      body: BlocConsumer<ChatBlocBloc, ChatBlocState>(
        bloc: chatBlocBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatBotMessageSuccessState:
              List<ChatBotModel> messages =
                  (state as ChatBotMessageSuccessState).messages;

              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                          Icon(
                            Icons.image_search,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              margin: EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 20,
                              ),
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                color: messages[index].role == 'user'
                                    ? Colors.grey.shade800
                                    : Colors.deepPurple.shade300,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                              child: Text(messages[index].parts.first.text));
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              style: TextStyle(
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
                                contentPadding: EdgeInsets.symmetric(
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
                              child: Icon(
                                Icons.send,
                                size: 40,
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
              return SizedBox();
          }
        },
      ),
    );
  }
}
