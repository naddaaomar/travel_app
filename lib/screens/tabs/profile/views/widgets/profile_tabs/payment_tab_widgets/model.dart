class Transaction {
  String id;
  double amount;
  String recipient;
  DateTime date;
  String status;

  Transaction({
    required this.id,
    required this.amount,
    required this.recipient,
    required this.date,
    required this.status,
  });

  Transaction copyWith({
    String? id,
    double? amount,
    String? recipient,
    DateTime? date,
    String? status,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      recipient: recipient ?? this.recipient,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}