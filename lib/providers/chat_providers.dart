import 'package:riverpod_chat/models/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_chat/repositories/chat_repository.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository());

final messagesProvider = StreamProvider<List<Message>>((ref){
  final repo = ref.watch(chatRepositoryProvider);
  return repo.getMessagesStream();
});

final sendMessageProvider = Provider((ref){
  final repo = ref.watch(chatRepositoryProvider);
  return repo.sendMessage;
});