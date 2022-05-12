import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../../core/constants/local_image.dart';
import '../../../core/enums/type_provider_enum.dart';

class SocialWidget extends StatelessWidget {
  final void Function(TypeProviderSocial providerSocial) onProvider;
  const SocialWidget({
    Key? key,
    required this.onProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 66,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(
                AppColor.textTitle,
              ),
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              onProvider.call(TypeProviderSocial.apple);
            },
            icon: Image.asset(
              LocalImage.appleLogo,
              width: 20,
            ),
            label: Text(
              '   Continuar com a Apple',
              style: AppTypography.t16().copyWith(color: Colors.white),
            ),
          ),
        ).withBottomPadding(),
        SizedBox(
          width: double.infinity,
          height: 66,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(
                AppColor.secondaryColor,
              ),
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              onProvider.call(TypeProviderSocial.google);
            },
            icon: Image.asset(
              LocalImage.googleLogo,
              width: 20,
            ),
            label: Text(
              '   Continuar com Google',
              style: AppTypography.t16().copyWith(color: Colors.white),
            ),
          ),
        ).withBottomPadding(),
      ],
    );
  }
}
