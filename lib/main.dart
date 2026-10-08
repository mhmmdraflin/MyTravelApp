import 'package:flutter/material.dart';
import 'main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Travel',
      debugShowCheckedModeBanner: false, // Menghilangkan pita "Debug" di pojok kanan atas
      theme: ThemeData(
        // Latar belakang khas iOS (System Gray 6)
        scaffoldBackgroundColor: const Color(0xFFF2F2F7),

        // Memastikan AppBar menyatu dengan warna background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF2F2F7),
          elevation: 0, // Menghilangkan garis pembatas/bayangan di bawah AppBar
          iconTheme: IconThemeData(color: Colors.black),
        ),

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,

        // Menggunakan font bawaan sistem Apple (San Francisco) jika dijalankan di iOS/Mac
        fontFamily: '-apple-system',
      ),
      home: const MainScreen(),
    );
  }
}