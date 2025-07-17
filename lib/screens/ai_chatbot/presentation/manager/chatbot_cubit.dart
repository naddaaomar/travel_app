import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/ai_chatbot/domain/entities/chat_message.dart';
import 'package:p/screens/ai_chatbot/domain/repositories/chat_repo.dart';

class ChatCubit extends Cubit<List<ChatMessage>> {
  final ChatRepo _repo;

  late final Stream<ChatMessage> _stream;

  ChatCubit(this._repo) : super([]) {
    _stream = _repo.getMessagesStream();
    _stream.listen((msg) {
      final updated = [...state, msg];
      emit(updated);
    });
  }

  Future<void> connect() async {
    await _repo.connect();
  }

  Future<void> disconnect() async {
    await _repo.disconnect();
  }

  Future<void> sendMessage(String message) async {
    final myMsg = ChatMessage(
      sender: 'Me',
      message: message,
      timestamp: DateTime.now(),
    );
    emit([...state, myMsg]);
    await _repo.sendMessage(message);
  }
}
