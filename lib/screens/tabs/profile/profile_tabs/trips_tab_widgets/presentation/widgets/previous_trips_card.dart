import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import '../../data/model/trips_tab_model.dart';
import 'trip_details_bottom_card.dart';

class TripCard extends StatefulWidget {
  final Trip trip;
  final DateFormat dateFormat;
  final Function(Trip, double) onRateTrip;

  const TripCard({
    super.key,
    required this.trip,
    required this.dateFormat,
    required this.onRateTrip,
  });

  @override
  State<TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  late double? _currentRating;
  bool _isSubmitting = false;
  bool _showSuccess = false;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.trip.userRating;
  }

  @override
  Widget build(BuildContext context) {
    final isRated = _currentRating != null && _currentRating! > 0;
    final isSuccessBooking = widget.trip.bookingStatus.toLowerCase() == 'success';

    return GestureDetector(
      onTap: isSuccessBooking ? _showTripDetails : null,
      behavior: HitTestBehavior.opaque,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(isSuccessBooking),
              const SizedBox(height: 12),
              if (isSuccessBooking) _buildRatingSection(isRated),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(bool isSuccessBooking) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.trip.destination,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'vols',
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              _buildDateSection(),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isSuccessBooking
                ? Colors.green.withOpacity(0.1)
                : Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSuccessBooking ? Colors.green : Colors.orange,
              width: 1,
            ),
          ),
          child: Text(
            widget.trip.bookingStatus.toUpperCase(),
            style: TextStyle(
              color: isSuccessBooking ? Colors.green : Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 0.5,
              fontFamily: 'vols',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSection() {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Column(
          children: [
            Text(
              'Completed:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'vols',
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.dateFormat.format(widget.trip.endDate),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontFamily: 'vols',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingSection(bool isRated) {
    return Column(
      children: [
        const Divider(height: 0.25),
        const SizedBox(height: 12),
        Text(
          isRated ? 'YOUR RATING' : 'RATE YOUR EXPERIENCE',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Colors.black,
            letterSpacing: 0.5,
            fontFamily: 'vols',
          ),
        ),
        const SizedBox(height: 12),
        RatingBar.builder(
          initialRating: _currentRating ?? 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 28,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            if (!isRated && !_isSubmitting) {
              _handleRatingUpdate(rating);
            }
          },
          ignoreGestures: isRated || _isSubmitting,
        ),
        const SizedBox(height: 12),
        _buildRatingStatusText(isRated),
      ],
    );
  }

  Widget _buildRatingStatusText(bool isRated) {
    if (_isSubmitting) {
      return const SizedBox(
        height: 24,
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    } else if (_showSuccess) {
      return Text(
        'Thank you for your rating!',
        style: TextStyle(
          color: Colors.green[700],
          fontSize: 14,
          fontFamily: 'vols',
        ),
      );
    } else if (isRated) {
      return Text(
        'You rated ${_currentRating!.toStringAsFixed(1)} stars',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
          fontFamily: 'vols',
        ),
      );
    } else {
      return Text(
        'Not rated yet',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
          fontFamily: 'vols',
        ),
      );
    }
  }
  void _showTripDetails() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return TripDetailsBottomCard(
          trip: widget.trip,
          dateFormat: widget.dateFormat,
          onRatingChanged: (rating) {
            if (!(_currentRating != null && _currentRating! > 0)) {
              _handleRatingUpdate(rating);
            }
          },
          isRated: _currentRating != null && _currentRating! > 0,
        );
      },
    );
  }

  Future<void> _handleRatingUpdate(double rating) async {
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    try {
      await widget.onRateTrip(widget.trip, rating);

      if (mounted) {
        setState(() {
          _currentRating = rating;
          _isSubmitting = false;
          _showSuccess = true;
        });

        await Future.delayed(const Duration(seconds: 2));
        if (mounted) setState(() => _showSuccess = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit rating: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}