import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../../core/constants/local_image.dart';

class CardSport extends StatelessWidget {
  final String title;
  final String description;
  final String photoUrl;
  final bool isAvailable;
  const CardSport({
    Key? key,
    required this.title,
    this.isAvailable = true,
    required this.description,
    required this.photoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 320,
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppDefault.defaultBoxShadow(),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 320,
              imageUrl: photoUrl,
              placeholder: (context, url) => Container(color: Colors.grey[200]),
              errorWidget: (context, url, error) => Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  LocalImage.imageNotLoad,
                  scale: 1.4,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 155,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.t22WithW800()
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        description,
                        style: AppTypography.t16()
                            .copyWith(color: Colors.white, height: 1.2),
                      ),
                      const Spacer(),
                      Visibility(
                        replacement: Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: 110,
                            height: 48,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      AppColor.secondaryColor,
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            AppDefault.defaultBorderRadius(
                                          radius: 100,
                                        ),
                                      ),
                                    )),
                                onPressed: null,
                                child: Text(
                                  'Em breve',
                                  style: AppTypography.t16()
                                      .copyWith(color: Colors.white),
                                )),
                          ),
                        ).withBottomPadding(bottomPadding: 5),
                        visible: isAvailable,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: 110,
                            height: 48,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        AppDefault.defaultBorderRadius(
                                      radius: 100,
                                    ),
                                  ),
                                )),
                                onPressed: () => HapticFeedback.lightImpact(),
                                child: Text(
                                  'Iniciar',
                                  style: AppTypography.t16()
                                      .copyWith(color: Colors.white),
                                )),
                          ),
                        ).withBottomPadding(bottomPadding: 5),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).withRightPadding();
  }
}
