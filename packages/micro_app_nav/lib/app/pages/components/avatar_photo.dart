import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants/local_image.dart';

class AvatarPhoto extends StatelessWidget {
  final String? photo;
  final VoidCallback onTap;
  final IconData icon;
  const AvatarPhoto({
    Key? key,
    required this.photo,
    this.icon = Iconsax.camera,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Stack(
        children: [
          Container(
            width: 85,
            height: 85,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.textLight,
            ),
            child: ClipOval(
              child: Builder(builder: (context) {
                if (photo != null) {
                  return Image.network(
                    photo!,
                    fit: BoxFit.cover,
                    height: 85,
                    width: 85,
                  );
                }
                return Image.asset(
                  ProfileImage.generateImage(),
                  fit: BoxFit.cover,
                  height: 85,
                  width: 85,
                );
              }),
            ),
          ),
          Positioned.fill(
            right: 7,
            top: 0,
            child: Align(
              alignment: Alignment.topRight,
              child: ClipRRect(
                borderRadius: AppDefault.defaultBorderRadius(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 13.0, sigmaY: 13.0),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onTap.call();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColor.secondaryColor.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
