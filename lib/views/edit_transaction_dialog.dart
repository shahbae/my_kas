import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_kas/controllers/transaction_controller.dart';
import 'package:my_kas/models/transaction_model.dart';

class EditTransactionDialog extends StatelessWidget {
  final TransactionController controller = Get.find();
  final Transaction transaction;

  EditTransactionDialog({required this.transaction});

  final TextEditingController typeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    typeController.text = transaction.type;
    amountController.text = transaction.amount.toString();
    descriptionController.text = transaction.description;
    dateController.text = transaction.date;

    return AlertDialog(
      title: Text('Edit Transaksi'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: transaction.type,
              decoration: InputDecoration(labelText: 'Tipe Transaksi'),
              items: [
                DropdownMenuItem(value: 'income', child: Text('Pemasukan')),
                DropdownMenuItem(value: 'expense', child: Text('Pengeluaran')),
              ],
              onChanged: (value) {
                typeController.text = value!;
              },
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Jumlah'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Tanggal',
                hintText: 'yyyy-mm-dd',
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.parse(transaction.date),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  dateController.text =
                      pickedDate.toIso8601String().split('T')[0];
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            if (typeController.text.isNotEmpty &&
                amountController.text.isNotEmpty &&
                descriptionController.text.isNotEmpty &&
                dateController.text.isNotEmpty) {
              final updatedTransaction = Transaction(
                id: transaction.id,
                type: typeController.text,
                amount: double.tryParse(amountController.text) ?? 0.0,
                description: descriptionController.text,
                date: dateController.text,
              );
              controller.updateTransaction(updatedTransaction);
              Get.back();
            } else {
              Get.snackbar(
                'Error',
                'Harap isi semua bidang!',
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          },
          child: Text('Simpan'),
        ),
      ],
    );
  }
}
