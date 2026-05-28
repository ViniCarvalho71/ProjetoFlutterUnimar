import 'package:flutter/material.dart';

Color tipoNoColor(int tipo) {
  switch (tipo) {
    case 1:
      return const Color(0xFF005BEA);
    case 2:
      return const Color(0xFF0F8B5F);
    case 3:
      return const Color(0xFFD9822B);
    default:
      return const Color(0xFF6E4F7A);
  }
}

IconData tipoNoIcon(int tipo) {
  switch (tipo) {
    case 1:
      return Icons.http_outlined;
    case 2:
      return Icons.functions_outlined;
    case 3:
      return Icons.storage_outlined;
    default:
      return Icons.adjust_outlined;
  }
}
