import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/app_color.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:iconsax/iconsax.dart';

import '../components/modal_bottom_sheet_add_player.dart';
import '../components/card_player.dart';

class NavTeam extends StatefulWidget {
  const NavTeam({Key? key}) : super(key: key);

  @override
  _NavTeamState createState() => _NavTeamState();
}

class _NavTeamState extends State<NavTeam> {
  late bool isEditing;
  late List<Map> listChecked;
  @override
  void initState() {
    listChecked = [];
    isEditing = false;
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
              trailing: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) => const ModelBottomAddPlayer(),
                  );
                },
                child: const Icon(
                  Iconsax.edit,
                  color: AppColor.secondaryColor,
                  size: 25,
                ),
              ),
              leading: isEditing
                  ? GestureDetector(
                      onTap: () {
                        SystemSound.play(SystemSoundType.click);
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                      child: FadeAnimation(
                        delay: 0,
                        directionType: DirectionType.translateX,
                        child: Text(
                          'Cancelar',
                          style: AppTypography.t16().copyWith(
                            height: 2.0,
                            color: Colors.red[400],
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        SystemSound.play(SystemSoundType.click);
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                      child: Text(
                        'Editar',
                        style: AppTypography.t16().copyWith(
                          height: 2.0,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
              largeTitle: Text(
                'Jogadores',
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
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => SystemSound.play(SystemSoundType.click),
                  child: Text.rich(
                    TextSpan(
                      style: AppTypography.t16()
                          .copyWith(color: AppColor.secondaryColor),
                      children: const [
                        TextSpan(text: 'Iniciar copinha'),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Iconsax.cup,
                            color: AppColor.secondaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ).withBottomPadding(),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (_, index) {
                    return FadeAnimation(
                      delay: (1.0 + index) / 4,
                      child: ListTile(
                        leading: isEditing
                            ? FadeAnimation(
                                delay: 0,
                                directionType: DirectionType.translateX,
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.all(
                                      AppColor.secondaryColor),
                                  value: listChecked.isNotEmpty
                                      ? listChecked.firstWhere(
                                              (element) =>
                                                  element['index'] == index,
                                              orElse: () =>
                                                  {'value': false})['value'] ??
                                          false
                                      : false,
                                  shape: const CircleBorder(),
                                  onChanged: (bool? value) {
                                    if (value!) {
                                      setState(() {
                                        listChecked.add(
                                            {'index': index, 'value': value});
                                      });
                                    } else {
                                      setState(() {
                                        listChecked.removeWhere((element) =>
                                            element['index'] == index);
                                      });
                                    }
                                  },
                                ),
                              )
                            : null,
                        title: const CardPlayer(),
                      ),
                    );
                  }),
            ],
          ).withSymPadding(),
        ),
      ),
    );
  }
}
