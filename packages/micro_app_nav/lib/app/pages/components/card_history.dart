import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:iconsax/iconsax.dart';

import '../details/details_page.dart';

class CardHistoric extends StatelessWidget {
  final String title;
  final bool isDraft;
  final String nameWinner;

  const CardHistoric({
    Key? key,
    required this.title,
    required this.isDraft,
    required this.nameWinner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  Container(
                    height: 135,
                    width: 1,
                    color: AppColor.lightColor,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 3),
                child: Text(
                  '21 de Outubro',
                  style:
                      AppTypography.t14().copyWith(color: AppColor.textLight),
                ),
              )
            ],
          ),
          Positioned.fill(
            top: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Container(
                height: 120,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColor.lightColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title, style: AppTypography.t22WithW800()),
                        isDraft
                            ? Icon(
                                Iconsax.danger,
                                color: Colors.yellow[700],
                              )
                            : const Icon(
                                Iconsax.verify,
                                color: Colors.green,
                              )
                      ],
                    ),
                    Text(
                      '🏆 $nameWinner',
                      style: AppTypography.t22WithW300()
                          .copyWith(color: AppColor.textLight),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(horizontal: 20),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius:
                                    AppDefault.defaultBorderRadius(radius: 100),
                              ),
                            ),
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                AppColor.secondaryColor),
                          ),
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            AppDefault.navigateToWidget(
                              context,
                              widget: const DetailsPage(),
                            );
                          },
                          child: Text(
                            'Ver detalhes',
                            style: AppTypography.t14()
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
