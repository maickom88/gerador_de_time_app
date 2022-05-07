import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:micro_core/core/theme/app_default.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/components/circle_teams.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';

import '../../../core/colors/colors.dart';
import '../game/game_page.dart';

class ResumeGamePage extends StatefulWidget {
  const ResumeGamePage({Key? key}) : super(key: key);

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
      child: Scaffold(
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
                              text: _showOnlyIcon ? '' : 'Finalizar copinha '),
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
            body: SingleChildScrollView(
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
                        '12, Abril de 2021',
                        style: AppTypography.t16()
                            .copyWith(color: AppColor.textLight),
                      ),
                    ],
                  ).withBottomPadding(),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
                            Text('📣', style: TextStyle(fontSize: 20.0))
                          ]),
                          Column(children: const [
                            Text('🏆', style: TextStyle(fontSize: 20.0))
                          ]),
                          Column(children: const [
                            Text('⚽️', style: TextStyle(fontSize: 20.0))
                          ]),
                          Column(children: const [
                            Text('- ⚽️', style: TextStyle(fontSize: 20.0))
                          ]),
                          Column(children: const [
                            Text('', style: TextStyle(fontSize: 20.0))
                          ]),
                        ]),
                        ...[1, 2, 3]
                            .map(
                              (e) => TableRow(children: [
                                Column(
                                  children: const [
                                    Text('Equipe 1',
                                        style: TextStyle(
                                            color: AppColor.textLight))
                                  ],
                                ),
                                Column(children: const [
                                  Text(
                                    '1',
                                    style: TextStyle(color: AppColor.textLight),
                                  )
                                ]),
                                Column(children: const [
                                  Text('2',
                                      style:
                                          TextStyle(color: AppColor.textLight))
                                ]),
                                Column(children: const [
                                  Text('0',
                                      style:
                                          TextStyle(color: AppColor.textLight))
                                ]),
                                Column(children: [
                                  Transform.scale(
                                    scale: 0.6,
                                    child: const CircleTeams(),
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
                    'Futebol',
                    style: AppTypography.t16(),
                  ).withBottomPadding(),
                  const CardInfoGame(),
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
                    return const InitialGameModal();
                  });
            },
          ),
        ).withSymPadding(),
      ),
    );
  }
}

class CardInfoGame extends StatelessWidget {
  const CardInfoGame({
    Key? key,
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
              const Text(' 🏆', style: TextStyle(fontSize: 20.0))
                  .withRightPadding(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: AppColor.textLight)),
                  ),
                  child: const Text('Total de vitorias',
                      style: TextStyle(color: AppColor.textLight)),
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text(' ⚽️', style: TextStyle(fontSize: 20.0))
                  .withRightPadding(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: AppColor.textLight)),
                  ),
                  child: const Text('Total de gols marcados',
                      style: TextStyle(color: AppColor.textLight)),
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text('-⚽️', style: TextStyle(fontSize: 20.0))
                  .withRightPadding(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: AppColor.textLight)),
                  ),
                  child: const Text('Saldo de gols negativos',
                      style: TextStyle(color: AppColor.textLight)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CardInfoPlay extends StatelessWidget {
  const CardInfoPlay({
    Key? key,
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
                  child: const Text('10 minutos',
                      style: TextStyle(color: AppColor.textLight)),
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
                  child: const Text('2 minutos',
                      style: TextStyle(color: AppColor.textLight)),
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
  const InitialGameModal({
    Key? key,
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
              Row(
                children: [
                  Expanded(
                    child: CarouselSlider.builder(
                      itemCount: 4,
                      itemBuilder: (context, index, pageViewIndex) =>
                          Transform.translate(
                        offset: const Offset(18, 0),
                        child: CardTeam(
                          color: ColorsRadom.colors[index],
                          title: 'Equipe $index',
                        ),
                      ),
                      options: CarouselOptions(
                        height: 150,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        enlargeCenterPage: true,
                        onPageChanged: (page, _) {},
                      ),
                    ).withBottomPadding(),
                  ),
                  Text('X',
                          style: AppTypography.t28WithW800()
                              .copyWith(color: AppColor.textLight))
                      .withLeftPadding()
                      .withRightPadding(),
                  Expanded(
                    child: CarouselSlider.builder(
                      itemCount: 4,
                      itemBuilder: (context, index, pageViewIndex) =>
                          Transform.translate(
                        offset: const Offset(-18, 0),
                        child: CardTeam(
                          color: ColorsRadom.colors[index],
                          title: 'Equipe $index',
                        ),
                      ),
                      options: CarouselOptions(
                        height: 150,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        enlargeCenterPage: true,
                        onPageChanged: (page, _) {},
                      ),
                    ).withBottomPadding(),
                  ),
                ],
              ),
              AppDefault.defaultSpaceHeight(),
              const CardInfoPlay()
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
                AppDefault.navigateToWidget(context, widget: const GamePage());
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
                      AppTypography.t16WithW800().copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          Transform.scale(scale: 0.7, child: const CircleTeams()),
        ],
      ),
    );
  }
}
