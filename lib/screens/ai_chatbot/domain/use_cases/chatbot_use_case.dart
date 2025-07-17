import 'package:p/screens/ai_chatbot/domain/repositories/chat_repo.dart';

class ChatbotUseCase {
  final ChatRepo repo;

  ChatbotUseCase(this.repo);

  Future<void> call(String message) => repo.sendMessage(message);
}
