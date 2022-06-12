import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:micro_commons/app/components/circle_teams.dart';
import 'package:micro_commons/app/components/error_page.dart';
import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_commons/utils/alert_util.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../components/card_info.dart';
import '../controllers/resume_game_controller.dart';
import '../states/resume_state.dart';

class ResumeGamePage extends StatefulWidget {
  final ResumeController controller;
  const ResumeGamePage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _ResumeGamePageState createState() => _ResumeGamePageState();
}

class _ResumeGamePageState extends State<ResumeGamePage> {
  late ScrollController _controller;
  late bool _showOnlyIcon;
  @override
  void initState() {
    _showOnlyIcon = false;
    _controller = ScrollController();
    super.initState();
    _controller.addListener(() {
      _showOnlyIcon = _controller.position.pixels >= 60;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: WillPopScope(
        onWillPop: () async {
          bool isBack = false;
          SystemSound.play(SystemSoundType.click);
          await showAdaptiveActionSheet(
            context: context,
            title: const Text('Cancelar esse campeonato?'),
            actions: <BottomSheetAction>[
              BottomSheetAction(
                title: Text('Sim, cancelar',
                    style: AppTypography.t14().copyWith(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                onPressed: () {
                  isBack = true;
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
          return isBack;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: NestedScrollView(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (_, inner) {
                return <Widget>[
                  const SliverToBoxAdapter(
                      child: SizedBox(
                    height: 20,
                  )),
                  CupertinoSliverNavigationBar(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    trailing: Material(
                      type: MaterialType.transparency,
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () => widget.controller.finishCup(context),
                        child: Text.rich(
                          TextSpan(
                            style: AppTypography.t16()
                                .copyWith(color: AppColor.secondaryColor),
                            children: [
                              TextSpan(
                                  text: _showOnlyIcon
                                      ? ''
                                      : 'Finalizar copinha '),
                              const WidgetSpan(
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
                    ),
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
                        color: Colors.transparent,
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
                      'Copinha',
                      style: AppTypography.t28WithW800(),
                    ),
                    border: Border.all(color: Colors.transparent),
                  ),
                ];
              },
              body: ValueListenableBuilder<ResumeState>(
                  valueListenable: widget.controller,
                  builder: (context, value, child) {
                    if (value is ResumeErrorState) {
                      return ErrorComponent(
                        onLoad: () => widget.controller.initializeCup(),
                      );
                    }
                    if (value is ResumeSuccessState) {
                      return SingleChildScrollView(
                        clipBehavior: Clip.none,
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Futebol',
                                  style: AppTypography.t16(),
                                ),
                                Text(
                                  value.cup.date.formateDateString(),
                                  style: AppTypography.t16()
                                      .copyWith(color: AppColor.textLight),
                                ),
                              ],
                            ).withBottomPadding(),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.lightColor,
                              ),
                              child: Table(
                                // defaultColumnWidth: const FixedColumnWidth(120.0),
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                border: TableBorder.symmetric(
                                  inside: BorderSide(
                                    color: Colors.grey.withOpacity(0.1),
                                    width: 1,
                                  ),
                                ),
                                children: [
                                  TableRow(children: [
                                    Column(children: const [
                                      Text('📣',
                                          style: TextStyle(fontSize: 20.0))
                                    ]),
                                    Column(children: const [
                                      Text('🏆',
                                          style: TextStyle(fontSize: 20.0))
                                    ]),
                                    Column(children: const [
                                      Text('⚽️',
                                          style: TextStyle(fontSize: 20.0))
                                    ]),
                                    Column(children: const [
                                      Text('- ⚽️',
                                          style: TextStyle(fontSize: 20.0))
                                    ]),
                                    Column(children: const [
                                      Text('', style: TextStyle(fontSize: 20.0))
                                    ]),
                                  ]),
                                  ...value.cup.teams
                                      .map(
                                        (team) => TableRow(children: [
                                          Column(
                                            children: [
                                              Text(team.name,
                                                  style: const TextStyle(
                                                      color:
                                                          AppColor.textLight))
                                            ],
                                          ),
                                          Column(children: [
                                            Text(
                                              team.victories.toString(),
                                              style: const TextStyle(
                                                  color: AppColor.textLight),
                                            )
                                          ]),
                                          Column(children: [
                                            Text(team.goals.toString(),
                                                style: const TextStyle(
                                                    color: AppColor.textLight))
                                          ]),
                                          Column(children: [
                                            Text(team.goalsNegative.toString(),
                                                style: const TextStyle(
                                                    color: AppColor.textLight))
                                          ]),
                                          Column(children: [
                                            Transform.scale(
                                              scale: 0.9,
                                              child: CircleTeams(
                                                players: team.players,
                                                isTable: true,
                                              ),
                                            ),
                                          ]),
                                        ]),
                                      )
                                      .toList()
                                ],
                              ),
                            ),
                            AppDefault.defaultSpaceHeight(height: 40),
                            Text(
                              'Informações',
                              style: AppTypography.t16(),
                            ).withBottomPadding(),
                            const CardInfoGame(),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
                backgroundColor:
                    MaterialStateProperty.all(AppColor.secondaryColor),
              ),
              child: Text(
                'Iniciar partida',
                style: AppTypography.t16().copyWith(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                showCupertinoModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return InitialGameModal(controller: widget.controller);
                    });
              },
            ),
          ).withSymPadding(),
        ),
      ),
    );
  }
}

class CardInfoPlay extends StatelessWidget {
  final int time;
  final int timeAddition;
  const CardInfoPlay({
    Key? key,
    required this.time,
    this.timeAddition = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.lightColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(' ⏱', style: TextStyle(fontSize: 20.0))
                  .withRightPadding(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: AppColor.textLight)),
                  ),
                  child: Text('$time minutos',
                      style: const TextStyle(color: AppColor.textLight)),
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text('+⚽️', style: TextStyle(fontSize: 20.0))
                  .withRightPadding(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: AppColor.textLight)),
                  ),
                  child: Text('$timeAddition minutos',
                      style: const TextStyle(color: AppColor.textLight)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class InitialGameModal extends StatelessWidget {
  final ResumeController controller;
  const InitialGameModal({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      color: Colors.transparent,
      child: SizedBox(
        height: AppDefault.height(context).percent(60),
        child: Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        SystemSound.play(SystemSoundType.click);
                        AppDefault.close(context);
                      },
                      child: Text(
                        'Cancelar',
                        style: AppTypography.t16().copyWith(
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Escolha as equipes',
                      style: AppTypography.t16().copyWith(),
                    ),
                  ),
                ],
              ).withBottomPadding(),
              AppDefault.defaultSpaceHeight(),
              ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (context, value, child) {
                    return Row(
                      children: [
                        Expanded(
                          child: CarouselSlider.builder(
                            carouselController:
                                controller.carouselControllerLeft,
                            itemCount: controller.teamsLeft.length,
                            itemBuilder: (context, index, pageViewIndex) =>
                                Transform.translate(
                              offset: const Offset(18, 0),
                              child: CardTeam(
                                color: Color(int.parse(
                                    controller.teamsLeft[index]!.color)),
                                title: controller.teamsLeft[index]!.name,
                                players: controller.teamsLeft[index]!.players,
                              ),
                            ),
                            options: CarouselOptions(
                              height: 150,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll:
                                  controller.teamsLeft.length > 1,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              enlargeCenterPage: true,
                              onPageChanged: (page, _) {
                                controller
                                    .onEventLeft(controller.teamsLeft[page]!);
                              },
                            ),
                          ).withBottomPadding(),
                        ),
                        Text('X',
                                style: AppTypography.t28WithW800()
                                    .copyWith(color: AppColor.textLight))
                            .withLeftPadding()
                            .withRightPadding(),
                        ValueListenableBuilder(
                            valueListenable: controller,
                            builder: (context, value, child) {
                              return Expanded(
                                child: CarouselSlider.builder(
                                  carouselController:
                                      controller.carouselControllerRight,
                                  itemCount: controller.teamsRight.length,
                                  itemBuilder:
                                      (context, index, pageViewIndex) =>
                                          Transform.translate(
                                    offset: const Offset(-18, 0),
                                    child: CardTeam(
                                      color: Color(int.parse(
                                          controller.teamsRight[index]!.color)),
                                      title: controller.teamsRight[index]!.name,
                                      players:
                                          controller.teamsRight[index]!.players,
                                    ),
                                  ),
                                  options: CarouselOptions(
                                      height: 150,
                                      viewportFraction: 0.8,
                                      initialPage: 0,
                                      enableInfiniteScroll:
                                          controller.teamsRight.length > 1,
                                      enlargeStrategy:
                                          CenterPageEnlargeStrategy.height,
                                      enlargeCenterPage: true,
                                      onPageChanged: (page, _) {
                                        controller.onEventRight(
                                            controller.teamsRight[page]!);
                                      }),
                                ).withBottomPadding(),
                              );
                            }),
                      ],
                    );
                  }),
              AppDefault.defaultSpaceHeight(),
              CardInfoPlay(
                time: controller.configCup.time,
                timeAddition: controller.configCup.timeAdditions ?? 0,
              )
            ],
          ).withSymPadding(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
                backgroundColor:
                    MaterialStateProperty.all(AppColor.secondaryColor),
              ),
              child: Text(
                'Começar',
                style: AppTypography.t16().copyWith(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                if (controller.teamLeft.guid == controller.teamRight.guid) {
                  showAlert(context, "Selecione um time adversario");
                  return;
                }
                controller.initializeMatch(context);
              },
            ),
          ).withSymPadding(),
        ),
      ),
    );
  }
}

class CardTeam extends StatelessWidget {
  final Color color;
  final String title;
  final List<PlayerEntity> players;
  const CardTeam({
    Key? key,
    required this.color,
    required this.title,
    required this.players,
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
                      AppTypography.t16WithW800().copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          Transform.scale(
            scale: 0.7,
            child: CircleTeams(
              players: players,
              firstPositionRight: 60,
              secondPositionRight: 40,
            ),
          ),
        ],
      ),
    );
  }
}
