import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../components/card_sport.dart';
import '../../../core/constants/local_image.dart';

class NavHome extends StatelessWidget {
  const NavHome({
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
            SliverAppBar(
              leadingWidth: 85,
              excludeHeaderSemantics: false,
              leading: Padding(
                padding: const EdgeInsets.only(left: 28),
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      LocalImage.defaultLogo,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      style: AppTypography.t28(),
                      children: [
                        const TextSpan(text: 'Olá'),
                        TextSpan(
                          text: ' John Doe',
                          style: AppTypography.t28WithW800(),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Hoje é um ótimo dia para jogar 😁',
                    style: AppTypography.t16WithW300(fontName: 'Inter')
                        .copyWith(color: AppColor.textLight),
                  )
                ],
              ),
            ),
            CupertinoSliverNavigationBar(
              backgroundColor: Colors.white.withOpacity(0.8),
              largeTitle: Text(
                'Esportes',
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
              SizedBox(
                height: 325,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    return FadeAnimation(
                      delay: (1.8 + index) / 4,
                      child: const CardSport(),
                    );
                  },
                ),
              ).withBottomPadding(),
              FadeAnimation(
                delay: 1.2,
                child: Image.asset(
                  LocalImage.banner,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ).withSymPadding(),
        ),
      ),
    );
  }
}
