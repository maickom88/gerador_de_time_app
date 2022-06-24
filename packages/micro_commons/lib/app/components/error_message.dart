import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../core/constants/local_image.dart';

class ErrorMessage extends StatelessWidget {
  final double? height;
  final String? description;

  const ErrorMessage({
    Key? key,
    this.height,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Oups!',
              style: AppTypography.t28WithW800()
                  .copyWith(color: AppColor.primaryColor)),
          SizedBox(
              height: height,
              child: Lottie.asset(
                LocalImage.error2,
                repeat: false,
              )).withBottomPadding(),
          Text(
            description ?? '',
            textAlign: TextAlign.center,
            style: AppTypography.t16(fontName: 'Inter')
                .copyWith(color: AppColor.textLight),
          ),
        ],
      ),
    );
  }
}
