import 'package:flutter/material.dart';
import 'package:p/screens/tabs/profile/views/widgets/profile_tabs/payment_tab_widgets/presentation/widgets/all/all_transactions_body.dart';
import '../../../data/model.dart';

class TransactionListScreen extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: '123',
      amount: 150,
      recipient: 'owner1',
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: 'Success',
    ),
    Transaction(
      id: '124',
      amount: 200,
      recipient: 'owner2',
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: 'Success',
    ),
    Transaction(
      id: '125',
      amount: 300,
      recipient: 'owner3',
      date: DateTime.now().subtract(const Duration(days: 3)),
      status: 'Success',
    ),
    Transaction(
      id: '126',
      amount: 400,
      recipient: 'owner4',
      date: DateTime.now().subtract(const Duration(days: 4)),
      status: 'Pending',
    ),
    Transaction(
      id: '127',
      amount: 500,
      recipient: 'owner5',
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: 'Pending',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TransactionCard(transaction: transaction),
          );
        },
      ),
    );
  }
}