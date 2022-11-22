class CovidInfoSummary {
  final int newDeaths;
  final int totalDeaths;
  final int newInfectedCases;
  final int totalInfectedCases;
  final int newRecoveries;
  final int totalRecoveries;

  CovidInfoSummary(
      {this.newDeaths = 0,
      this.totalDeaths = 0,
      this.newInfectedCases = 0,
      this.totalInfectedCases = 0,
      this.newRecoveries = 0,
      this.totalRecoveries = 0});

  factory CovidInfoSummary.fromMap(Map<String, dynamic> map) {
    return CovidInfoSummary(
      newDeaths: map['death_in_day'] ?? 0,
      totalDeaths: map['death_total'] ?? 0,
      newInfectedCases: map['infected_in_day'] ?? 0,
      totalInfectedCases: map['infected_total'] ?? 0,
      newRecoveries: map['recovered_in_day'] ?? 0,
      totalRecoveries: map['recovered_total'] ?? 0,
    );
  }
}
