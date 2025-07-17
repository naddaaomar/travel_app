import 'dart:async';
import 'dart:convert';
import 'package:p/screens/ai_chatbot/domain/repositories/chat_repo.dart';
import 'package:signalr_netcore/signalr_client.dart';
import '../../domain/entities/chat_message.dart';

class ChatRepositoryImpl implements ChatRepo {
  late final HubConnection _connection;
  final _controller = StreamController<ChatMessage>.broadcast();

  ChatRepositoryImpl() {
    _connection = HubConnectionBuilder()
        .withUrl('https://journeymate.runasp.net/chatHub',
        options: HttpConnectionOptions(
          transport: HttpTransportType.WebSockets,
          skipNegotiation: true,
          logMessageContent: true,
        ))
        .build();

    _connection.on('ReceiveMessage', (args) {
      final data = args?[0];
      try {
        Map<String, dynamic> jsonData;

        if (data is String) {
          jsonData = jsonDecode(data);
        } else if (data is Map) {
          jsonData = Map<String, dynamic>.from(data as Map);
        } else {
          throw Exception("Invalid data format");
        }

        final message = ChatMessage(
          sender: "Bot",
          message: jsonData['response'] ?? '',
          timestamp: DateTime.now(),
          events: (jsonData['events'] as List?)?.cast<Map<String, dynamic>>(),
          travels: (jsonData['travels'] as List?)?.cast<Map<String, dynamic>>(),
        );

        _controller.add(message);
      } catch (e) {
        _controller.add(ChatMessage(
          sender: "Bot",
          message: data.toString(),
          timestamp: DateTime.now(),
        ));
      }
    });

    _connection.onclose(({error}) {
      print('🔌 Connection closed: $error');
    });
  }

  @override
  Future<void> connect() async {
    await _connection.start();
  }

  @override
  Future<void> disconnect() async {
    await _connection.stop();
  }

  @override
  Stream<ChatMessage> getMessagesStream() => _controller.stream;

  @override
  Future<void> sendMessage(String message) async {
    await _connection.invoke('SendMessage', args: [message]);
  }
}
