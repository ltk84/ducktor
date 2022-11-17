import 'package:flutter/material.dart';

import '../../../common/constants/styles.dart';

class CountryWidget extends StatelessWidget {
  final double maxWidth;
  final String asset;
  final String name;
  const CountryWidget({
    super.key,
    this.maxWidth = double.infinity,
    required this.asset,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
            ),
            child: Image.asset(
              asset,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          name,
          style: AppTextStyle.black18.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
