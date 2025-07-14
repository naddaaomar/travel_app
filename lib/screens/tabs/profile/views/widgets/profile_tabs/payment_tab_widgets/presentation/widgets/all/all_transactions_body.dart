import 'package:flutter/material.dart';
import 'package:p/screens/booking/data/models/GetBookingModel.dart';
import 'package:p/screens/booking/presentation/manager/booking_cubit.dart';
import 'package:p/screens/edit_booking/presention/pages/edit_booking.dart';
import 'package:p/screens/trip_details/manager/travel_details_cubit.dart';

class TransactionCard extends StatelessWidget {
  final GetBookingModel transaction;

  const TransactionCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  bool get isCompleted =>
      transaction.status?.trim().toLowerCase() == 'payment successed' ||
      transaction.status?.trim().toLowerCase() == 'success';

  @override
  Widget build(BuildContext context) {
    DateTime? date;
    try {
      date = DateTime.parse(transaction.bookingDate ?? '');
    } catch (_) {}

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isCompleted ? Colors.green : Colors.orange,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Travel Image
          Align(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                transaction.bookingItem?.travelProfileUrl ?? "",
                height: 100,
                width: 130,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title & Email
                Text(
                  transaction.bookingItem?.title ?? "",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'vol',
                  ),
                ),
                Text(
                  transaction.buyerEmail ?? "",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontFamily: 'pop',
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 4),

                /// Booking Date & Cost
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date != null
                          ? "${date.day}/${date.month}/${date.year}"
                          : "Date: Unknown",
                      style: const TextStyle(fontSize: 11, fontFamily: 'pop'),
                    ),
                    Text(
                      "${transaction.totalCost?.toStringAsFixed(0)} EGP",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'pop',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// Status or Actions
                if (isCompleted)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),

                      decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Succeed',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          fontFamily: 'vols',
                        ),
                      ),
                    ),
                  )
                else
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          var travelDetails =
                              await TravelDetailsCubit.get(context)
                                  .getTravelDetails(
                                      id: transaction.bookingItem?.travelId
                                              ?.toString() ??
                                          "");
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (context) => EditBookingScreen(
                                  model: transaction,
                                  travelDetailsModel: travelDetails
                              ),
                              fullscreenDialog: true,
                            ),
                          );
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => EditBookingScreen(
                          //           model: transaction,
                          //           travelDetailsModel: travelDetails),
                          //     ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          minimumSize: const Size(30, 32),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.edit,
                            size: 14, color: Colors.white),
                        label: const Text("Edit",
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await BookingCubit.get(context).bookingDelete(
                            bookingId: transaction.id?.toInt() ?? 0,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff8A2626).withOpacity(.8),
                          minimumSize: const Size(30, 32),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.delete,
                            size: 14, color: Colors.white),
                        label: const Text("Delete",
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
