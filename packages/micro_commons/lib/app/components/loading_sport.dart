import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:micro_core/core/theme/app_default.dart';
import 'package:micro_core/core/theme/app_typography.dart';

import '../../core/constants/local_image.dart';

class LoadingSport extends StatelessWidget {
  final String? message;
  const LoadingSport({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 100,
                  child: Lottie.asset(
                    LocalImage.sportLottie,
                  )),
              AppDefault.defaultSpaceHeight(),
              if (message != null)
                Text(
                  message!,
                  style: AppTypography.t16WithW800(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
