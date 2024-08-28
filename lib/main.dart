import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_kas/controllers/transaction_controller.dart';
import 'package:my_kas/views/add_page.dart';
import 'package:my_kas/views/home_page.dart';
import 'views/main_page.dart';

void main() {
  // Inisialisasi controller di awal aplikasi
  Get.lazyPut<TransactionController>(() => TransactionController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/main',
      getPages: [
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/add', page: () => AddPage()),
        GetPage(name: '/main', page: () => MainPage()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Pencatatan KAS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey:
          Get.key, // Ini untuk memastikan navigasi bekerja tanpa context
    );
  }
}
