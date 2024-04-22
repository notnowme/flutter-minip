import 'package:flutter/material.dart';
import 'package:minip/common/layouts/default_layout.dart';
import 'package:minip/free/write/views/free_write_screen.dart';
import 'package:minip/user/views/join_screen.dart';
import 'package:minip/user/views/login_screen.dart';
import 'package:minip/user/views/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
      ),
      debugShowCheckedModeBanner: false,
      home: const FreeWriteScreen(),
    );
  }
}
