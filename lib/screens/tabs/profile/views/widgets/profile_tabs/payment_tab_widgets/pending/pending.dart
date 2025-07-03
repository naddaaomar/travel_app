import 'package:flutter/material.dart';
import '../all/all_transactions_body.dart';
import '../model.dart';

class PendingTransactionsScreen extends StatelessWidget {
  final List<Transaction> transactions;

  const PendingTransactionsScreen({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pendingTransactions = transactions.where((t) => t.status == 'Pending').toList();

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pendingTransactions.length,
        itemBuilder: (context, index) {
          final transaction = pendingTransactions[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TransactionCard(transaction: transaction),
          );
        },
      ),
    );
  }
}