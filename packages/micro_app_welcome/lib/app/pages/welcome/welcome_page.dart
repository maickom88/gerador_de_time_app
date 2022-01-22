import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:iconsax/iconsax.dart';

import 'welcome_controller.dart';
import '../../../core/constants/local_image.dart';
import '../widgets/widgets.dart';

class WelcomePage extends StatelessWidget {
  final WelcomeController controller;
  const WelcomePage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: Container(
        width: double.infinity,
        clipBehavior: Clip.none,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(LocalImage.wallpaper01),
            fit: BoxFit.cover,
          ),
        ),
        child: TweenAnimationBuilder<double>(
          curve: Curves.linear,
          tween: Tween<double>(begin: 500, end: 0),
          duration: const Duration(milliseconds: 280),
          builder: (_, size, __) => Container(
            margin: EdgeInsets.only(left: size),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: AppDefault.defaultBorderRadius(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 13.0, sigmaY: 13.0),
                    child: Container(
                      clipBehavior: Clip.none,
                      width: AppDefault.width(context),
                      constraints: const BoxConstraints(maxHeight: 350),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xffACACAC).withOpacity(0.26),
                        borderRadius: AppDefault.defaultBorderRadius(),
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: controller,
                        builder: (BuildContext _, __, Widget? child) => Column(
                          children: [
                            FittedBox(
                              child: SizedBox(
                                width: AppDefault.width(context),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: controller.page > 0
                                          ? () {
                                              SystemSound.play(
                                                  SystemSoundType.click);
                                              controller.previousPage();
                                            }
                                          : null,
                                      icon: Icon(
                                        Iconsax.arrow_square_left,
                                        size: 28,
                                        color: controller.page == 0
                                            ? Colors.white.withOpacity(0.2)
                                            : Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: controller.page < 2
                                          ? () {
                                              SystemSound.play(
                                                  SystemSoundType.click);
                                              controller.nextPage();
                                            }
                                          : null,
                                      icon: Icon(
                                        Iconsax.arrow_right,
                                        size: 28,
                                        color: controller.page == 2
                                            ? Colors.white.withOpacity(0.2)
                                            : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: PageView(
                                controller: controller.pageViewController,
                                onPageChanged: (page) => controller.page = page,
                                children: const [
                                  WelcomeWidget(
                                    title: 'Bem vindo ao\nGerador de times',
                                    description:
                                        'Crie copinhas personalizadas,\ngerencie e organize suas peladas',
                                  ),
                                  WelcomeWidget(
                                    title: 'Sorteie equipes\ne administre',
                                    description:
                                        'Separe os jogadores, visualize por tabelas veja as estatisticas finais e relatorios da pelada!',
                                  ),
                                  WelcomeWidget(
                                    title: 'Veja os melhores da\npelada',
                                    description:
                                        'Visualize os jogadores com mais gols, os melhores times por pelada em ranking',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              height: 66,
                              child: ElevatedButton(
                                onPressed: () {
                                  HapticFeedback.lightImpact();
                                  AppDefault.navigateTo(context,
                                      routeName: '/login', withReturn: false);
                                },
                                child: Text(
                                  'Começar',
                                  style: AppTypography.t16()
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ).withBottomPadding(),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DotWidget(isActive: controller.page == 0),
                                  DotWidget(isActive: controller.page == 1),
                                  DotWidget(isActive: controller.page == 2),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ).withSymPadding(vPadding: 50),
          ),
        ),
      ),
    );
  }
}
