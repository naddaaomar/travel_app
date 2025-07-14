import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:p/helpers/themes/colors.dart';
import '../../data/model/trips_tab_model.dart';

class TripDetailsBottomCard extends StatelessWidget {
  final Trip trip;
  final DateFormat dateFormat;
  final ValueChanged<double> onRatingChanged;
  final bool isRated;

  const TripDetailsBottomCard({
    super.key,
    required this.trip,
    required this.dateFormat,
    required this.onRatingChanged,
    required this.isRated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              if (trip.travelProfileUrl != null)
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[100],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      trip.travelProfileUrl!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Icon(Icons.image_not_supported,
                            size: 50,
                            color: Colors.grey[400]),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16,),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0,2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            trip.destination,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'vols',
                            ),
                          ),
                        ),
                        Text(
                          '\$${trip.price!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorApp.primaryColor,
                            fontFamily: 'vols',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        _buildDetailItem(Icons.calendar_today, 'Date',
                            '${dateFormat.format(trip.endDate)}'),
                        _buildDetailItem(Icons.event_available, 'Booked On',
                              dateFormat.format(trip.bookingDate!)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Booking Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'vols',
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow('Booking ID:', trip.bookingId!),
                    _buildDetailRow('Total Price:',
                        '\$${trip.price?.toStringAsFixed(2) ?? ''}'),
                    _buildDetailRow('Quantity:', '${trip.quantity ?? ''}'),
                    _buildDetailRow('Booked by:', trip.buyerEmail ?? ''),
                    _buildDetailRow('Payment Status:',
                      trip.bookingStatus, valueColor: Colors.green,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Rate Your Experience",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'vols',
                      ),
                    ),
                    const SizedBox(height: 12),
                    RatingBar.builder(
                      initialRating: trip.userRating ?? 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 32,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (context, _) =>
                      const Icon(
                          Icons.star,
                          color: Colors.amber),
                      onRatingUpdate: onRatingChanged,
                      glowColor: Colors.amber.withAlpha(30),
                      ignoreGestures: isRated,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isRated
                          ? 'Thank you for your rating !'
                          : trip.userRating == null
                          ? 'Not rated yet !'
                          : 'Your rating: ${trip.userRating!.toStringAsFixed(1)}',
                      style: TextStyle(
                        color: isRated ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'vols',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(
      IconData icon,
      String label,
      String value,
      {bool statusColor = false}) {
    return Row(
      children: [
        Icon(
            icon,
            size: 20,
            color: Colors.grey[600]),
        const SizedBox(
            width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontFamily: 'vols',
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: statusColor
                    ? (value.toLowerCase() == 'success' ? Colors.green : Colors.orange)
                    : Colors.black,
                fontFamily: 'vols',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(
      String label,
      String value,
      {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontFamily: 'vols',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'vols',
                color: valueColor ?? Colors.black,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}