import 'package:flutter/material.dart';

class MenuItem {
  String key;
  String title;
  IconData icon;
  MenuItem(this.key, this.title, this.icon);
}

final List<MenuItem> mainActions = [
  MenuItem("config", "Configuración", Icons.settings),
];

String format(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
}
