class User {
  final int id;
  final String name;
  double balance;
  List<Transaction> transactions;

  User({
    required this.id,
    required this.name,
    this.balance = 0,
    this.transactions = const [],
  });

  User addTransaction({
    int? id,
    String? name,
    double? balance,
    List<Transaction>? transactions,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
    );
  }
}

class Transaction {
  final DateTime dateTime;
  final String category;
  final double amount;
  bool isExpense;

  Transaction({
    required this.dateTime,
    required this.category,
    required this.amount,
    this.isExpense = false,
  });
}
