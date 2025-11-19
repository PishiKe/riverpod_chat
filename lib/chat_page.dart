import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_chat/providers/chat_providers.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(messagesStreamProvider);
    final sendMessage = ref.watch(sendMessageProvider);

    final controller = TextEditingController();

    return Scaffold(
        appBar: AppBar(title: const Text('Riverpod Chat')),
        body: Column(
          children: [
            Expanded(
                child: messagesAsync.when(
              data: (messages) => ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (_, i) => ListTile(
                        title: Text(messages[i].text),
                        subtitle:
                            Text(messages[i].createdAt.toLocal().toString()),
                      )),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
            )),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                            hintText: 'Type a message...'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        if (controller.text.trim().isNotEmpty) {
                          sendMessage(controller.text.trim());
                          controller.clear();
                        }
                      },
                    ),
                  ],
                ))
          ],
        ));
  }
}
