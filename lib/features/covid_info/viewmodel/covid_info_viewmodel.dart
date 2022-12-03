import 'package:ducktor/features/covid_info/models/covid_info_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../common/constants/assets.dart';
import '../../../common/constants/strings.dart';
import '../../../common/networking/network_client/network_client.dart';
import '../../../common/networking/networking_constant.dart';
import '../models/covid_info_country.dart';

class CovidInfoViewModel {
  late final _network;

  CovidInfoViewModel() {
    String host = dotenv.env['HOST'] ?? '';
    String port = dotenv.env['PORT'] ?? '';
    _network = NetworkClient("http://$host:$port");
  }

  final List<CovidInfoCountry> _countries = [
    CovidInfoCountry(
      name: "World",
      endpoint: "/global",
      asset: AppAsset.world,
      backgroundColor: Colors.blue,
    ),
    CovidInfoCountry(
      name: "Vietnam",
      endpoint: "/vietnam",
      asset: AppAsset.vietnamFlag,
      backgroundColor: Colors.red,
    ),
  ];

  int _selectedCountryIndex = 0;

  int get countryCount {
    return _countries.length;
  }

  CovidInfoCountry getCountry(int index) {
    return _countries[index];
  }

  CovidInfoCountry getSelectedCountry() {
    return _countries[_selectedCountryIndex];
  }

  void changeCountry(int index) {
    _selectedCountryIndex = index;
  }

  Future<CovidInfoSummary> fetchSummaryInfo() async {
    final path = EndpointString.covidInfoBase +
        _countries[_selectedCountryIndex].endpoint +
        EndpointString.getSummaryInfo;
    final response = await _network.request(
      RequestMethod.get,
      path,
      null,
      null,
    );

    if (response == null) return CovidInfoSummary();

    final CovidInfoSummary result = response.when(success: (data) {
      return CovidInfoSummary.fromMap(data);
    }, error: (message) {
      return CovidInfoSummary();
    }, loading: (message) {
      return CovidInfoSummary();
    });
    return result;
  }
}
