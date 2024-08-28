import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';

class AddPage extends StatelessWidget {
  final TransactionController controller = Get.find();

  final TextEditingController typeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Transaksi Kass'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
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
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.addTransaction(
                  typeController.text,
                  double.tryParse(amountController.text) ?? 0.0,
                  descriptionController.text,
                  dateController.text,
                );
                Get.offAllNamed(
                    '/main'); // Kembali ke halaman sebelumnya setelah menambah transaksi
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
