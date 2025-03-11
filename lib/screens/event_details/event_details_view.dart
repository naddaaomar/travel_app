import 'package:flutter/material.dart';
import 'package:p/screens/event_details/views/widgets/event_details_view_body.dart';

class EventDetailsView extends StatelessWidget {
  const EventDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: EventDetailsViewBody(image: '',),
      ),
    );
  }
}