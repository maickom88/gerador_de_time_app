import 'package:flutter/material.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../core/constants/local_image.dart';

class WidgetEmptyData extends StatelessWidget {
  final String title;
  final String description;

  const WidgetEmptyData({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(LocalImage.emptyImage),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.t16WithW800(),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTypography.t14().copyWith(color: AppColor.textLight),
          ),
        ],
      ),
    );
  }
}
