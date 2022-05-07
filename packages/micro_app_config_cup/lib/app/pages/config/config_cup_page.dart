import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/components/circle_teams.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../components/modal_view_card_team.dart';
import '../../../core/colors/colors.dart';

class ConfigCupPage extends StatefulWidget {
  const ConfigCupPage({Key? key}) : super(key: key);

  @override
  _ConfigCupPageState createState() => _ConfigCupPageState();
}

class _ConfigCupPageState extends State<ConfigCupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                backgroundColor: Colors.transparent,
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
                                      setState(() {});
                                    },
                                  );
                                });
                          },
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.lightColor,
                            ),
                            child: Center(
                              child: Text(
                                '⏱  0min',
                                style: AppTypography.t16()
                                    .copyWith(color: AppColor.textLight),
                              ),
                            ),
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
                        CupertinoSwitch(
                          value: false,
                          onChanged: (value) {},
                        )
                      ],
                    ).withBottomPadding(bottomPadding: 8),
                    SizedBox(
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
                                    setState(() {});
                                  },
                                );
                              });
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColor.lightColor,
                          ),
                          child: Center(
                            child: Text(
                              '⏱  0min',
                              style: AppTypography.t16()
                                  .copyWith(color: AppColor.textLight),
                            ),
                          ),
                        ),
                      ),
                    ).withBottomPadding(),
                    Text(
                      '4 Equipes formadas',
                      style: AppTypography.t16WithW800(),
                    ).withBottomPadding(),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 150,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: 4,
                      itemBuilder: (_, index) {
                        return CardTeam(
                          color: ColorsRadom.colors[index],
                          title: 'Equipe $index',
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
  const CardTeam({
    Key? key,
    required this.color,
    required this.title,
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
                        return const ModalViewCardTeam();
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
          const CircleTeams(),
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
