import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'models/app_data.dart';
import 'pages/my_home_page.dart';
import 'pages/detail_page.dart';
import 'pages/about_page.dart';
import 'pages/audit_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Logger().d("Logger is working!");
    return ChangeNotifierProvider<AppData>(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Laboratorio 6',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
          fontFamily: 'NerkoOne',
        ),
        home: const MyHomePage(title: 'Laboratorio 6 - Página de inicio'),
        routes: {
          '/detail': (context) => const DetailPage(),
          '/about': (context) => const AboutPage(),
          '/audit': (context) => const AuditPage(),
        },
      ),
    );
  }
}
