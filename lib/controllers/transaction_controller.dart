import 'package:get/get.dart';
import 'package:my_kas/models/transaction_model.dart';
import 'package:intl/intl.dart';
import '../utils/db_helper.dart';

class TransactionController extends GetxController {
  var transactions = <Transaction>[].obs;
  var selectedFilter = 'semua'.obs;

  @override
  void onInit() {
    fetchTransactions();
    super.onInit();
  }

  Future<void> fetchTransactions() async {
    final data = await DBHelper.instance.readAllTransactions();
    transactions.value = data.map((map) => Transaction.fromMap(map)).toList();
  }

  Future<void> addTransaction(
      String type, double amount, String description, String date) async {
    final transaction = Transaction(
      type: type,
      amount: amount,
      description: description,
      date: date,
    );
    await DBHelper.instance.createTransaction(transaction.toMap());
    fetchTransactions();
  }

  void updateTransaction(Transaction updatedTransaction) {
    int index = transactions.indexWhere((t) => t.id == updatedTransaction.id);
    if (index != -1) {
      transactions[index] = updatedTransaction;
      // Update database atau lakukan aksi lain yang diperlukan
      update(); // Untuk memperbarui UI jika menggunakan GetX
    }
  }

  void deleteTransaction(int id) {
    transactions.removeWhere((tx) => tx.id == id); // Hapus dari list
    DBHelper.instance.deleteTransaction(id); // Hapus dari database
  }

  List<Transaction> get filteredTransactions {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');

    switch (selectedFilter.value) {
      case 'hari_ini':
        return transactions
            .where((t) => t.date == formatter.format(now))
            .toList();
      case 'kemarin':
        final yesterday = now.subtract(Duration(days: 1));
        return transactions
            .where((t) => t.date == formatter.format(yesterday))
            .toList();
      case 'bulan_lalu':
        final lastMonth = DateTime(now.year, now.month - 1, now.day);
        final startOfMonth = DateTime(lastMonth.year, lastMonth.month, 1);
        final endOfMonth = DateTime(lastMonth.year, lastMonth.month + 1, 0);
        return transactions
            .where((t) =>
                DateTime.parse(t.date).isAfter(startOfMonth) &&
                DateTime.parse(t.date).isBefore(endOfMonth))
            .toList();
      default:
        return transactions;
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }
}
