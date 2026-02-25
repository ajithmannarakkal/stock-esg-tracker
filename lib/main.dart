import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/portfolio/presentation/screens/dashboard_screen.dart';

void main() {
  runApp(
     const ProviderScope(child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock ESG Tracker',
      theme: ThemeData.dark(),
      home: const DashboardScreen(),
    );
  }
}


