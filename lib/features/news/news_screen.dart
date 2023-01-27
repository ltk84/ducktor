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
      body: FutureBuilder(
          future: viewModel.fetchNews(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: snapshot.data!.data.length,
                  itemBuilder: (context, index) {
                    return NewsWidget(
                      title: snapshot.data!.data[index].title,
                      description: snapshot.data!.data[index].description,
                      url: snapshot.data!.data[index].url,
                      urlToImage: snapshot.data!.data[index].urlToImage,
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text(
                  'There is no news available',
                  style: AppTextStyle.regular16,
                ),
              );
            }
          }),
    );
  }
}
