import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_chat/models/message.dart';

class ChatRepository {
  final _firestore = FirebaseFirestore.instance;
  final _messages = FirebaseFirestore.instance.collection('messages');

  Stream<List<Message>> getMessagesStream() {
    return _messages
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Message.fromMap(doc.data());
      }).toList();
    });
  }

  Future<void> sendMessage(String text) async {
    final message = Message(createdAt: DateTime.now(), id: _messages.doc().id, text: text);
    await _messages.doc(message.id).set(message.toMap());
  }
}