class Transaction {
  final int? id;
  final String type;
  final double amount;
  final String description;
  final String date;

  Transaction({
    this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
  });

  // Metode untuk mengonversi objek Transaction menjadi Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'description': description,
      'date': date,
    };
  }

  // Factory untuk membuat objek Transaction dari Map<String, dynamic>
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      type: map['type'],
      amount: map['amount'],
      description: map['description'],
      date: map['date'],
    );
  }
}
