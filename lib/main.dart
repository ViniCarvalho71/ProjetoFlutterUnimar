import 'package:flutter/material.dart';
import 'package:myapp/features/core/DI/injection.dart';
import 'conecta_app.dart';

void main() {
  setupDependencies();
  runApp(const ConectaApp());
}
