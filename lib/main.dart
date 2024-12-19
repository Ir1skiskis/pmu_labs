import 'package:flutter/material.dart';
import 'package:pmu_labs/presentation/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Список ведьмачьих знаков'),
    );
  }
}
