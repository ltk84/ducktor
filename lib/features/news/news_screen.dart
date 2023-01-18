import 'package:ducktor/common/constants/styles.dart';
import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:ducktor/features/news/viewmodel/news_viewmodel.dart';
import 'package:ducktor/features/news/widgets/news_widget.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsViewModel viewModel = NewsViewModel();
    return Scaffold(
      backgroundColor: DucktorThemeProvider.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "News",
          style: AppTextStyle.semiBold18.copyWith(
            color: DucktorThemeProvider.onBackground,
          ),
        ),
        centerTitle: true,
        leading: BackButton(
          color: DucktorThemeProvider.onBackground,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          NewsWidget(
              title:
                  "Remote Healthcare Market is estimated to be US\$ 57.1 billion by 2032 with a CAGR of 19.8% over the forecast period (2022-2032) - By PMI",
              description:
                  "Remote Healthcare Market, By Service (Real Time Virtual Health, Remote Patient Monitoring, Tele-ICU), By Application (Obstetrics, Cardiology, Diagnosis, and ...",
              url:
                  "https://finance.yahoo.com/news/remote-healthcare-market-estimated-us-132800504.html",
              urlToImage:
                  "https://media.zenfs.com/en/globenewswire.com/ae25776945614f4cea853b1fd75dfb26"),
        ],
      ),
    );
  }
}
