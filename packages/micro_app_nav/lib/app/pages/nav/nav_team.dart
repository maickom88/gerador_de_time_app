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
  late List<Map<String, String>> players;
  @override
  void initState() {
    listChecked = [];
    players = [
      {
        'image':
            'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
        'name': 'Gabriel Silva',
        'position': 'Pivô',
      },
      {
        'image':
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
        'name': 'Fabricio Santos',
        'position': 'Pivô',
      },
      {
        'image':
            'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
        'name': 'Marcos Paulo',
        'position': 'Goleiro'
      },
      {
        'image':
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
        'name': 'José',
        'position': 'Ala esquerda'
      },
      {
        'image':
            'https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
        'name': 'Betão',
        'position': 'Pivô'
      },
      {
        'image':
            'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
        'name': 'Santiago',
        'position': 'Ala Direita'
      },
      {
        'image':
            'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
        'name': 'Rodrigo C.',
        'position': 'Defensor'
      },
      {
        'image':
            'https://images.unsplash.com/photo-1531891437562-4301cf35b7e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
        'name': 'Weverton',
        'position': 'Defensor'
      },
      {
        'image':
            'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1148&q=80',
        'name': 'Julio C.',
        'position': 'Defensor'
      },
      {
        'image':
            'https://images.unsplash.com/photo-1603415526960-f7e0328c63b1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        'name': 'Pedro Paulo',
        'position': 'Atacante'
      },
      {
        'image':
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
        'name': 'Pedrinho',
        'position': 'Atacante'
      }
    ];
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
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      child: FadeAnimation(
                        delay: 0,
                        directionType: DirectionType.translateX,
                        child: Material(
                          child: Text(
                            'Cancelar',
                            style: AppTypography.t16().copyWith(
                              height: 2.0,
                              color: Colors.red[400],
                            ),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        SystemSound.play(SystemSoundType.click);
                        setState(() {
                          isEditing = !isEditing;

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.fixed,
                                  backgroundColor: AppColor.secondaryColor,
                                  duration: const Duration(days: 365),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(Iconsax.trash4,
                                          color: Colors.white),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          SystemSound.play(
                                              SystemSoundType.click);
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          setState(() {
                                            isEditing = !isEditing;
                                          });
                                        },
                                        child: const Text('Excluir marcados'),
                                      ).withRightPadding(),
                                      GestureDetector(
                                        onTap: () {
                                          HapticFeedback.lightImpact();
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          setState(() {
                                            isEditing = !isEditing;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.red[300]),
                                          child: const Text('Excluir todos'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                              .closed
                              .then((value) {
                            setState(() {
                              isEditing = false;
                            });
                          });
                        });
                      },
                      child: Material(
                        child: Text(
                          'Editar',
                          style: AppTypography.t16().copyWith(
                            height: 2.0,
                            color: AppColor.secondaryColor,
                          ),
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
                  onTap: () {
                    SystemSound.play(SystemSoundType.click);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    AppDefault.navigateTo(context, routeName: '/cup');
                  },
                  child: Text.rich(
                    TextSpan(
                      style: AppTypography.t16()
                          .copyWith(color: AppColor.secondaryColor),
                      children: const [
                        TextSpan(text: 'Iniciar copinha '),
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
                  itemCount: players.length,
                  itemBuilder: (_, index) {
                    final player = players[index];
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
                        title: CardPlayer(
                          photo: player['image']!,
                          name: player['name']!,
                          position: player['position']!,
                        ),
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
