/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/screens/view_all_events/presentation/pages/view_all_recommended_events.dart';
import '../../../../presentiton/manager/combined_favorites_cubit.dart';
import '../widgets/interseted_events_list.dart';
import '../widgets/no_events.dart';
class InterestedEventsPage extends StatefulWidget {
  const InterestedEventsPage({super.key});

  @override
  State<InterestedEventsPage> createState() => _InterestedEventsPageState();
}

class _InterestedEventsPageState extends State<InterestedEventsPage> {
  bool _hasFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasFetched) {
      context.read<CombinedFavoritesCubit>().fetchAll();
      _hasFetched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CombinedFavoritesCubit, CombinedFavoritesState>(
        listener: (context, state) {
          if (state is CombinedFavoritesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is CombinedFavoritesInitial) {
            return const Center(child: CircularProgressIndicator());
          }


          final events = state.events;

          if (events.isEmpty) {
            return NoInterstedEvents(
              onAddInterest: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ViewAllEvents(eventModel: []),
                  ),
                );
              },
            );
          }

          return InterestedEventsList(
            events: events,
          );
        },
      ),
    );
  }
}

 */