import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../core/constants/local_image.dart';

class InformationModal extends StatelessWidget {
  final String description;

  const InformationModal({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 160,
                child: Lottie.asset(
                  LocalImage.help,
                  repeat: false,
                )).withBottomPadding(),
            Text(
              description,
              textAlign: TextAlign.justify,
              style: AppTypography.t16(fontName: 'Inter')
                  .copyWith(color: AppColor.textLight),
            ),
          ],
        ),
      ),
    );
  }
}
