import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';

class AddTransactionDialog extends StatelessWidget {
  final TransactionController controller = Get.find();

  final TextEditingController typeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tambah Transaksi'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: 'income',
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
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
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
              controller.addTransaction(
                typeController.text,
                double.tryParse(amountController.text) ?? 0.0,
                descriptionController.text,
                dateController.text,
              );
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
