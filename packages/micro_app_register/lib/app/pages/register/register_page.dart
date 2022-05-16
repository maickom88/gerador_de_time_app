import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/helpers/keyboard_manenger.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../../core/constants/local_image.dart';
import '../components/form_widget.dart';
import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  final RegisterController controller;
  const RegisterPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with KeyboardManager {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: widget.controller,
          builder: (BuildContext _, __, Widget? child) => Stack(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                height: AppDefault.height(context),
                clipBehavior: Clip.none,
                decoration: BoxDecoration(
                  image: widget.controller.page > 1
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
                                height: 430,
                                constraints:
                                    const BoxConstraints(maxHeight: 750),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 28),
                                decoration: BoxDecoration(
                                  color: widget.controller.isFocus
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
                                              onPressed:
                                                  widget.controller.page > 0
                                                      ? () {
                                                          SystemSound.play(
                                                              SystemSoundType
                                                                  .click);
                                                          widget.controller
                                                              .previousPage();
                                                        }
                                                      : null,
                                              icon: Icon(
                                                Iconsax.arrow_square_left,
                                                size: 28,
                                                color:
                                                    widget.controller.page == 0
                                                        ? Colors.white
                                                            .withOpacity(0.2)
                                                        : Colors.white,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed:
                                                  widget.controller.page < 3 &&
                                                          widget.controller
                                                              .isNextPage
                                                      ? () {
                                                          SystemSound.play(
                                                              SystemSoundType
                                                                  .click);
                                                          widget.controller
                                                              .nextPage();
                                                        }
                                                      : null,
                                              icon: Icon(
                                                Iconsax.arrow_right,
                                                size: 28,
                                                color: widget.controller.page ==
                                                            3 ||
                                                        !widget.controller
                                                            .isNextPage
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
                                            widget.controller.setPage(page),
                                        physics: widget.controller.isNextPage
                                            ? const BouncingScrollPhysics()
                                            : const NeverScrollableScrollPhysics(),
                                        controller: widget
                                            .controller.pageViewController,
                                        children: [
                                          FormWidget(
                                            labelButton: 'Sim, esse é meu nome',
                                            label:
                                                'Informe seu nome ou apelido',
                                            onEnter: (value) {
                                              widget.controller.name = value;
                                              widget.controller.nextPage();
                                            },
                                            title: 'Qual é o seu nome?',
                                            onFocus: (bool focus) => widget
                                                .controller.isFocus = focus,
                                            onChanged: (String value) =>
                                                widget.controller.name = value,
                                          ),
                                          FormWidget(
                                            labelButton:
                                                'Sim, esse é meu email',
                                            label: 'Informe o seu email',
                                            onEnter: (value) {
                                              widget.controller.email = value;
                                              widget.controller.nextPage();
                                            },
                                            title: 'Qual é o seu email?',
                                            onFocus: (bool focus) => widget
                                                .controller.isFocus = focus,
                                            onChanged: (String value) =>
                                                widget.controller.email = value,
                                          ),
                                          FormWidget(
                                            labelButton:
                                                'Essa será minha senha',
                                            label: 'Informe sua senha',
                                            onEnter: (value) {
                                              widget.controller.password =
                                                  value;
                                              widget.controller.nextPage();
                                            },
                                            title: 'Digite sua senha',
                                            onFocus: (bool focus) => widget
                                                .controller.isFocus = focus,
                                            onChanged: (String value) => widget
                                                .controller.password = value,
                                          ),
                                          FormWidget(
                                            load: widget.controller.isLoad,
                                            labelButton:
                                                'Confirmar e criar conta',
                                            label: 'Informe a senha anterior',
                                            onEnter: (value) {
                                              widget.controller
                                                  .confirmPassword = value;
                                              widget.controller
                                                  .registerAccount(context);
                                            },
                                            title: 'Confirme sua senha',
                                            onFocus: (bool focus) => widget
                                                .controller.isFocus = focus,
                                            password:
                                                widget.controller.password,
                                            onChanged: (String value) {},
                                            errorMessage:
                                                widget.controller.error,
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
