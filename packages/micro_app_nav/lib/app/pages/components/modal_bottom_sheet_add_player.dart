import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/utils/theme.dart';
import '../components/page_search_position.dart';
import 'page_search_position.dart';

class ModelBottomAddPlayer extends StatelessWidget {
  const ModelBottomAddPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        height: AppDefault.height(context).percent(68),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
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
                  Text(
                    'Adicionar jogador',
                    style: AppTypography.t16().copyWith(),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Salvar',
                      style: AppTypography.t16().copyWith(
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ).withBottomPadding(),
              Center(
                child: Container(
                  width: 85,
                  height: 85,
                  decoration: const BoxDecoration(
                    color: AppColor.lightColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Iconsax.camera,
                    size: 38,
                  ),
                ).withBottomPadding(),
              ),
              const TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.lightColor,
                  hintText: 'Nome',
                  suffixIcon: Icon(Iconsax.user),
                ),
              ).themeTwo().withBottomPadding(),
              TextField(
                onTap: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    expand: true,
                    builder: (context) => const PageSearchPosition(),
                  );
                },
                readOnly: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColor.lightColor,
                  hintText: 'Posição',
                  suffixIcon: Icon(Iconsax.arrow_down),
                ),
              ).themeTwo().withBottomPadding(bottomPadding: 5),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'Opcional',
                  style:
                      AppTypography.t14().copyWith(color: AppColor.textLight),
                ),
              ),
              Text(
                'Editar habilidades',
                style: AppTypography.t16().copyWith(
                  height: 2.0,
                  color: AppColor.secondaryColor,
                ),
              ),
              FadeAnimation(
                delay: 0.2,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: AppColor.lightColor),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Força',
                        style: AppTypography.t16WithW800()
                            .copyWith(color: AppColor.textLight),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.star1,
                                  size: 30, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 0),
                          const Icon(Iconsax.star1,
                                  size: 30, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 0),
                          const Icon(Iconsax.star1,
                                  size: 30, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 5),
                          const Icon(Iconsax.star,
                                  size: 20, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 5)
                              .withTopPadding(topPadding: 5),
                          const Icon(Iconsax.star,
                                  size: 20, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 5)
                              .withTopPadding(topPadding: 5),
                        ],
                      ),
                    ],
                  ),
                ).withTopPadding(),
              ),
              FadeAnimation(
                delay: 0.4,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: AppColor.lightColor),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Velocidade',
                        style: AppTypography.t16WithW800()
                            .copyWith(color: AppColor.textLight),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.star1,
                                  size: 30, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 0),
                          const Icon(Iconsax.star1,
                                  size: 30, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 0),
                          const Icon(Iconsax.star1,
                                  size: 30, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 5),
                          const Icon(Iconsax.star,
                                  size: 20, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 5)
                              .withTopPadding(topPadding: 5),
                          const Icon(Iconsax.star,
                                  size: 20, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 5)
                              .withTopPadding(topPadding: 5),
                        ],
                      ),
                    ],
                  ),
                ).withTopPadding(),
              ),
              FadeAnimation(
                delay: 0.6,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: AppColor.lightColor),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Drible',
                        style: AppTypography.t16WithW800()
                            .copyWith(color: AppColor.textLight),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.star1,
                                  size: 30, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 0),
                          const Icon(Iconsax.star1,
                                  size: 30, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 0),
                          const Icon(Iconsax.star1,
                                  size: 30, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 5),
                          const Icon(Iconsax.star,
                                  size: 20, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 5)
                              .withTopPadding(topPadding: 5),
                          const Icon(Iconsax.star,
                                  size: 20, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 5)
                              .withTopPadding(topPadding: 5),
                        ],
                      ),
                    ],
                  ),
                ).withTopPadding(),
              ),
              FadeAnimation(
                delay: 0.8,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: AppColor.lightColor),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Finalização',
                        style: AppTypography.t16WithW800()
                            .copyWith(color: AppColor.textLight),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Iconsax.star1,
                                  size: 30, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 0),
                          const Icon(Iconsax.star1,
                                  size: 30, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 0),
                          const Icon(Iconsax.star1,
                                  size: 30, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 5),
                          const Icon(Iconsax.star,
                                  size: 20, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 5)
                              .withTopPadding(topPadding: 5),
                          const Icon(Iconsax.star,
                                  size: 20, color: AppColor.primaryColor)
                              .withRightPadding(rightPadding: 5)
                              .withTopPadding(topPadding: 5),
                        ],
                      ),
                    ],
                  ),
                ).withTopPadding(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
