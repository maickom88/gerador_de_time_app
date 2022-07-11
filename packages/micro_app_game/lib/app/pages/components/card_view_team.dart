import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_commons/app/domain/entities/skill_entity.dart';
import 'package:micro_commons/utils/alert_util.dart';
import 'package:micro_core/core/theme/theme.dart';

import 'card_player.dart';

class ModalViewCardTeam extends StatefulWidget {
  final List<PlayerEntity> players;
  final String title;
  final Function(PlayerEntity? player) onPlayer;
  const ModalViewCardTeam({
    Key? key,
    required this.players,
    required this.onPlayer,
    this.title = 'Registrar gol',
  }) : super(key: key);

  @override
  State<ModalViewCardTeam> createState() => _ModalViewCardTeamState();
}

class _ModalViewCardTeamState extends State<ModalViewCardTeam> {
  PlayerEntity? playersSelect;

  int? calculeSkill(SkillEntity skill) {
    int maxSkill = 0;
    maxSkill =
        skill.completion + skill.dribble + skill.strength + skill.velocity;
    return maxSkill ~/ 4;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      color: Colors.white,
      child: Container(
        height: 360,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      widget.title,
                      style: AppTypography.t16().copyWith(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        SystemSound.play(SystemSoundType.click);
                        if (playersSelect == null) {
                          showAlert(
                              context, 'Selecione o jogador que fez o gol');
                          return;
                        }
                        widget.onPlayer(playersSelect);
                        AppDefault.close(context);
                      },
                      child: Text(
                        'Pronto',
                        style: AppTypography.t16().copyWith(
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ).withBottomPadding(),
              AppDefault.defaultSpaceHeight(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: widget.players
                      .map(
                        (player) => CardPlayer(
                          name: player.name,
                          photo: player.photo,
                          position: player.position.name,
                          guid: player.guid!,
                          skillValue: calculeSkill(player.skills),
                          isSelect: (bool value) {
                            setState(() {
                              if (value) {
                                playersSelect = player;
                              } else {
                                playersSelect = null;
                              }
                            });
                          },
                          select: player.guid == playersSelect?.guid,
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ColorsWidget extends StatelessWidget {
  const ColorsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
