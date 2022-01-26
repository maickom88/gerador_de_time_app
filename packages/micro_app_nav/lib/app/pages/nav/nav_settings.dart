import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_app_nav/app/pages/components/avatar_photo.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

class NavSettings extends StatefulWidget {
  const NavSettings({
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
              backgroundColor: Colors.white,
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
                          onTap: () => SystemSound.play(SystemSoundType.click),
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
                          onTap: () => SystemSound.play(SystemSoundType.click),
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
                    ],
                  ),
                ),
              ),
            ],
          ).withSymPadding(),
        ),
      ),
    );
  }
}

class SettingsDetails extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget widget;
  const SettingsDetails({
    Key? key,
    required this.label,
    required this.widget,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            size: 25,
            color: const Color(0xffACACAC),
          ).withRightPadding(rightPadding: 20),
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color(0xffC4C4C4),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: AppTypography.t16().copyWith(
                      color: const Color(0xffACACAC),
                    ),
                  ),
                  widget,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
