import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/helpers/keyboard_manenger.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants/local_image.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final LoginController controller;
  const LoginPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with KeyboardManager {
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
        body: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          height: AppDefault.height(context),
          clipBehavior: Clip.none,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(LocalImage.wallpaper02),
              fit: BoxFit.cover,
            ),
          ),
          child: TweenAnimationBuilder<double>(
            curve: Curves.fastOutSlowIn,
            tween: Tween<double>(begin: 500, end: 0),
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
                        filter: ImageFilter.blur(sigmaX: 13.0, sigmaY: 13.0),
                        child: Container(
                          clipBehavior: Clip.none,
                          width: AppDefault.width(context),
                          constraints: const BoxConstraints(maxHeight: 750),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 28),
                          decoration: BoxDecoration(
                            color: const Color(0xffACACAC).withOpacity(0.26),
                            borderRadius: AppDefault.defaultBorderRadius(),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: 17, end: 28),
                                duration: const Duration(milliseconds: 300),
                                builder: (_, size, __) => Text(
                                  'Sign in',
                                  textAlign: TextAlign.center,
                                  style: AppTypography.t28WithW800().copyWith(
                                      fontSize: size, color: Colors.white),
                                ).withBottomPadding(),
                              ).withBottomPadding(),
                              TextField(
                                style: AppTypography.t16(fontName: 'Inter')
                                    .copyWith(color: AppColor.textTitle),
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  suffixIcon: Icon(Iconsax.sms,
                                      color: AppColor.textLight),
                                ),
                              ).withBottomPadding(),
                              TextField(
                                style: AppTypography.t16(fontName: 'Inter')
                                    .copyWith(color: AppColor.textTitle),
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: 'Password',
                                  suffixIcon: Icon(Iconsax.eye_slash,
                                      color: AppColor.textLight),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    SystemSound.play(SystemSoundType.click);
                                  },
                                  child: Text(
                                    'Esqueceu sua senha?',
                                    textAlign: TextAlign.left,
                                    style: AppTypography.t16(fontName: 'Inter')
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ).withBottomPadding(bottomPadding: 30),
                              SizedBox(
                                width: double.infinity,
                                height: 66,
                                child: ElevatedButton(
                                  onPressed: () {
                                    HapticFeedback.lightImpact();
                                    AppDefault.navigateTo(context,
                                        routeName: '/nav', withReturn: false);
                                  },
                                  child: Text(
                                    'Entrar',
                                    style: AppTypography.t16()
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ).withBottomPadding(),
                              SizedBox(
                                width: double.infinity,
                                height: 66,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 1, color: Colors.white),
                                        borderRadius:
                                            AppDefault.defaultBorderRadius(
                                                radius: 10),
                                      ),
                                    ),
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  onPressed: () {
                                    HapticFeedback.lightImpact();
                                    AppDefault.navigateTo(context,
                                        routeName: '/register');
                                  },
                                  child: Text(
                                    'Eu não tenho uma conta',
                                    style: AppTypography.t16()
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ).withBottomPadding(),
                              Center(
                                child: Text(
                                  'ou',
                                  style: AppTypography.t16()
                                      .copyWith(color: Colors.white),
                                ),
                              ).withBottomPadding(),
                              SizedBox(
                                width: double.infinity,
                                height: 66,
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                      AppColor.textTitle,
                                    ),
                                  ),
                                  onPressed: () {
                                    HapticFeedback.lightImpact();
                                    // AppDefault.navigateTo(context,
                                    //     routeName: '/login', withReturn: false);
                                  },
                                  icon: Image.asset(
                                    LocalImage.appleLogo,
                                    width: 20,
                                  ),
                                  label: Text(
                                    '   Continuar com a Apple',
                                    style: AppTypography.t16()
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ).withBottomPadding(),
                              SizedBox(
                                width: double.infinity,
                                height: 66,
                                child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                      AppColor.secondaryColor,
                                    ),
                                  ),
                                  onPressed: () {
                                    HapticFeedback.lightImpact();
                                    // AppDefault.navigateTo(context,
                                    //     routeName: '/login', withReturn: false);
                                  },
                                  icon: Image.asset(
                                    LocalImage.googleLogo,
                                    width: 20,
                                  ),
                                  label: Text(
                                    '   Continuar com Google',
                                    style: AppTypography.t16()
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ).withBottomPadding(),
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
      ),
    );
  }
}
