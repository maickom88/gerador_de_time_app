import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../components/card_history.dart';

class NavHistoric extends StatelessWidget {
  const NavHistoric({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (_, inner) {
          return <Widget>[
            const SliverToBoxAdapter(
                child: SizedBox(
              height: 20,
            )),
            CupertinoSliverNavigationBar(
              backgroundColor: Colors.white.withOpacity(0.8),
              largeTitle: Text(
                'Historico',
                style: AppTypography.t28WithW800(),
              ),
              border: Border.all(color: Colors.transparent),
            ),
          ];
        },
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 48,
                child: CupertinoTextField(
                  placeholder: 'Pesquisar',
                  suffix: IconButton(
                    icon: const Icon(
                      Iconsax.setting_4,
                      color: AppColor.textLight,
                    ).withRightPadding(),
                    onPressed: () => SystemSound.play(SystemSoundType.click),
                  ),
                  prefix: const Icon(
                    Iconsax.search_normal,
                    color: AppColor.textLight,
                  ).withLeftPadding(),
                  decoration: BoxDecoration(
                    color: AppColor.lightColor,
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ).withBottomPadding(bottomPadding: 30),
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return FadeAnimation(
                    delay: (1.0 + index) / 4,
                    child: CardHistoric(
                      isDraft: index % 2 == 0 ? true : false,
                      title: 'Futebol',
                      nameWinner: 'Banc fc'.toUpperCase(),
                    ),
                  );
                },
              )
            ],
          ).withSymPadding(),
        ),
      ),
    );
  }
}
