import 'package:flutter/material.dart';
import 'package:myapp/features/core/DI/injection.dart';
import 'conectaApp.dart';

void main() {
  setupDependencies();
  runApp(ConectaApp());
}
