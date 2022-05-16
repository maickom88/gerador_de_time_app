import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

class ModelBottomPerformance extends StatelessWidget {
  final String photo;
  final bool isLoadLocalImage;
  final String heroTag;
  final String name;
  final String position;
  const ModelBottomPerformance({
    Key? key,
    required this.photo,
    required this.heroTag,
    required this.name,
    required this.position,
    this.isLoadLocalImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: AppDefault.height(context).percent(50),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        SystemSound.play(SystemSoundType.click);
                        AppDefault.close(context);
                      },
                      child: Text(
                        'Cancelar',
                        style: AppTypography.t16().copyWith(
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Desempenho',
                      style: AppTypography.t16().copyWith(),
                    ),
                  ),
                ],
              ).withBottomPadding(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
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
                              child: Builder(
                                builder: (context) {
                                  if (!isLoadLocalImage) {
                                    return Hero(
                                      tag: heroTag,
                                      child: Image.network(
                                        photo,
                                        fit: BoxFit.cover,
                                        height: 85,
                                        width: 85,
                                      ),
                                    );
                                  }
                                  return Hero(
                                    tag: heroTag,
                                    child: Image.asset(
                                      photo,
                                      fit: BoxFit.cover,
                                      height: 85,
                                      width: 85,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
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
                              color: AppColor.lightColor,
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
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ).withBottomPadding(),
              const FadeAnimation(
                delay: 0.2,
                child: PerformaceDetails(
                  emoji: '🏆',
                  label: 'Vitorias',
                  value: 2,
                  color: Colors.green,
                ),
              ),
              FadeAnimation(
                delay: 0.4,
                child: PerformaceDetails(
                  emoji: '⚽️',
                  color: Colors.yellow[700]!,
                  label: 'Gols marcados',
                  value: 6,
                ),
              ),
              const FadeAnimation(
                delay: 0.6,
                child: PerformaceDetails(
                  emoji: '🔥',
                  color: AppColor.secondaryColor,
                  label: 'Copinhas',
                  value: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PerformaceDetails extends StatelessWidget {
  final String label;
  final String emoji;
  final int value;
  final Color color;
  const PerformaceDetails({
    Key? key,
    required this.label,
    required this.color,
    required this.emoji,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            emoji,
            style: AppTypography.t28(),
          ).withRightPadding(rightPadding: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: AppColor.lightColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: AppTypography.t22WithW300()
                        .copyWith(color: AppColor.textLight),
                  ),
                  Container(
                    constraints: const BoxConstraints(minWidth: 60),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: color,
                    ),
                    child: Center(
                      child: Text(
                        value.toString(),
                        style:
                            AppTypography.t16().copyWith(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
