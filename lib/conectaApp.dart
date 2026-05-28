import 'package:flutter/material.dart';

import 'features/home/screens/rotas_screen.dart';

class ConectaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ConectaSTI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: RotasScreen(),
    );
  }
}
