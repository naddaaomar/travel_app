import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:p/screens/tabs/profile/profile_tabs/favorite_tabs/presentiton/manager/combined_favorites_cubit.dart';
import '../../data/model/interseted_event_model.dart';

class InterestedEventCard extends StatelessWidget {
  final InterstedEvents event;
  final VoidCallback onTap;

  const InterestedEventCard({
    Key? key,
    required this.event,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy hh:mm a');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 120,
                  height: 100,
                  child: Image.network(
                    event.image ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.event, size: 30, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'vols',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (event.category != null)
                      Row(
                        children: [
                          const Icon(Icons.category, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            event.category!,
                            style: const TextStyle(color: Colors.grey, fontFamily: 'vols'),
                          ),
                        ],
                      ),
                    const SizedBox(height: 4),
                    if (event.dates != null)
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              event.dates!,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              BlocBuilder<CombinedFavoritesCubit, CombinedFavoritesState>(
                builder: (context, state) {
                  final isInterested = event.isInterested;

                  return TextButton(
                    onPressed: () {
                      context.read<CombinedFavoritesCubit>().toggleEventInterest(event);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isInterested
                                ? 'Removed from interested events'
                                : 'Added to interested events',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Text(
                      'Interested',
                      style: TextStyle(
                        color: isInterested
                            ? Colors.green
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'vols'
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
