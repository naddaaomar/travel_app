import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:p/screens/user_interaction/domain/use_cases/save_interaction.dart';
import '../../data/models/event_interaction_model.dart';
@injectable
class InteractionCubit extends Cubit<void> {
  final SaveInteractionUseCase saveInteractionUseCase;

  InteractionCubit(this.saveInteractionUseCase) : super(null);

  Future<void> trackInteraction({
    required String contentId,
    required String type,
    int userCheckOut = 1,
    bool addedToWishList = false,
    bool booked = false,
  }) async {
    final interaction = EventInteractionModel(
      id: contentId,
      type: type,
      userCheckOut: userCheckOut,
      addedToWishList: addedToWishList,
      booked: booked,
    );

    await saveInteractionUseCase(interaction);
  }
}
