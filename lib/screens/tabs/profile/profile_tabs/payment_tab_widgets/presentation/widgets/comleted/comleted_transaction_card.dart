import 'package:flutter/material.dart';
import 'package:p/screens/booking/data/models/GetBookingModel.dart';
import '../all/all_transactions_body.dart';
class CompletedTransactionsScreen extends StatelessWidget {
  final List<GetBookingModel> transactions;

  const CompletedTransactionsScreen({Key? key, required this.transactions})
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
