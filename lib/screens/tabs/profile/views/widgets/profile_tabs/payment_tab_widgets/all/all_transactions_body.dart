import 'package:flutter/material.dart';
import '../model.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({
    Key? key,
    required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          _showTransactionDetails(context, transaction);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    transaction.recipient,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                        fontFamily: 'vols',
                    ),
                  ),
                  Icon(
                    transaction.status == 'Success'
                        ? Icons.check_circle
                        : Icons.pending,
                    color: transaction.status == 'Success'
                        ? Colors.green
                        : Colors.orange,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                    style: const TextStyle(
                      color: Colors.grey,
                        fontFamily: 'vols',
                    ),
                  ),
                  Text(
                    '${transaction.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'vols',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTransactionDetails(BuildContext context, Transaction transaction) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                Center(
                  child: Icon(
                    transaction.status == 'Success'
                        ? Icons.check_circle
                        : Icons.pending,
                    size: 50,
                    color: transaction.status == 'Success'
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    transaction.status == 'Success'
                        ? 'Transaction Successful'
                        : 'Transaction Pending',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                        fontFamily: 'vols',
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                _buildDetailRow('Transaction ID:', transaction.id),
                _buildDetailRow('Amount:',
                    '${transaction.amount.toStringAsFixed(2)}'),
                _buildDetailRow('Recipient:', transaction.recipient),
                _buildDetailRow('Date:',
                    '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}'),
                _buildDetailRow('Time:',
                    '${transaction.date.hour}:${transaction.date.minute.toString().padLeft(2, '0')}'),
                _buildDetailRow('Status:', transaction.status,
                    valueColor: transaction.status == 'Success'
                        ? Colors.green
                        : Colors.orange),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
                color: valueColor ?? Colors.black,
                  fontFamily: 'vols',
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
