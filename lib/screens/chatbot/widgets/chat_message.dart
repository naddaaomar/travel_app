class ChatMessage {
  final String sender;
  final String message;
  final DateTime timestamp;
  final dynamic events;
  final dynamic travels;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.timestamp,
    this.events,
    this.travels,
  });
}