import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/theme/theme.dart';

class CardSport extends StatelessWidget {
  const CardSport({
    Key? key,
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
        image: const DecorationImage(
          image: NetworkImage(
              'https://ardos.com.br/wp-content/uploads/2020/09/Depositphotos_159281952_xl-2015-2048x1367.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
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
                    'Futebol',
                    style: AppTypography.t22WithW800()
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    'Monte seu time, defina as regras do jogo e divirta-se ⚽',
                    style: AppTypography.t16()
                        .copyWith(color: Colors.white, height: 1.2),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 100,
                      height: 42,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: AppDefault.defaultBorderRadius(
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
                  ).withBottomPadding(bottomPadding: 5)
                ],
              ),
            ),
          ),
        ),
      ),
    ).withRightPadding();
  }
}
