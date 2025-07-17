import 'package:injectable/injectable.dart';
import 'package:p/helpers/api_manager/api_manager.dart';
import 'package:p/screens/user_interaction/data/models/event_interaction_model.dart';

@LazySingleton()
class InteractionRemoteDataSource {
  final ApiManager apiManager;

  InteractionRemoteDataSource(this.apiManager);

  Future<void> sendInteractions(String userId, List<EventInteractionModel> interactions) async {
    final data = {
      "id": userId,
      "userInteraction": interactions.map((e) => {
        "id": e.id,
        "type": e.type,
        "total": e.total,
      }).toList(),
    };

    final response = await apiManager.postDate(
      endPoint: "/api/Ai/userinteractions",
      data: data,
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to send interactions");
    }
  }
}
