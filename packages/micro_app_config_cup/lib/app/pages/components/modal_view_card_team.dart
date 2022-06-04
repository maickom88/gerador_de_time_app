import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_commons/app/components/card_player_show_info.dart';
import 'package:micro_commons/app/domain/entities/player_entity.dart';
import 'package:micro_commons/app/domain/entities/skill_entity.dart';
import 'package:micro_core/core/theme/theme.dart';

class ModalViewCardTeam extends StatefulWidget {
  final String nameTeam;
  final List<PlayerEntity> players;
  final void Function(String? title, Color? color) onSave;
  const ModalViewCardTeam({
    Key? key,
    required this.nameTeam,
    required this.players,
    required this.onSave,
  }) : super(key: key);

  @override
  State<ModalViewCardTeam> createState() => _ModalViewCardTeamState();
}

class _ModalViewCardTeamState extends State<ModalViewCardTeam> {
  late TextEditingController textEditingController;
  Color? colorSelected;
  int? calculeSkill(SkillEntity skill) {
    int maxSkill = 0;
    maxSkill =
        skill.completion + skill.dribble + skill.strength + skill.velocity;
    return maxSkill ~/ 4;
  }

  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.nameTeam);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      color: Colors.transparent,
      child: Container(
        height: AppDefault.height(context).percent(55),
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
                      'Editar time',
                      style: AppTypography.t16().copyWith(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        SystemSound.play(SystemSoundType.click);
                        widget.onSave(
                            textEditingController.text, colorSelected);
                        AppDefault.close(context);
                      },
                      child: Text(
                        'Salvar',
                        style: AppTypography.t16().copyWith(
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ).withBottomPadding(),
              AppDefault.defaultSpaceHeight(),
              TextFormField(
                controller: textEditingController,
                style: AppTypography.t16(fontName: 'Inter')
                    .copyWith(color: AppColor.textTitle),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  fillColor: AppColor.lightColor,
                ),
              ).withBottomPadding(),
              Text('Uniforme', style: AppTypography.t16WithW800())
                  .withBottomPadding(),
              ColorsWidget(
                onColor: (Color color) {
                  colorSelected = color;
                },
              ),
              AppDefault.defaultSpaceHeight(),
              Text('Jogadores', style: AppTypography.t16WithW800())
                  .withBottomPadding(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: widget.players
                      .map<Widget>((player) => CardPlayerShowInfo(
                            photo: player.photo,
                            name: player.name.splitConvertName(),
                            position: player.position.name,
                            guid: player.guid!,
                            skillValue: calculeSkill(player.skills),
                          ))
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

class ColorsWidget extends StatefulWidget {
  final Function(Color color) onColor;
  const ColorsWidget({
    Key? key,
    required this.onColor,
  }) : super(key: key);

  @override
  State<ColorsWidget> createState() => _ColorsWidgetState();
}

class _ColorsWidgetState extends State<ColorsWidget> {
  late bool isSelect;
  int? indexSelected;
  @override
  void initState() {
    isSelect = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ListView.builder(
        itemCount: Colors.primaries.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CardColor(
            color: Colors.primaries[index],
            onSelect: (bool value) {
              setState(() {
                isSelect = value;
                indexSelected = index;
                widget.onColor(Colors.primaries[index]);
              });
            },
            isSelected: indexSelected == index ? isSelect : false,
          );
        },
      ),
    );
  }
}

class CardColor extends StatefulWidget {
  final Color color;
  final bool isSelected;
  final Function(bool value) onSelect;
  const CardColor({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<CardColor> createState() => _CardColorState();
}

class _CardColorState extends State<CardColor> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: () {
          widget.onSelect(!widget.isSelected);
        },
        child: AnimatedContainer(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(
                width: widget.isSelected ? 3 : 0, color: Colors.black87),
            borderRadius: BorderRadius.circular(8),
            color: widget.color,
          ),
          duration: const Duration(milliseconds: 250),
          curve: Curves.linear,
        ),
      ),
    );
  }
}
