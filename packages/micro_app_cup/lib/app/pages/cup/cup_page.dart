import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:micro_commons/app/components/card_player.dart';
import 'package:micro_commons/app/components/error_page.dart';
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
  late List<Map> listChecked;
  late Tween<double> tween;
  @override
  void initState() {
    listChecked = [];
    isEditing = false;
    tween = Tween<double>(begin: 0.0, end: 5.0);

    super.initState();
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
                trailing: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                  },
                  child: const Icon(
                    Iconsax.edit,
                    color: AppColor.secondaryColor,
                    size: 25,
                  ),
                ),
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
                  return SingleChildScrollView(
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
                                    CupertinoSwitch(
                                      value: false,
                                      onChanged: (value) {},
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
                                                child: CupertinoPicker(
                                                  magnification: 1.5,
                                                  backgroundColor: Colors.white,
                                                  onSelectedItemChanged:
                                                      (value) {
                                                    setState(() {});
                                                  },
                                                  itemExtent: 45,
                                                  children: List.generate(
                                                    10,
                                                    (index) => Text(
                                                      (index + 1).toString(),
                                                      style:
                                                          AppTypography.t16(),
                                                    ),
                                                  ),
                                                ),
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
                                            '0',
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
                                AppDefault.navigateTo(
                                  context,
                                  routeName: '/config',
                                );
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
                        listChecked.isEmpty
                            ? Text(
                                'Marque os jogadores para a copinha',
                                style: AppTypography.t14()
                                    .copyWith(color: AppColor.textLight),
                              )
                            : listChecked.length == 1
                                ? Text('1 jogador marcado',
                                    style: AppTypography.t14()
                                        .copyWith(color: AppColor.textLight))
                                : Text(
                                    '${listChecked.length} jogadores marcados',
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
