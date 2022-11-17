import 'package:ducktor/common/constants/assets.dart';
import 'package:ducktor/features/covid_info/widgets/country_widget.dart';
import 'package:ducktor/features/covid_info/widgets/date_picker.dart';
import 'package:ducktor/features/covid_info/widgets/info_tile.dart';
import 'package:ducktor/features/covid_info/widgets/text_info_widget.dart';
import 'package:flutter/material.dart';

import '../../common/constants/colors.dart';
import '../../common/constants/styles.dart';

class CovidInfoScreen extends StatefulWidget {
  const CovidInfoScreen({super.key});

  @override
  State<CovidInfoScreen> createState() => _CovidInfoScreenState();
}

class _CovidInfoScreenState extends State<CovidInfoScreen> {
  final PageController _controller = PageController();
  late Color backgroundColor;
  @override
  void initState() {
    backgroundColor = Colors.blue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
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
                      child: PageView(
                        controller: _controller,
                        onPageChanged: (index) {
                          setState(() {
                            backgroundColor =
                                index == 0 ? Colors.blue : Colors.red;
                          });
                        },
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        children: [
                          CountryWidget(
                            asset: AppAsset.world,
                            name: 'WORLD',
                            maxWidth: countryImageMaxWidth,
                          ),
                          CountryWidget(
                            asset: AppAsset.vietnamFlag,
                            name: 'VIET NAM',
                            maxWidth: countryImageMaxWidth,
                          ),
                        ],
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
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    decoration: BoxDecoration(
                      color: AppColor.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Expanded(
                                child: TextInfoWidget(
                                  text: '69',
                                  description: 'recovered',
                                  primaryColor: Colors.green,
                                ),
                              ),
                              Expanded(
                                child: TextInfoWidget(
                                  text: '1000',
                                  description: 'new confirmed cases',
                                  primaryColor: Colors.orange,
                                  isMain: true,
                                ),
                              ),
                              Expanded(
                                child: TextInfoWidget(
                                  text: '69',
                                  description: 'death',
                                  primaryColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const InfoTile(
                          content: '6969 recoveries in total',
                          backgroundColor: Colors.orange,
                        ),
                        const InfoTile(
                          content: '6969 deaths in total',
                          backgroundColor: Colors.red,
                        ),
                        const InfoTile(
                          content: '6969 new in total',
                          backgroundColor: Colors.green,
                        ),
                      ],
                    ),
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
