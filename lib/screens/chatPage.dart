// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project/components/CustomChatBubble.dart';
import 'package:project/components/CustomChatBubbleForFreind.dart';
import 'package:project/contants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/models/message.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages = FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('CreatedAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No messages yet.'));
        }

        List<Message> messageList = snapshot.data!.docs
            .map((doc) => Message.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(logoForApp),
                  height: 65,
                ),
                Text(
                  "Scholar Chat",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    final message = messageList[index];
                    if (message.id == email) {
                      return Customchatbubble(message: message);
                    } else {
                      return Customchatbubbleforfreind(message: message);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Send Message',
                    hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: kPrimaryColor),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: kPrimaryColor,
                        size: 35,
                      ),
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          messages.add({
                            'text': controller.text,
                            'CreatedAt': DateTime.now(),
                            'id': email,
                          });
                          controller.clear();
                          _scrollController.animateTo(
                            0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
