class Message {
  final String id;
  final String text;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.text,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'text': text,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Message.fromMap(Map<String, dynamic> data) {
    return Message(
      id: data['id'],
      text: data['text'],
      createdAt: DateTime.parse(data['createdAt']),
    );
  }
}
