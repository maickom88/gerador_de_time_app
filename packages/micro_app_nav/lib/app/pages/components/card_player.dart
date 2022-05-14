import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'avatar_photo.dart';
import 'model_bottom_performace.dart';

class CardPlayer extends StatelessWidget {
  final String name;
  final String photo;
  final String position;
  const CardPlayer({
    Key? key,
    required this.name,
    required this.position,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      height: 140,
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AvatarPhoto(
            icon: Iconsax.trend_up,
            photo: photo,
            onTap: () {
              showCupertinoModalBottomSheet(
                context: context,
                builder: (context) => const ModelBottomPerformance(),
              );
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.t22WithW800(),
                ),
                Row(
                  children: [
                    const Icon(Iconsax.star1,
                            size: 25, color: AppColor.primaryColor)
                        .withRightPadding(rightPadding: 0),
                    const Icon(Iconsax.star1,
                            size: 25, color: AppColor.primaryColor)
                        .withRightPadding(rightPadding: 0),
                    const Icon(Iconsax.star1,
                            size: 25, color: AppColor.primaryColor)
                        .withRightPadding(rightPadding: 5),
                    const Icon(Iconsax.star,
                            size: 19, color: AppColor.primaryColor)
                        .withRightPadding(rightPadding: 5),
                    const Icon(Iconsax.star,
                            size: 19, color: AppColor.primaryColor)
                        .withRightPadding(rightPadding: 5),
                  ],
                ).withBottomPadding(bottomPadding: 10),
                Container(
                  height: 28,
                  width: 185,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColor.secondaryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                            child: Text(
                          'POSIÇÃO',
                          style:
                              AppTypography.t14().copyWith(color: Colors.white),
                        )),
                      ).withRightPadding(rightPadding: 5),
                      Flexible(
                        child: Text(
                          position.toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ).withBottomPadding(),
    );
  }
}
