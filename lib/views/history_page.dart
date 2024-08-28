import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';

class HistoryPage extends StatelessWidget {
  final TransactionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Transaksi'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return DropdownButton<String>(
                value: controller.selectedFilter.value,
                items: [
                  DropdownMenuItem(value: 'semua', child: Text('Semua')),
                  DropdownMenuItem(value: 'hari_ini', child: Text('Hari Ini')),
                  DropdownMenuItem(value: 'kemarin', child: Text('Kemarin')),
                  DropdownMenuItem(
                      value: 'bulan_lalu', child: Text('Bulan Lalu')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    controller.setFilter(value);
                  }
                },
              );
            }),
          ),
        ],
      ),
      body: Obx(() {
        final transactions = controller.filteredTransactions;

        if (transactions.isEmpty) {
          return Center(child: Text('Belum ada riwayat transaksi.'));
        } else {
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return ListTile(
                title: Text(
                  '${transaction.type == 'income' ? 'Pemasukan' : 'Pengeluaran'}: Rp ${transaction.amount}',
                  style: TextStyle(
                    color: transaction.type == 'income'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                subtitle: Text(transaction.description),
                trailing: Text(transaction.date),
              );
            },
          );
        }
      }),
    );
  }
}
