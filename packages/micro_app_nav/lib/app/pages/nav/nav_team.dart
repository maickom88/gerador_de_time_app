import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_commons/app/components/card_player.dart';
import 'package:micro_commons/app/components/empty_data.dart';
import 'package:micro_commons/app/components/error_page.dart';
import 'package:micro_commons/app/components/loading_sport.dart';
import 'package:micro_commons/app/domain/entities/user_entity.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../domain/usecases/save_player_usecase.dart';
import '../components/modal_bottom_error.dart';
import '../components/modal_bottom_sheet_add_player.dart';
import '../controllers/position_controller.dart';
import '../controllers/team_controller.dart';
import '../states/team_state.dart';

class NavTeam extends StatefulWidget {
  final TeamController teamController;
  final PositionController positionController;
  const NavTeam({
    Key? key,
    required this.teamController,
    required this.positionController,
  }) : super(key: key);

  @override
  _NavTeamState createState() => _NavTeamState();
}

class _NavTeamState extends State<NavTeam> {
  late bool isEditing;
  @override
  void initState() {
    isEditing = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<TeamState>(
          valueListenable: widget.teamController,
          builder: (context, value, child) {
            if (value is TeamErrorState) {
              return ErrorComponent(
                onLoad: () => widget.teamController.getPlayers(),
              );
            }
            if (value is TeamSuccessState) {
              return NestedScrollView(
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
                        onTap: () async {
                          HapticFeedback.lightImpact();
                          if (widget.teamController.userEntity?.role ==
                              RoleEnum.free) {
                            if (value.players.length >= 25) {
                              AppDefault.navigateTo(context,
                                  routeName: '/subscription');
                              return;
                            }
                          }
                          await showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => ModelBottomAddPlayer(
                              positionController: widget.positionController,
                              onSave: (name, photo, guidPosition, skill) async {
                                AppDefault.showDefaultLoad(
                                  context,
                                  const LoadingSport(
                                    message: 'Salvando jogador...',
                                  ),
                                );
                                final resultSaveSkill = await widget
                                    .teamController
                                    .saveSkill(skill);
                                if (resultSaveSkill) {
                                  final params = SavePlayerParams(
                                    name: name,
                                    photo: photo,
                                    guidPosition: guidPosition,
                                    guidSkill:
                                        widget.teamController.skill?.guid,
                                    userGuid:
                                        widget.teamController.userEntity!.guid,
                                  );
                                  final result = await widget.teamController
                                      .savePLayer(params);
                                  AppDefault.close(context);
                                  if (result) {
                                    AppDefault.close(context);
                                  } else {
                                    showCupertinoModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          const ModelBottomError(
                                        description:
                                            'Encontramos um error\nao tentar salvar um jogador',
                                      ),
                                    );
                                  }
                                } else {
                                  AppDefault.close(context);
                                  showCupertinoModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        const ModelBottomError(
                                      description:
                                          'Encontramos um error\nao tentar salvar um jogador',
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                          widget.positionController.name = null;
                          widget.positionController.positionEntity = null;
                          widget.positionController.skillEntity = null;
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

                                  widget.teamController.playerSelected = [];
                                });
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              },
                              child: FadeAnimation(
                                delay: 0,
                                directionType: DirectionType.translateX,
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
                                          backgroundColor:
                                              AppColor.secondaryColor,
                                          duration: const Duration(days: 365),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Icon(Iconsax.trash4,
                                                  color: Colors.white),
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: () async {
                                                  SystemSound.play(
                                                      SystemSoundType.click);
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                  setState(() {
                                                    isEditing = !isEditing;
                                                  });
                                                  AppDefault.showDefaultLoad(
                                                    context,
                                                    const LoadingSport(
                                                      message:
                                                          'Removendo jogador...',
                                                    ),
                                                  );
                                                  final result = await widget
                                                      .teamController
                                                      .removePLayers();
                                                  AppDefault.close(context);
                                                  if (!result) {
                                                    showCupertinoModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          const ModelBottomError(
                                                        description:
                                                            'Encontramos um error\nao tentar remover jogadores',
                                                      ),
                                                    );
                                                  }
                                                  setState(() {
                                                    widget.teamController
                                                        .playerSelected = [];
                                                  });
                                                },
                                                child: const Text(
                                                    'Excluir marcados'),
                                              ).withRightPadding(),
                                              GestureDetector(
                                                onTap: () async {
                                                  HapticFeedback.lightImpact();
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                  AppDefault.showDefaultLoad(
                                                    context,
                                                    const LoadingSport(
                                                      message:
                                                          'Removendo jogador...',
                                                    ),
                                                  );
                                                  final result = await widget
                                                      .teamController
                                                      .removePLayers();
                                                  AppDefault.close(context);
                                                  if (!result) {
                                                    showCupertinoModalBottomSheet(
                                                      context: context,
                                                      builder: (context) =>
                                                          const ModelBottomError(
                                                        description:
                                                            'Encontramos um error\nao tentar remover jogadores',
                                                      ),
                                                    );
                                                  }
                                                  setState(() {
                                                    widget.teamController
                                                        .playerSelected = [];
                                                    isEditing = !isEditing;
                                                  });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: Colors.red[300]),
                                                  child: const Text(
                                                      'Excluir todos'),
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
                                type: MaterialType.transparency,
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
                          onChanged: (value) {
                            widget.teamController.searchPlayer(value);
                          },
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
                      Visibility(
                        replacement: const FadeAnimation(
                          delay: 0.1,
                          child: WidgetEmptyData(
                            description:
                                'Adicione os jogadores no ícone acima para iniciar uma copinha.',
                            title: 'Lista de jogadores vazia',
                          ),
                        ),
                        visible: value.players.isNotEmpty,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.teamController.searchResultPlayer
                                    .isNotEmpty
                                ? widget
                                    .teamController.searchResultPlayer.length
                                : value.players.length,
                            itemBuilder: (_, index) {
                              final player = widget.teamController
                                      .searchResultPlayer.isNotEmpty
                                  ? widget
                                      .teamController.searchResultPlayer[index]
                                  : value.players[index];
                              return FadeAnimation(
                                delay: (1.0 + index) / 4,
                                child: ListTile(
                                  leading: isEditing
                                      ? FadeAnimation(
                                          delay: 0,
                                          directionType:
                                              DirectionType.translateX,
                                          child: Checkbox(
                                            checkColor: Colors.white,
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    AppColor.secondaryColor),
                                            value: widget.teamController
                                                    .playerSelected.isNotEmpty
                                                ? widget.teamController
                                                        .playerSelected
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
                                                  widget.teamController
                                                      .playerSelected
                                                      .add(player);
                                                });
                                              } else {
                                                setState(
                                                  () {
                                                    widget.teamController
                                                        .playerSelected
                                                        .removeWhere(
                                                            (element) =>
                                                                element.guid ==
                                                                player.guid);
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                        )
                                      : null,
                                  title: CardPlayer(
                                    photo: player.photo,
                                    name: player.name.splitConvertName(),
                                    position: player.position.name,
                                    guid: player.guid!,
                                    skillValue: widget.positionController
                                        .calculeSkill(player.skills),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ).withSymPadding(),
                ),
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
    );
  }
}
