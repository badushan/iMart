import 'package:e_commerce/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/cart_controller.dart';

void main() {
  Get.put(CartController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      home: Splash(),
    );
  }
}
