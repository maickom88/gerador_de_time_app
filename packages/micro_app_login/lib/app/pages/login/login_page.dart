import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/helpers/keyboard_manenger.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../../core/constants/local_image.dart';

import '../../../core/enums/type_provider_enum.dart';
import '../components/form_login.dart';
import '../components/social_widget.dart';
import '../states/login_state.dart';
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
                              ValueListenableBuilder<LoginState>(
                                builder: (BuildContext context, value,
                                    Widget? child) {
                                  if (value is LoginLoandingState) {
                                    return FormLogin(
                                      loading: true,
                                      onLogin:
                                          (String email, String password) =>
                                              widget.controller.login(context,
                                                  email: email,
                                                  password: password),
                                    );
                                  }
                                  if (value is LoginErrorState) {
                                    return FormLogin(
                                      loading: false,
                                      error: value.error.message,
                                      onLogin:
                                          (String email, String password) =>
                                              widget.controller.login(context,
                                                  email: email,
                                                  password: password),
                                    );
                                  }
                                  return FormLogin(
                                    loading: false,
                                    onLogin: (String email, String password) =>
                                        widget.controller.login(context,
                                            email: email, password: password),
                                  );
                                },
                                valueListenable: widget.controller,
                              ),
                              Center(
                                child: Text(
                                  'ou',
                                  style: AppTypography.t16()
                                      .copyWith(color: Colors.white),
                                ),
                              ).withBottomPadding(),
                              SocialWidget(
                                onProvider:
                                    (TypeProviderSocial providerSocial) =>
                                        widget.controller.loginSocial(
                                            context, providerSocial),
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
      ),
    );
  }
}
