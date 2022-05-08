import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../components/scoreboard.dart';
import '../components/row_data_table.dart';
import '../components/card_view_team.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

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
    final countdownController = CountDownController();
    return Scaffold(
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
                  child: Text.rich(
                    TextSpan(
                      style: AppTypography.t16()
                          .copyWith(color: AppColor.secondaryColor),
                      children: [
                        TextSpan(
                            text: _showOnlyIcon ? '' : 'Finalizar partida '),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Scoreboard(
                      color: Colors.red,
                      nameTeam: 'Equipe 1',
                      score: 2,
                      onTap: () {
                        showCupertinoModalBottomSheet(
                          context: context,
                          builder: (context) => const ModalViewCardTeam(),
                        );
                      },
                    ),
                    Text(
                      'X',
                      style: AppTypography.t28WithW800()
                          .copyWith(color: AppColor.textLight),
                    ).withSymPadding(),
                    Scoreboard(
                      color: Colors.blue,
                      nameTeam: 'Equipe 2',
                      score: 3,
                      onTap: () {
                        showCupertinoModalBottomSheet(
                          context: context,
                          builder: (context) => const ModalViewCardTeam(),
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
                            children: const [
                              RowDataTable(
                                avatar:
                                    'https://cdn.pixabay.com/photo/2016/03/26/22/13/man-1281562_960_720.jpg',
                                name: 'Rodrigues F.',
                                icon: '🥅',
                              ),
                              RowDataTable(
                                avatar:
                                    'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
                                name: 'Weverton Marcio de Sá',
                              ),
                            ]),
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
                            children: const [
                              RowDataTable(
                                avatar:
                                    'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
                                name: 'Marcos F.',
                                icon: '🥅',
                              ),
                              RowDataTable(
                                avatar:
                                    'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
                                name: 'Fernando F.',
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ).withSymPadding(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: double.infinity,
        height: 180,
        decoration: const BoxDecoration(
          color: AppColor.lightColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: CountDownProgressIndicator(
                controller: countdownController,
                strokeWidth: 6,
                autostart: false,
                timeTextStyle:
                    const TextStyle(color: AppColor.textLight, fontSize: 17),
                valueColor: AppColor.textTitle,
                backgroundColor: AppColor.textLight,
                initialPosition: 0,
                duration: 120,
                onComplete: () => null,
              ),
            ).withBottomPadding(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 65,
                  child: GestureDetector(
                    onTap: () {
                      countdownController.start();
                    },
                    child: Text(
                      'Iniciar',
                      style: AppTypography.t16()
                          .copyWith(color: AppColor.secondaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: GestureDetector(
                    onTap: () {
                      countdownController.pause();
                    },
                    child: Text(
                      'Pause',
                      style: AppTypography.t16()
                          .copyWith(color: AppColor.textLight),
                    ),
                  ),
                ),
                SizedBox(
                  width: 65,
                  child: GestureDetector(
                    onTap: () {
                      countdownController.restart(initialPosition: 0);
                    },
                    child: Text(
                      'Reiniciar',
                      style:
                          AppTypography.t16().copyWith(color: Colors.red[400]),
                    ),
                  ),
                ),
              ],
            )
          ],
        ).withSymPadding(),
      ),
    );
  }
}
