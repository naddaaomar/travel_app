import 'dart:convert';
import 'package:p/screens/chatbot/widgets/chat_message.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  late final HubConnection _connection;

  SignalRService() {
    final httpOptions = HttpConnectionOptions(
      transport: HttpTransportType.WebSockets,
      skipNegotiation: true,
      logMessageContent: true,
    );

    _connection = HubConnectionBuilder()
        .withUrl('https://journeymate.runasp.net/chatHub', options: httpOptions)
        .build();

    _connection.on('ReceiveMessage', (args) {
      final data = args?[0];

      try {
        late final Map<String, dynamic> jsonData;

        if (data is String) {
          jsonData = jsonDecode(data);
        } else if (data is Map) {
          jsonData = Map<String, dynamic>.from(data as Map);
        } else {
          throw Exception("Unknown data format: ${data.runtimeType}");
        }

        final response = jsonData['response'] ?? '';
        final events = jsonData['events'] != null ? List.from(jsonData['events']) : null;
        final travels = jsonData['travels'] != null ? List.from(jsonData['travels']) : null;

        onMessageReceived?.call(ChatMessage(
          sender: "Bot",
          message: response,
          timestamp: DateTime.now(),
          events: events,
          travels: travels,
        ));
      } catch (e) {
        print("❌ JSON Parse Error: $e");
        onMessageReceived?.call(ChatMessage(
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

  Function(ChatMessage message)? onMessageReceived;


  Future<void> startConnection() async {
    try {
      await _connection.start();
      print('✅ SignalR Connected');
    } catch (e) {
      print('❌ Connection failed: $e');
    }
  }

  Future<void> sendMessage(String message) async {
    try {
      await _connection.invoke('SendMessage', args: [message]);
      print('📤 Message sent: $message');
    } catch (e) {
      print('❌ Send failed: $e');
    }
  }

  Future<void> stopConnection() async {
    await _connection.stop();
    print('🛑 SignalR Disconnected');
  }
}