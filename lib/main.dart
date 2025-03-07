import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hilangkan banner debug
      title: 'Flutter Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Rute awal
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(), // Tambahkan halaman register
      },
    );
  }
}