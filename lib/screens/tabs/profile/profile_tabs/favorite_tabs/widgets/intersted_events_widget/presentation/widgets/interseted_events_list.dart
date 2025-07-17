/*
import 'package:flutter/material.dart';
import 'package:p/screens/view_all_events/presentation/pages/view_all_recommended_events.dart';
import '../../../../../../../../event_details/presentation/pages/event_details_view_body.dart';
import '../../data/model/interseted_event_model.dart';
import 'interseted_event_card.dart';
import 'no_events.dart';

class InterestedEventsList extends StatelessWidget {
  final List<InterstedEvents> events;

  const InterestedEventsList({
    Key? key,
    required this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return InterestedEventCard(
          event: event,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EventDetailsViewBody(id: event.id),
              ),
            );
          },
        );
      },
    );
  }
}

 */
