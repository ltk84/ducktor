import 'package:ducktor/features/covid_info/viewmodel/covid_info_viewmodel.dart';
import 'package:ducktor/features/covid_info/widgets/country_widget.dart';
import 'package:ducktor/features/covid_info/widgets/date_picker.dart';
import 'package:ducktor/features/covid_info/widgets/info_tile.dart';
import 'package:ducktor/features/covid_info/widgets/text_info_widget.dart';
import 'package:flutter/material.dart';

import '../../common/utilities/theme_provider.dart';
import '../../common/constants/styles.dart';

class CovidInfoScreen extends StatefulWidget {
  const CovidInfoScreen({super.key});

  @override
  State<CovidInfoScreen> createState() => _CovidInfoScreenState();
}

class _CovidInfoScreenState extends State<CovidInfoScreen> {
  final CovidInfoViewModel viewModel = CovidInfoViewModel();

  String _totalInfectedCases = "0";
  String _totalRecoveries = "0";
  String _totalDeaths = "0";
  String _newInfectedCases = "0";
  String _newRecoveries = "0";
  String _newDeaths = "0";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: viewModel.getSelectedCountry().backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "COVID-19 Infomation",
            style: AppTextStyle.semiBold18.copyWith(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: const BackButton(
            color: Colors.white,
          ),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          final double countryImageMaxWidth = constraints.maxWidth * 0.5;

          return ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: PageView.builder(
                        onPageChanged: (index) async {
                          setState(() {
                            viewModel.changeCountry(index);
                          });
                        },
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        itemCount: viewModel.countryCount,
                        itemBuilder: (context, index) {
                          return CountryWidget(
                            asset: viewModel.getCountry(index).asset,
                            name:
                                viewModel.getCountry(index).name.toUpperCase(),
                            maxWidth: countryImageMaxWidth,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const DatePicker(),
                  const SizedBox(
                    height: 24,
                  ),
                  FutureBuilder(
                    future: viewModel.fetchSummaryInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          _totalInfectedCases =
                              snapshot.data!.totalInfectedCases.toString();
                          _totalRecoveries =
                              snapshot.data!.totalRecoveries.toString();
                          _totalDeaths = snapshot.data!.totalDeaths.toString();
                          _newInfectedCases =
                              snapshot.data!.newInfectedCases.toString();
                          _newRecoveries =
                              snapshot.data!.newRecoveries.toString();
                          _newDeaths = snapshot.data!.newDeaths.toString();
                        }
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.fromLTRB(24, 8, 24, 0),
                          child: LinearProgressIndicator(),
                        );
                      }

                      return Container(
                        margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        decoration: BoxDecoration(
                          color: DucktorThemeProvider.background,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextInfoWidget(
                                      text: _newRecoveries,
                                      description: 'recoveries',
                                      primaryColor: Colors.green,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextInfoWidget(
                                      text: _newInfectedCases,
                                      description: 'new infected\ncases',
                                      primaryColor: Colors.orange,
                                      isMain: true,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextInfoWidget(
                                      text: _newDeaths,
                                      description: 'deaths',
                                      primaryColor: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InfoTile(
                              content:
                                  '$_totalInfectedCases infected cases in total',
                              backgroundColor: Colors.orange,
                            ),
                            InfoTile(
                              content: '$_totalDeaths deaths in total',
                              backgroundColor: Colors.red,
                            ),
                            InfoTile(
                              content: '$_totalRecoveries recoveries in total',
                              backgroundColor: Colors.green,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
