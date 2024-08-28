import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';
import 'edit_transaction_dialog.dart';

class HomePage extends StatelessWidget {
  final TransactionController controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pencatatan KAS'),
      ),
      body: Obx(() {
        if (controller.transactions.isEmpty) {
          return Center(child: Text('Belum ada transaksi.'));
        } else {
          return ListView.builder(
            itemCount: controller.transactions.length,
            itemBuilder: (context, index) {
              final transaction = controller.transactions[index];
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
                onTap: () {
                  // Menampilkan dialog edit transaksi
                  Get.dialog(
                    EditTransactionDialog(transaction: transaction),
                    barrierDismissible: true, // Membolehkan dialog ditutup dengan mengetuk di luar
                  );
                },
                onLongPress: () {
                  _showDeleteDialog(context, transaction.id!);
                },
              );
            },
          );
        }
      }),
    );
  }

  void _showDeleteDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hapus Transaksi'),
          content: Text('Apakah Anda yakin ingin menghapus transaksi ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                controller.deleteTransaction(id);
                Get.back();
                Get.snackbar(
                  'Transaksi Dihapus',
                  'Transaksi berhasil dihapus.',
                  snackPosition: SnackPosition.TOP,
                );
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
