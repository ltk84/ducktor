import 'package:ducktor/common/constants/styles.dart';
import 'package:ducktor/common/utilities/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsWidget extends StatelessWidget {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  const NewsWidget({
    super.key,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () async {
            if (!await launchUrl(Uri.parse(url))) {
              throw 'Could not launch $url';
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  urlToImage,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 56),
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 56),
                      child: Center(
                        child: Icon(
                          Icons.error_outline_rounded,
                          color: DucktorThemeProvider.onBackgroundLight,
                          size: 36,
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyle.semiBold16,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        description,
                        style: AppTextStyle.regular14,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
