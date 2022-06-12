import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_commons/utils/alert_util.dart';
import 'package:micro_core/core/customs/custum_local_notification.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../components/card_view_team.dart';
import '../components/row_data_table.dart';
import '../components/scoreboard.dart';
import '../controllers/game_controller.dart';

class GamePage extends StatefulWidget {
  final GameController controller;
  const GamePage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
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
    return WillPopScope(
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
                      onTap: () async {
                        await widget.controller.updateMatch(context);
                      },
                      child: Text.rich(
                        TextSpan(
                          style: AppTypography.t16()
                              .copyWith(color: AppColor.secondaryColor),
                          children: [
                            TextSpan(
                                text:
                                    _showOnlyIcon ? '' : 'Finalizar partida '),
                            const WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Iconsax.flag,
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
                    'Jogo',
                    style: AppTypography.t28WithW800(),
                  ),
                  border: Border.all(color: Colors.transparent),
                ),
              ];
            },
            body: SingleChildScrollView(
              clipBehavior: Clip.none,
              physics: const NeverScrollableScrollPhysics(),
              child: ValueListenableBuilder(
                  valueListenable: widget.controller,
                  builder: (context, value, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Scoreboard(
                              color: Color(int.parse(
                                  widget.controller.match.homeTeam.color)),
                              nameTeam: widget.controller.match.homeTeam.name,
                              score: widget.controller.scoreboardHome,
                              onTap: () {
                                showCupertinoModalBottomSheet(
                                  context: context,
                                  builder: (context) => ModalViewCardTeam(
                                    players: widget
                                        .controller.match.homeTeam.players,
                                    onPlayer: (PlayerEntity? player) {
                                      widget.controller.registerGoal(
                                          guidPlayer: player!.guid!,
                                          isHome: true);
                                    },
                                  ),
                                );
                              },
                              onRemoveGoal: () {
                                showCupertinoModalBottomSheet(
                                  context: context,
                                  builder: (context) => ModalViewCardTeam(
                                    title: 'Remover gol',
                                    players: widget
                                        .controller.match.homeTeam.players,
                                    onPlayer: (PlayerEntity? player) async {
                                      final goal = widget.controller.goalsHome
                                          .where((element) =>
                                              element.player.guid ==
                                              player!.guid)
                                          .toList();

                                      if (goal.isNotEmpty) {
                                        widget.controller.removerGoal(
                                          context,
                                          guidPlayer: player!.guid!,
                                          goal: goal.first,
                                          isHome: true,
                                        );
                                      } else {
                                        showAlert(context,
                                            'O jogador selecionado não possui gol marcado');
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                            Text(
                              'X',
                              style: AppTypography.t28WithW800()
                                  .copyWith(color: AppColor.textLight),
                            ).withSymPadding(),
                            Scoreboard(
                              color: Color(int.parse(
                                  widget.controller.match.opposingTeam.color)),
                              nameTeam:
                                  widget.controller.match.opposingTeam.name,
                              score: widget.controller.scoreboardOpposing,
                              onTap: () {
                                showCupertinoModalBottomSheet(
                                  context: context,
                                  builder: (context) => ModalViewCardTeam(
                                    title: 'Remover gol',
                                    players: widget
                                        .controller.match.opposingTeam.players,
                                    onPlayer: (PlayerEntity? player) {
                                      widget.controller.registerGoal(
                                          guidPlayer: player!.guid!,
                                          isHome: false);
                                    },
                                  ),
                                );
                              },
                              onRemoveGoal: () {
                                showCupertinoModalBottomSheet(
                                  context: context,
                                  builder: (context) => ModalViewCardTeam(
                                    title: 'Remover gol',
                                    players: widget
                                        .controller.match.opposingTeam.players,
                                    onPlayer: (PlayerEntity? player) async {
                                      final goal = widget
                                          .controller.goalsOpposing
                                          .where((element) =>
                                              element.player.guid ==
                                              player!.guid)
                                          .toList();

                                      if (goal.isNotEmpty) {
                                        await widget.controller.removerGoal(
                                          context,
                                          guidPlayer: player!.guid!,
                                          goal: goal.first,
                                          isHome: false,
                                        );
                                      } else {
                                        showAlert(context,
                                            'O jogador selecionado não possui gol marcado');
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        AppDefault.defaultSpaceHeight(),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: widget
                                      .controller.match.homeTeam.players
                                      .map(
                                        (player) => RowDataTable(
                                          avatar: player.photo,
                                          name: player.name,
                                          // icon: '🥅',
                                          goal: widget.controller.goalsHome
                                              .where((e) =>
                                                  e.player.guid == player.guid)
                                              .toList()
                                              .length,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      width: 1,
                                      color: Color(0xffe8e8e8),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: widget
                                      .controller.match.opposingTeam.players
                                      .map(
                                        (player) => RowDataTable(
                                          avatar: player.photo,
                                          name: player.name,
                                          // icon: '🥅',
                                          goal: widget.controller.goalsOpposing
                                              .where((e) =>
                                                  e.player.guid == player.guid)
                                              .toList()
                                              .length,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).withSymPadding();
                  }),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ValueListenableBuilder(
            valueListenable: widget.controller,
            builder: (context, value, child) {
              return Container(
                width: double.infinity,
                height: 180,
                decoration: const BoxDecoration(
                  color: AppColor.lightColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: CountDownProgressIndicator(
                              controller: widget.controller.countdownController,
                              strokeWidth: 6,
                              timeFormatter: (value) {
                                widget.controller.time = value;

                                return Duration(seconds: value)
                                    .toHoursMinutesSeconds(
                                        showAdditions:
                                            widget.controller.showAdditions);
                              },
                              autostart: false,
                              timeTextStyle: TextStyle(
                                  color: AppColor.textLight,
                                  fontSize: widget.controller.showAdditions
                                      ? 14
                                      : 16),
                              valueColor: AppColor.textTitle,
                              backgroundColor: AppColor.textLight,
                              initialPosition: 0,
                              duration: Duration(
                                      minutes: widget.controller.match.time)
                                  .inSeconds,
                              onComplete: () async {
                                if (widget.controller.timeAdditions == null ||
                                    widget.controller.scoreboardHome !=
                                        widget.controller.scoreboardOpposing) {
                                  HapticFeedback.vibrate();
                                  await CustumLocalNotification.instance
                                      .showLocalNotification(
                                    id: widget.hashCode,
                                    withCustumSound: true,
                                    title: "📣  Apita final de jogo",
                                    description:
                                        "O tempo do jogo acabou, finalize a partida!",
                                  );
                                  return;
                                }
                                widget.controller.isPlay = false;
                                widget.controller.isPause = true;
                                widget.controller.countdownController.restart(
                                  duration: Duration(
                                          minutes:
                                              widget.controller.timeAdditions!)
                                      .inSeconds,
                                  initialPosition: 0,
                                );
                                widget.controller.timeAdditions = null;
                                widget.controller.showAdditions = true;
                              },
                            ),
                          ),
                        ).withBottomPadding(),
                        Row(
                          children: [
                            Visibility(
                              child: Visibility(
                                replacement: SizedBox(
                                  width: 100,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        widget.controller.isPause = true;
                                        widget.controller.countdownController
                                            .resume();
                                      },
                                      child: Text(
                                        'Play',
                                        textAlign: TextAlign.center,
                                        style: AppTypography.t16().copyWith(
                                            color: AppColor.secondaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                                visible: widget.controller.isPause,
                                child: SizedBox(
                                  width: 100,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        widget.controller.isPause = false;
                                        widget.controller.countdownController
                                            .pause();
                                      },
                                      child: Text(
                                        'Pause',
                                        style: AppTypography.t16().copyWith(
                                            color: AppColor.textLight),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 100,
                              child: GestureDetector(
                                onTap: () {
                                  widget.controller.isPlay = false;
                                  widget.controller.isPause = true;
                                  widget.controller.countdownController.restart(
                                    duration: Duration(
                                            minutes:
                                                widget.controller.match.time)
                                        .inSeconds,
                                    initialPosition: 0,
                                  );
                                },
                                child: Text(
                                  'Reiniciar',
                                  style: AppTypography.t16()
                                      .copyWith(color: Colors.red[400]),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ).withSymPadding(),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

extension DurationExtensions on Duration {
  String toHoursMinutes() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    return "${_toTwoDigits(inHours)}:$twoDigitMinutes";
  }

  String toHoursMinutesSeconds({required bool showAdditions}) {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = _toTwoDigits(inSeconds.remainder(60));
    if (inHours > 0) {
      if (showAdditions) {
        return " 00:00\n+${_toTwoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds";
      }
      return "${_toTwoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    if (showAdditions) {
      return " 00:00\n+$twoDigitMinutes:$twoDigitSeconds";
    }
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  String _toTwoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
}
