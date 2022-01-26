import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

class NavNotification extends StatelessWidget {
  const NavNotification({
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
              trailing: GestureDetector(
                onTap: () {
                  SystemSound.play(SystemSoundType.click);
                },
                child: Text.rich(TextSpan(
                  style: AppTypography.t16().copyWith(
                    height: 2.0,
                    color: AppColor.secondaryColor,
                  ),
                  children: const [
                    TextSpan(text: 'Limpar tudo'),
                    WidgetSpan(
                      child: Icon(
                        Iconsax.broom,
                        color: AppColor.secondaryColor,
                        size: 25,
                      ),
                    )
                  ],
                )),
              ),
              backgroundColor: Colors.white,
              largeTitle: Text(
                'Notificações',
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
              ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return FadeAnimation(
                    delay: (1.0 + index) / 4,
                    child: const CardNotification(
                      title: 'Sua melhor diversão!',
                      description:
                          'Estamos trabalhando em novas versões para tornar suas peladas ainda mais divertidas ✌️',
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

class CardNotification extends StatelessWidget {
  final String title;
  final String description;

  const CardNotification({
    Key? key,
    required this.title,
    required this.description,
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
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: AppTypography.t22WithW800()
                            .copyWith(color: const Color(0xff5C5C5C))),
                    Text(
                      description,
                      style: AppTypography.t16()
                          .copyWith(color: AppColor.textLight),
                    ),
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
