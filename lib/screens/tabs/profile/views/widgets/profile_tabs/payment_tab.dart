import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p/helpers/themes/colors.dart';
import 'package:p/screens/booking/data/models/BookingModel.dart';
import 'package:p/screens/booking/data/models/GetBookingModel.dart';
import 'package:p/screens/booking/presentation/manager/booking_cubit.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/payment_tab_widgets/all/all_transactions_list.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/payment_tab_widgets/comleted/comleted_transaction_card.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/payment_tab_widgets/pending/pending.dart';
import 'package:p/screens/trip_details/manager/travel_details_cubit.dart';
import '../../../../../../di.dart';
import 'payment_tab_widgets/model.dart';

class PaymentTab extends StatefulWidget {
  const PaymentTab({Key? key}) : super(key: key);

  @override
  _PaymentTabState createState() => _PaymentTabState();
}

class _PaymentTabState extends State<PaymentTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  // List<GetBookingModel> convertToTransactions(List<GetBookingModel> bookings) {
  //   return bookings
  //       .map(
  //         (booking) => Transaction(
  //           id: booking.id.toString(),
  //           amount: booking.totalCost?.toDouble() ?? 0.0,
  //           recipient: booking.buyerEmail ?? "N/A",
  //           date: DateTime.parse(
  //               booking.bookingDate ?? DateTime.now().toString()),
  //           status: booking.status ?? "Unknown",
  //         ),
  //       )
  //       .toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
  providers: [
    BlocProvider(
        create: (context) => getIt<BookingCubit>()..getBooking(),
),
    BlocProvider(
      create: (context) => TravelDetailsCubit(),
    ),
  ],
  child: BlocConsumer<BookingCubit, BookingState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if ((state.isLoading==false) && (state.getBookingModel!=null)&&(state.error==null) ) {
              final all = state.getBookingModel!;
              final completed = all
                  .where((t) =>
                      t.status?.trim().toLowerCase() == 'payment successed')
                  .toList();
              final pending = all
                  .where((t) => t.status?.trim().toLowerCase() == 'pending')
                  .toList();

              return Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    TabBar(
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      isScrollable: false,
                      unselectedLabelColor: const Color(0xFFB43E26),
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(
                          fontFamily: "vol", fontWeight: FontWeight.w700),
                      indicator: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.white,
                            ColorApp.secondaryColor,
                            Colors.white,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(80),
                      ),
                      tabs: const [
                        Tab(text: 'All\nTransactions'),
                        Tab(text: 'Completed\nTransactions'),
                        Tab(text: 'Pending\nTransactions'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          TransactionListScreen(transactions: all),
                          CompletedTransactionsScreen(transactions: completed),
                          PendingTransactionsScreen(transactions: pending),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.error!=null) {
              return Center(child: Text(state.error??""));
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          },
        ),
),
    );
  }
}
