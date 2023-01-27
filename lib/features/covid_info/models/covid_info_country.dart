import 'package:ducktor/features/covid_info/models/covid_info_summary.dart';
import 'package:flutter/material.dart';

class CovidInfoCountry {
  String name = "World";
  String endpoint = "/global";
  String asset;
  Color backgroundColor;
  CovidInfoSummary summary;

  CovidInfoCountry({
    required this.name,
    required this.endpoint,
    this.asset = '',
    this.backgroundColor = Colors.blue,
    required this.summary,
  });
}
