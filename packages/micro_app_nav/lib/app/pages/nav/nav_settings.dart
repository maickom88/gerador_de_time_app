import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_commons/app/components/avatar_photo.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../components/settings_details.dart';
import '../controllers/logout_controller.dart';

class NavSettings extends StatefulWidget {
  final LogoutController logoutController;
  const NavSettings(
    this.logoutController, {
    Key? key,
  }) : super(key: key);

  @override
  _NavSettingsState createState() => _NavSettingsState();
}

class _NavSettingsState extends State<NavSettings> {
  late FocusNode textFocusNode;
  late bool readOnly;
  @override
  void initState() {
    readOnly = true;
    textFocusNode = FocusNode();
    super.initState();
  }

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
                'Ajustes',
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
              Center(
                child: AvatarPhoto(
                  photo:
                      'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                  onTap: () {},
                  heroTag: '',
                ),
              ),
              SizedBox(
                height: 30,
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    setState(() {
                      readOnly = true;
                    });
                  },
                  focusNode: textFocusNode,
                  readOnly: readOnly,
                  textAlign: TextAlign.center,
                  initialValue: 'John Doe',
                  style: AppTypography.t22WithW800(),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    SystemSound.play(SystemSoundType.click);
                    setState(() {
                      readOnly = false;
                    });
                    FocusScope.of(context).requestFocus(textFocusNode);
                  },
                  child: Text(
                    'Editar nome',
                    style: AppTypography.t16().copyWith(
                      height: 2.0,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                ),
              ).withBottomPadding(),
              FadeAnimation(
                delay: 0.2,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xffF4F4F4),
                    borderRadius: AppDefault.defaultBorderRadius(radius: 20),
                  ),
                  child: Column(
                    children: [
                      SettingsDetails(
                        icon: Iconsax.sms_star,
                        label: 'Notificação por email',
                        widget: CupertinoSwitch(
                          onChanged: (value) {},
                          value: true,
                        ),
                      ),
                      SettingsDetails(
                        icon: Iconsax.bag_2,
                        label: 'Notificações de ofertas',
                        widget: CupertinoSwitch(
                          onChanged: (value) {},
                          value: true,
                        ),
                      ),
                      SettingsDetails(
                        icon: Iconsax.medal,
                        label: 'Ser premium',
                        widget: GestureDetector(
                          onTap: () => SystemSound.play(SystemSoundType.click),
                          child: const Icon(
                            Iconsax.arrow_circle_right,
                            size: 25,
                            color: Color(0xffACACAC),
                          ).withRightPadding(rightPadding: 20),
                        ),
                      ),
                    ],
                  ),
                ).withBottomPadding(),
              ),
              FadeAnimation(
                delay: 0.4,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xffF4F4F4),
                    borderRadius: AppDefault.defaultBorderRadius(radius: 20),
                  ),
                  child: Column(
                    children: [
                      SettingsDetails(
                        icon: Iconsax.moon,
                        label: 'Modo escuro',
                        widget: CupertinoSwitch(
                          onChanged: (value) {},
                          value: false,
                        ),
                      ),
                      SettingsDetails(
                        icon: Iconsax.key,
                        label: 'Alterar senha',
                        widget: GestureDetector(
                          onTap: () async {
                            SystemSound.play(SystemSoundType.click);
                          },
                          child: const Icon(
                            Iconsax.arrow_circle_right,
                            size: 25,
                            color: Color(0xffACACAC),
                          ).withRightPadding(rightPadding: 20),
                        ),
                      ),
                      SettingsDetails(
                        icon: Iconsax.magic_star,
                        label: 'Avaliar o app',
                        widget: GestureDetector(
                          onTap: () async {
                            SystemSound.play(SystemSoundType.click);
                            final inAppReview = InAppReview.instance;

                            if (await inAppReview.isAvailable()) {
                              inAppReview.requestReview();
                            }
                          },
                          child: const Icon(
                            Iconsax.arrow_circle_right,
                            size: 25,
                            color: Color(0xffACACAC),
                          ).withRightPadding(rightPadding: 20),
                        ),
                      ),
                      SettingsDetails(
                        icon: Iconsax.message_notif,
                        label: 'Ajuda',
                        widget: GestureDetector(
                          onTap: () => SystemSound.play(SystemSoundType.click),
                          child: const Icon(
                            Iconsax.arrow_circle_right,
                            size: 25,
                            color: Color(0xffACACAC),
                          ).withRightPadding(rightPadding: 20),
                        ),
                      ),
                      SettingsDetails(
                        icon: Iconsax.trash,
                        label: 'Excluir conta',
                        widget: GestureDetector(
                          onTap: () => SystemSound.play(SystemSoundType.click),
                          child: const Icon(
                            Iconsax.arrow_circle_right,
                            size: 25,
                            color: Color(0xffACACAC),
                          ).withRightPadding(rightPadding: 20),
                        ),
                      ),
                      SettingsDetails(
                        icon: Iconsax.logout,
                        label: 'Sair',
                        widget: GestureDetector(
                          onTap: () {
                            SystemSound.play(SystemSoundType.click);
                            widget.logoutController.logout(context);
                          },
                          child: const Icon(
                            Iconsax.arrow_circle_right,
                            size: 25,
                            color: Color(0xffACACAC),
                          ).withRightPadding(rightPadding: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppDefault.defaultSpaceHeight(height: 40),
              const Center(
                child: Text(
                  '#v1.0.0',
                  style: TextStyle(color: AppColor.textLight),
                ),
              )
            ],
          ).withSymPadding(),
        ),
      ),
    );
  }
}
