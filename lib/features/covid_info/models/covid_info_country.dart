import 'package:flutter/material.dart';

class CovidInfoCountry {
  String name = "World";
  String queryString = "global";
  IconData? icon;
  Color? backgroundColor;

  CovidInfoCountry({
    required this.name,
    required this.queryString,
    this.icon,
    this.backgroundColor,
  });
}
