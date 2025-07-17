import 'package:injectable/injectable.dart';
import 'package:p/screens/user_interaction/data/data_sources/local/hive_interaction_local_ds.dart';
import 'package:p/screens/user_interaction/data/data_sources/remote/interaction_remote_ds.dart';

import '../../domain/repositories/interaction_repository.dart';
import '../models/event_interaction_model.dart';
@Injectable(as: InteractionRepository)
class InteractionRepositoryImpl implements InteractionRepository {
  final HiveInteractionLocalDataSource localDataSource;
  final InteractionRemoteDataSource remoteDataSource;

  InteractionRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<void> sendAllInteractions(String userId) async {
    final interactions = await localDataSource.getAllInteractions();
    await remoteDataSource.sendInteractions(userId, interactions);
    await localDataSource.clearAll();
  }

  @override
  Future<void> saveInteraction(EventInteractionModel interaction) {
    return localDataSource.saveInteraction(interaction);
  }
}
