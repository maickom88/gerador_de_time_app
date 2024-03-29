import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:micro_commons/app/components/card_player.dart';
import 'package:micro_commons/app/components/error_page.dart';
import 'package:micro_commons/app/domain/entities/skill_entity.dart';
import 'package:micro_commons/app/domain/entities/user_entity.dart';
import 'package:micro_commons/core/constants/local_image.dart';
import 'package:micro_commons/utils/alert_util.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:iconsax/iconsax.dart';

import '../states/cup_state.dart';
import '../controllers/cup_controller.dart';

class CupPage extends StatefulWidget {
  final CupController cupController;
  const CupPage({
    Key? key,
    required this.cupController,
  }) : super(key: key);

  @override
  _CupPageState createState() => _CupPageState();
}

class _CupPageState extends State<CupPage> {
  late bool isEditing;
  late Tween<double> tween;
  @override
  void initState() {
    isEditing = false;
    tween = Tween<double>(begin: 0.0, end: 5.0);
    super.initState();
  }

  int? calculeSkill(SkillEntity skill) {
    int maxSkill = 0;
    maxSkill =
        skill.completion + skill.dribble + skill.strength + skill.velocity;
    return maxSkill ~/ 4;
  }

  @override
  void dispose() {
    widget.cupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                leading: GestureDetector(
                  onTap: () {
                    SystemSound.play(SystemSoundType.click);
                    AppDefault.close(context);
                  },
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      'Voltar',
                      style: AppTypography.t16().copyWith(
                        height: 2.0,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ),
                ),
                largeTitle: Text(
                  'Criar copinha',
                  style: AppTypography.t28WithW800(),
                ),
                border: Border.all(color: Colors.transparent),
              ),
            ];
          },
          body: ValueListenableBuilder<CupState>(
              valueListenable: widget.cupController,
              builder: (context, value, child) {
                if (value is CupErrorState) {
                  return ErrorComponent(
                    onLoad: () => widget.cupController.getPlayers(),
                  );
                }
                if (value is CupSuccessState) {
                  if (value.players.isEmpty) {
                    Future.delayed(const Duration(seconds: 1), () {
                      showCupertinoModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(top: 30),
                            height: AppDefault.height(context).percent(40),
                            child: Material(
                              color: Colors.white,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      LocalImage.emptyImage,
                                      height: 140,
                                    ).withBottomPadding(),
                                    Text(
                                      'Parece que sua lista de jogadores está vazia',
                                      style: AppTypography.t14()
                                          .copyWith(color: AppColor.textLight),
                                    ),
                                    Text(
                                      'Para iniciar uma copinha adicione jogadores',
                                      style: AppTypography.t14()
                                          .copyWith(color: AppColor.textLight),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    });
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 48,
                          child: CupertinoTextField(
                            placeholder: 'Pesquisar',
                            onChanged: (value) =>
                                widget.cupController.searchPlayer(value),
                            suffix: IconButton(
                              icon: const Icon(
                                Iconsax.setting_4,
                                color: AppColor.textLight,
                              ).withRightPadding(),
                              onPressed: () =>
                                  SystemSound.play(SystemSoundType.click),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Equilibrar times?',
                                      style: AppTypography.t14()
                                          .copyWith(color: AppColor.textLight),
                                    ),
                                    Visibility(
                                      replacement: CupertinoSwitch(
                                        value: false,
                                        onChanged: (value) async {
                                          await AppDefault.navigateTo(context,
                                              routeName: '/subscription');
                                          widget.cupController.loadUser();
                                        },
                                      ),
                                      visible: widget
                                              .cupController.userEntity?.role ==
                                          RoleEnum.premium,
                                      child: CupertinoSwitch(
                                        value:
                                            widget.cupController.balanceTeams,
                                        onChanged: (value) => widget
                                            .cupController.balanceTeams = value,
                                      ),
                                    )
                                  ],
                                ).withBottomPadding(bottomPadding: 8),
                                Row(
                                  children: [
                                    Text(
                                      'Quantos times?',
                                      style: AppTypography.t14()
                                          .copyWith(color: AppColor.textLight),
                                    ).withRightPadding(),
                                    GestureDetector(
                                      onTap: () {
                                        SystemSound.play(SystemSoundType.click);
                                        showCupertinoModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                padding: const EdgeInsets.only(
                                                    top: 30),
                                                height: 350,
                                                color: Colors.white,
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                SystemSound.play(
                                                                    SystemSoundType
                                                                        .click);
                                                                AppDefault.close(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                'Cancelar',
                                                                style: AppTypography
                                                                        .t16()
                                                                    .copyWith(
                                                                  color: AppColor
                                                                      .secondaryColor,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ).withBottomPadding(),
                                                      Expanded(
                                                        child: CupertinoPicker(
                                                          magnification: 1.5,
                                                          backgroundColor:
                                                              Colors.white,
                                                          onSelectedItemChanged:
                                                              (value) {
                                                            widget.cupController
                                                                    .numberOfTeam =
                                                                value + 2;
                                                          },
                                                          itemExtent: 45,
                                                          children:
                                                              List.generate(
                                                            widget
                                                                        .cupController
                                                                        .userEntity
                                                                        ?.role ==
                                                                    RoleEnum
                                                                        .premium
                                                                ? 20
                                                                : 10,
                                                            (index) => Text(
                                                              (index + 2)
                                                                  .toString(),
                                                              style:
                                                                  AppTypography
                                                                      .t16(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ).withSymPadding(),
                                              );
                                            });
                                      },
                                      child: Container(
                                        width: 55,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColor.lightColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            (widget.cupController.numberOfTeam)
                                                .toString(),
                                            style: AppTypography.t16().copyWith(
                                                color: AppColor.textLight),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                SystemSound.play(SystemSoundType.click);
                                if (widget
                                    .cupController.playerSelected.isEmpty) {
                                  showAlert(context,
                                      'Selecione os jogadores para essa copinha');
                                  return;
                                }

                                if (widget.cupController.playerSelected.length <
                                    8) {
                                  showAlert(context,
                                      'É necessário 8 jogadores ou mais para realizar o sorteio');
                                  return;
                                }
                                if ((widget.cupController.playerSelected
                                            .length %
                                        widget.cupController.numberOfTeam) !=
                                    0) {
                                  showAlert(context,
                                      'Não é possível formar ${widget.cupController.numberOfTeam} times\ncom ${widget.cupController.playerSelected.length} de jogadores');
                                  return;
                                }
                                if (widget.cupController.numberOfTeam <= 0) {
                                  showAlert(
                                      context, 'Informe a quantidade de times');
                                  return;
                                }

                                widget.cupController.drawPLayers(context);
                              },
                              child: Text.rich(
                                TextSpan(
                                  style: AppTypography.t16()
                                      .copyWith(color: AppColor.secondaryColor),
                                  children: [
                                    const TextSpan(text: 'Sortear '),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: LoopAnimation(
                                        child: const Icon(
                                          Iconsax.arrow_circle_right,
                                          color: AppColor.secondaryColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ).withBottomPadding(),
                          ],
                        ).withBottomPadding(),
                        if (widget.cupController.playerSelected.length <
                            value.players.length)
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  primary: AppColor.secondaryColor),
                              onPressed: () => widget.cupController
                                  .selectedAllPlayers(value.players),
                              child: Text(
                                'Marca todos',
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                            ),
                          ),
                        if (widget.cupController.playerSelected.length >=
                            value.players.length)
                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 208, 49, 49)),
                              onPressed: () => widget.cupController
                                  .removeSelectedAllPlayers(value.players),
                              child: Text(
                                'Desmarcar todos',
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                            ),
                          ),
                        widget.cupController.playerSelected.isEmpty
                            ? Text(
                                'Marque os jogadores para a copinha',
                                style: AppTypography.t14()
                                    .copyWith(color: AppColor.textLight),
                              )
                            : widget.cupController.playerSelected.length == 1
                                ? Text('1 jogador marcado',
                                    style: AppTypography.t14()
                                        .copyWith(color: AppColor.textLight))
                                : Text(
                                    '${widget.cupController.playerSelected.length} jogadores marcados',
                                    style: AppTypography.t14()
                                        .copyWith(color: AppColor.textLight),
                                  ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget
                                    .cupController.searchResultPlayer.isNotEmpty
                                ? widget.cupController.searchResultPlayer.length
                                : value.players.length,
                            itemBuilder: (_, index) {
                              final player = widget.cupController
                                      .searchResultPlayer.isNotEmpty
                                  ? widget
                                      .cupController.searchResultPlayer[index]
                                  : value.players[index];
                              return FadeAnimation(
                                delay: (1.0 + index) / 4,
                                child: ListTile(
                                  leading: Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: MaterialStateProperty.all(
                                        AppColor.secondaryColor),
                                    value: widget.cupController.playerSelected
                                            .isNotEmpty
                                        ? widget.cupController.playerSelected
                                                .where(
                                                  (element) =>
                                                      element.guid ==
                                                      player.guid,
                                                )
                                                .isEmpty
                                            ? false
                                            : true
                                        : false,
                                    shape: const CircleBorder(),
                                    onChanged: (bool? value) {
                                      if (value!) {
                                        setState(() {
                                          widget.cupController.playerSelected
                                              .add(player);
                                        });
                                      } else {
                                        setState(
                                          () {
                                            widget.cupController.playerSelected
                                                .removeWhere((element) =>
                                                    element.guid ==
                                                    player.guid);
                                          },
                                        );
                                      }
                                    },
                                  ),
                                  title: CardPlayer(
                                    photo: player.photo,
                                    name: player.name.splitConvertName(),
                                    position: player.position.name,
                                    guid: player.guid!,
                                    skillValue: calculeSkill(player.skills),
                                  ),
                                ),
                              );
                            }),
                      ],
                    ).withSymPadding(),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballPulseSync,
                          colors: [AppColor.primaryColor],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
