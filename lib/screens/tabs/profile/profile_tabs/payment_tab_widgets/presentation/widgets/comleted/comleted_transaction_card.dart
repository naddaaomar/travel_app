import 'package:flutter/material.dart';
import '../../../data/model.dart';
import '../all/all_transactions_body.dart';

class CompletedTransactionsScreen extends StatelessWidget {
  final List<Transaction> transactions;

  const CompletedTransactionsScreen({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedTransactions = transactions.where((t) => t.status == 'Success').toList();

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = completedTransactions[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TransactionCard(transaction: transaction),
          );
        },
      ),
    );
  }
}