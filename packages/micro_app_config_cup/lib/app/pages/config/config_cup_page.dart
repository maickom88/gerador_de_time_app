import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_commons/app/components/circle_teams.dart';
import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/colors/colors.dart';
import '../components/modal_view_card_team.dart';
import '../controllers/cup_config_controller.dart';

class ConfigCupPage extends StatefulWidget {
  final CupConfigController controller;
  const ConfigCupPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _ConfigCupPageState createState() => _ConfigCupPageState();
}

class _ConfigCupPageState extends State<ConfigCupPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
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
                    showAdaptiveActionSheet(
                      context: context,
                      title: const Text('Cancelar esse campeonato?'),
                      actions: <BottomSheetAction>[
                        BottomSheetAction(
                          title: Text('Sim, cancelar',
                              style: AppTypography.t14().copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            AppDefault.close(context);
                            AppDefault.close(context);
                          },
                        ),
                        BottomSheetAction(
                          title: Text(
                            'Continuar sem cancelar',
                            style: AppTypography.t14(),
                          ),
                          onPressed: () => AppDefault.close(context),
                        ),
                      ],
                    );
                  },
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      'Cancelar',
                      style: AppTypography.t16().copyWith(
                        height: 2.0,
                        color: Colors.red[400],
                      ),
                    ),
                  ),
                ),
                largeTitle: Text(
                  'Configurações',
                  style: AppTypography.t28WithW800(),
                ),
                border: Border.all(color: Colors.transparent),
              ),
            ];
          },
          body: SingleChildScrollView(
            clipBehavior: Clip.none,
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Tempo de partida',
                          style: AppTypography.t14()
                              .copyWith(color: AppColor.textLight),
                        ).withRightPadding(),
                        GestureDetector(
                          onTap: () {
                            SystemSound.play(SystemSoundType.click);
                            showCupertinoModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return CounterModal(
                                    totalItens: 30,
                                    onValue: (int minute) {
                                      widget.controller.time.value =
                                          (minute + 1);
                                    },
                                  );
                                });
                          },
                          child: ValueListenableBuilder(
                            valueListenable: widget.controller.time,
                            builder: (context, value, child) {
                              return Container(
                                height: 40,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColor.lightColor,
                                ),
                                child: Center(
                                  child: Text(
                                    '⏱  ${widget.controller.time.value}min',
                                    style: AppTypography.t16()
                                        .copyWith(color: AppColor.textLight),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ).withBottomPadding(bottomPadding: 8),
                    Row(
                      children: [
                        Text(
                          'Habilitar acréscimo\nem caso de empate',
                          style: AppTypography.t14()
                              .copyWith(color: AppColor.textLight),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: widget.controller.isAdditions,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return CupertinoSwitch(
                              value: value,
                              onChanged: (value) =>
                                  widget.controller.isAdditions.value = value,
                            );
                          },
                        )
                      ],
                    ).withBottomPadding(bottomPadding: 8),
                    ValueListenableBuilder<bool>(
                        valueListenable: widget.controller.isAdditions,
                        builder: (context, value, child) {
                          return Visibility(
                            visible: value,
                            child: FadeAnimation(
                              delay: 0.0,
                              child: SizedBox(
                                width: 130,
                                child: GestureDetector(
                                  onTap: () {
                                    SystemSound.play(SystemSoundType.click);
                                    showCupertinoModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CounterModal(
                                            totalItens: 30,
                                            onValue: (int minute) {
                                              widget.controller.timeAdditions
                                                  .value = (minute + 1);
                                            },
                                          );
                                        });
                                  },
                                  child: ValueListenableBuilder<int>(
                                      valueListenable:
                                          widget.controller.timeAdditions,
                                      builder: (context, value, snapshot) {
                                        return Container(
                                          height: 40,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColor.lightColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '⏱  ${widget.controller.timeAdditions.value}min',
                                              style: AppTypography.t16()
                                                  .copyWith(
                                                      color:
                                                          AppColor.textLight),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ).withBottomPadding(),
                            ),
                          );
                        }),
                    Text(
                      '4 Equipes formadas',
                      style: AppTypography.t16WithW800(),
                    ).withBottomPadding(),
                    ValueListenableBuilder(
                      valueListenable: widget.controller,
                      builder: (context, value, child) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 150,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: widget.controller.draw?.teams.length,
                          itemBuilder: (_, index) {
                            final team = widget.controller.draw?.teams[index];
                            return CardTeam(
                              color: team?.color ?? ColorsRadom.colors[index],
                              title: team?.title ?? 'Equipe ${index + 1}',
                              players:
                                  widget.controller.draw?.teams[index].team ??
                                      [],
                              onUpdate: (String title, Color color) {
                                widget.controller.setValueInTeam(index,
                                    title: title, color: color);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ).withBottomPadding(bottomPadding: 60),
              ],
            ).withSymPadding(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(Colors.black),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: AppDefault.defaultBorderRadius(radius: 10),
              ),
            ),
            elevation: MaterialStateProperty.all(3),
            backgroundColor: MaterialStateProperty.all(AppColor.secondaryColor),
          ),
          child: Text(
            'Iniciar copinha',
            style: AppTypography.t16().copyWith(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            AppDefault.navigateTo(context,
                routeName: '/resume-game', withReturn: false);
          },
        ),
      ).withSymPadding(),
    );
  }
}

class CardTeam extends StatelessWidget {
  final Color color;
  final String title;
  final List<PlayerEntity> players;
  final void Function(String title, Color color) onUpdate;
  const CardTeam({
    Key? key,
    required this.color,
    required this.title,
    required this.players,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      constraints: const BoxConstraints(minHeight: 160),
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppDefault.defaultBorderRadius(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      AppTypography.t22WithW800().copyWith(color: Colors.white),
                ),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  showCupertinoModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return ModalViewCardTeam(
                          players: players,
                          nameTeam: title,
                          onSave: (titleUpdate, colorUpdate) {
                            onUpdate(
                                titleUpdate ?? title, colorUpdate ?? color);
                          },
                        );
                      });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.textLight,
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                  child: const Center(
                    child: Icon(
                      Iconsax.edit_2,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          CircleTeams(
            players: players,
          ),
        ],
      ),
    );
  }
}

class CounterModal extends StatelessWidget {
  final int totalItens;
  final Function(int minute) onValue;
  const CounterModal({
    Key? key,
    required this.totalItens,
    required this.onValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: 350,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  SystemSound.play(SystemSoundType.click);
                  AppDefault.close(context);
                },
                child: Text(
                  'Confirmar',
                  style: AppTypography.t16().copyWith(
                    color: AppColor.secondaryColor,
                  ),
                ),
              ).withSymPadding(),
            ),
            Expanded(
              child: CupertinoPicker(
                magnification: 1.5,
                backgroundColor: Colors.white,
                onSelectedItemChanged: (value) => onValue(value),
                itemExtent: 45,
                children: List.generate(
                  totalItens,
                  (index) => Text(
                    (index + 1).toString() + 'min',
                    style: AppTypography.t16(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
