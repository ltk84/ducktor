import 'package:flutter/material.dart';

import '../../../common/constants/assets.dart';
import '../../../common/constants/strings.dart';
import '../../../common/networking/network_client/network_client.dart';
import '../../../common/networking/networking_constant.dart';
import '../models/covid_info_country.dart';

class CovidInfoViewModel {
  final _network = NetworkClient("http://192.168.100.7:5004");

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

  Future<int> fetchCasesCount(String endpoint) async {
    final result = await _network.request(
      RequestMethod.get,
      endpoint,
      null,
      null,
    );

    if (result == null) return 0;

    int count = result.when(success: (data) {
      return data["result"] ?? 0;
    }, error: (message) {
      return 0;
    }, loading: (message) {
      return 0;
    });
    return count;
  }

  Future<String> getTotalInfectedCases() async {
    String endpoint = EndpointString.covidInfoBase +
        _countries[_selectedCountryIndex].endpoint +
        EndpointString.getTotalInfected;
    final result = await fetchCasesCount(endpoint);
    return result.toString();
  }

  Future<String> getTotalRecoveries() async {
    String endpoint = EndpointString.covidInfoBase +
        _countries[_selectedCountryIndex].endpoint +
        EndpointString.getTotalRecovered;
    final result = await fetchCasesCount(endpoint);
    return result.toString();
  }

  Future<String> getTotalDeaths() async {
    String endpoint = EndpointString.covidInfoBase +
        _countries[_selectedCountryIndex].endpoint +
        EndpointString.getTotalDeath;
    final result = await fetchCasesCount(endpoint);
    return result.toString();
  }

  Future<String> getNewInfectedCases() async {
    String endpoint = EndpointString.covidInfoBase +
        _countries[_selectedCountryIndex].endpoint +
        EndpointString.getTodayInfected;
    final result = await fetchCasesCount(endpoint);
    return result.toString();
  }

  Future<String> getNewRecoveries() async {
    String endpoint = EndpointString.covidInfoBase +
        _countries[_selectedCountryIndex].endpoint +
        EndpointString.getTodayRecovered;
    final result = await fetchCasesCount(endpoint);
    return result.toString();
  }

  Future<String> getNewDeaths() async {
    String endpoint = EndpointString.covidInfoBase +
        _countries[_selectedCountryIndex].endpoint +
        EndpointString.getTodayDeath;
    final result = await fetchCasesCount(endpoint);
    return result.toString();
  }
}
