import '../entities/chat_message.dart';

abstract class ChatRepo {
  Future<void> connect();
  Future<void> disconnect();
  Future<void> sendMessage(String message);
  Stream<ChatMessage> getMessagesStream();
}
