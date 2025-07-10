import 'package:flutter/material.dart';
import 'package:p/screens/booking/data/models/GetBookingModel.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/payment_tab_widgets/all/all_transactions_body.dart';
import '../model.dart';

class TransactionListScreen extends StatelessWidget {
  final List<GetBookingModel> transactions;

  const TransactionListScreen({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TransactionCard(transaction: transaction),
        );
      },
    );
  }
}
