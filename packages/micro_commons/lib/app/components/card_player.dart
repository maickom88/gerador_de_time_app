import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/constants/local_image.dart';
import '../controllers/performace_controller.dart';
import '../factories/build_resources.dart';
import 'avatar_photo.dart';
import 'model_bottom_performace.dart';

class CardPlayer extends StatelessWidget {
  final String name;
  final String? photo;
  final String position;
  final String guid;
  const CardPlayer({
    Key? key,
    required this.name,
    required this.guid,
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
          Builder(builder: (context) {
            const locaImage = ProfileImage.hand1;
            return AvatarPhoto(
              icon: Iconsax.trend_up,
              isLoadImageLocal: photo == null ? true : false,
              photo: photo != null ? photo! : locaImage,
              heroTag: const Uuid().v1(),
              onTap: () {
                showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => ModelBottomPerformance(
                      photo: photo != null ? photo! : locaImage,
                      isLoadLocalImage: photo == null ? true : false,
                      heroTag: name.hashCode.toString(),
                      name: name,
                      position: position,
                      guid: guid,
                      controller:
                          PerformaceController(getPerformacePlayerUsecase)
                            ..getPerformace(guid)),
                );
              },
            );
          }),
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
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: IntrinsicWidth(
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
                            style: AppTypography.t14()
                                .copyWith(color: Colors.white),
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
