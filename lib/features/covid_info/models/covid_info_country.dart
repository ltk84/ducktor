import 'package:flutter/material.dart';

class CovidInfoCountry {
  String name = "World";
  String endpoint = "/global";
  String asset;
  Color backgroundColor;

  CovidInfoCountry({
    required this.name,
    required this.endpoint,
    this.asset = '',
    this.backgroundColor = Colors.blue,
  });
}
