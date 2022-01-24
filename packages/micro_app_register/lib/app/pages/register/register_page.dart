import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/helpers/keyboard_manenger.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../../core/constants/local_image.dart';
import '../verification_email/verification_email_page.dart';
import '../components/form_widget.dart';
import 'register_controller.dart';

class RegisterPage extends StatelessWidget with KeyboardManager {
  final RegisterController controller;
  const RegisterPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: controller,
          builder: (BuildContext _, __, Widget? child) => Stack(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                height: AppDefault.height(context),
                clipBehavior: Clip.none,
                decoration: BoxDecoration(
                  image: controller.page > 1
                      ? const DecorationImage(
                          image: AssetImage(LocalImage.wallpaper04),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage(LocalImage.wallpaper03),
                          fit: BoxFit.cover,
                        ),
                ),
                child: TweenAnimationBuilder<double>(
                  curve: Curves.fastOutSlowIn,
                  tween: Tween<double>(begin: 900, end: 0),
                  duration: const Duration(milliseconds: 300),
                  builder: (_, size, __) => AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 450),
                    margin: EdgeInsets.only(top: size),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ClipRRect(
                            borderRadius: AppDefault.defaultBorderRadius(),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 13.0, sigmaY: 13.0),
                              child: AnimatedContainer(
                                clipBehavior: Clip.none,
                                width: AppDefault.width(context),
                                height: 400,
                                constraints:
                                    const BoxConstraints(maxHeight: 750),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 28),
                                decoration: BoxDecoration(
                                  color: controller.isFocus
                                      ? const Color(0xFF2B2B2B).withOpacity(0.3)
                                      : const Color(0xffACACAC)
                                          .withOpacity(0.26),
                                  borderRadius:
                                      AppDefault.defaultBorderRadius(),
                                ),
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInBack,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                          SystemSoundType
                                                              .click);
                                                      controller.previousPage();
                                                    }
                                                  : null,
                                              icon: Icon(
                                                Iconsax.arrow_square_left,
                                                size: 28,
                                                color: controller.page == 0
                                                    ? Colors.white
                                                        .withOpacity(0.2)
                                                    : Colors.white,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: controller.page < 3 &&
                                                      controller.isNextPage
                                                  ? () {
                                                      SystemSound.play(
                                                          SystemSoundType
                                                              .click);
                                                      controller.nextPage();
                                                    }
                                                  : null,
                                              icon: Icon(
                                                Iconsax.arrow_right,
                                                size: 28,
                                                color: controller.page == 3 ||
                                                        !controller.isNextPage
                                                    ? Colors.white
                                                        .withOpacity(0.2)
                                                    : Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: PageView(
                                        onPageChanged: (page) =>
                                            controller.setPage(page),
                                        physics: controller.isNextPage
                                            ? const BouncingScrollPhysics()
                                            : const NeverScrollableScrollPhysics(),
                                        controller:
                                            controller.pageViewController,
                                        children: [
                                          FormWidget(
                                            labelButton: 'Sim, esse é meu nome',
                                            label:
                                                'Informe seu nome ou apelido',
                                            onEnter: (value) {
                                              controller.name = value;
                                              controller.nextPage();
                                            },
                                            title: 'Qual é o seu nome?',
                                            onFocus: (bool focus) =>
                                                controller.isFocus = focus,
                                            onChanged: (String value) =>
                                                controller.name = value,
                                          ),
                                          FormWidget(
                                            labelButton:
                                                'Sim, esse é meu email',
                                            label: 'Informe o seu email',
                                            onEnter: (value) {
                                              controller.email = value;
                                              controller.nextPage();
                                            },
                                            title: 'Qual é o seu email?',
                                            onFocus: (bool focus) =>
                                                controller.isFocus = focus,
                                            onChanged: (String value) =>
                                                controller.email = value,
                                          ),
                                          FormWidget(
                                            labelButton:
                                                'Essa será minha senha',
                                            label: 'Informe sua senha',
                                            onEnter: (value) {
                                              controller.password = value;
                                              controller.nextPage();
                                            },
                                            title: 'Digite sua senha',
                                            onFocus: (bool focus) =>
                                                controller.isFocus = focus,
                                            onChanged: (String value) =>
                                                controller.password = value,
                                          ),
                                          FormWidget(
                                            labelButton:
                                                'Confirmar e criar conta',
                                            label: 'Informe a senha anterior',
                                            onEnter: (value) {
                                              controller.confirmPassword =
                                                  value;
                                              AppDefault.navigateToWidget(
                                                context,
                                                withReturn: false,
                                                widget: VerificationEmailPage(
                                                  email: controller.email,
                                                ),
                                              );
                                            },
                                            title: 'Confirme sua senha',
                                            onFocus: (bool focus) =>
                                                controller.isFocus = focus,
                                            password: controller.password,
                                            onChanged: (String value) {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  SystemSound.play(SystemSoundType.click);
                  AppDefault.close(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
                label: const Text('Voltar'),
              ).withSymPadding(vPadding: 50),
            ],
          ),
        ),
      ),
    );
  }
}
