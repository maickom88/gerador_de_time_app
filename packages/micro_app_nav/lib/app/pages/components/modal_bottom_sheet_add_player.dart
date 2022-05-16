import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/utils/theme.dart';
import '../../domain/entities/skill_entity.dart';
import '../components/page_search_position.dart';
import '../controllers/position_controller.dart';
import 'page_search_position.dart';
import 'skill_component.dart';

class ModelBottomAddPlayer extends StatefulWidget {
  final PositionController positionController;
  final Function(String name, String guidPosition, SkillEntity skill) onSave;
  const ModelBottomAddPlayer({
    Key? key,
    required this.positionController,
    required this.onSave,
  }) : super(key: key);

  @override
  State<ModelBottomAddPlayer> createState() => _ModelBottomAddPlayerState();
}

class _ModelBottomAddPlayerState extends State<ModelBottomAddPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        height: AppDefault.height(context).percent(80),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
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
                  Text(
                    'Adicionar jogador',
                    style: AppTypography.t16().copyWith(),
                  ),
                  GestureDetector(
                    onTap: () {
                      final skill = SkillEntity(
                        strength: widget.positionController.strength ?? 0,
                        velocity: widget.positionController.velocity ?? 0,
                        completion: widget.positionController.completion ?? 0,
                        dribble: widget.positionController.dribble ?? 0,
                      );
                      if (widget.positionController.name == null ||
                          widget.positionController.name?.isEmpty == true) {
                        showAdaptiveActionSheet(
                          context: context,
                          title: const Text('Informe o nome do jogador'),
                          actions: <BottomSheetAction>[
                            BottomSheetAction(
                              title: Text('Sim, entendi',
                                  style: AppTypography.t14().copyWith(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                AppDefault.close(context);
                              },
                            ),
                          ],
                        );

                        return;
                      }
                      if (widget.positionController.positionEntity == null) {
                        showAdaptiveActionSheet(
                          context: context,
                          title: const Text('Informe uma posição'),
                          actions: <BottomSheetAction>[
                            BottomSheetAction(
                              title: Text('Sim, entendi',
                                  style: AppTypography.t14().copyWith(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                AppDefault.close(context);
                              },
                            ),
                          ],
                        );
                        return;
                      }
                      widget.onSave(
                        widget.positionController.name!,
                        widget.positionController.positionEntity!.guid!,
                        skill,
                      );
                    },
                    child: Text(
                      'Salvar',
                      style: AppTypography.t16().copyWith(
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ).withBottomPadding(),
              Center(
                child: Container(
                  width: 85,
                  height: 85,
                  decoration: const BoxDecoration(
                    color: AppColor.lightColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Iconsax.camera,
                    size: 38,
                  ),
                ).withBottomPadding(),
              ),
              TextField(
                onChanged: (value) => widget.positionController.name = value,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColor.lightColor,
                  hintText: 'Nome',
                  suffixIcon: Icon(Iconsax.user),
                ),
              ).themeTwo().withBottomPadding(),
              TextField(
                onTap: () async {
                  await showCupertinoModalBottomSheet(
                    context: context,
                    expand: true,
                    builder: (context) => PageSearchPosition(
                      positionController: widget.positionController
                        ..getPositions(),
                      onPosition: (position) {
                        setState(() {
                          widget.positionController.positionEntity = position;
                        });
                      },
                    ),
                  );
                },
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.lightColor,
                  hintText: widget.positionController.positionEntity != null
                      ? widget.positionController.positionEntity?.name
                      : 'Posição',
                  suffixIcon: const Icon(Iconsax.arrow_down),
                ),
              ).themeTwo().withBottomPadding(),
              Text(
                'Editar habilidades',
                style: AppTypography.t16().copyWith(
                  height: 2.0,
                  color: AppColor.secondaryColor,
                ),
              ),
              FadeAnimation(
                delay: 0.2,
                child: SkillCompoenent(
                  onChange: (int value) =>
                      widget.positionController.strength = value,
                  title: 'Força',
                ).withTopPadding(),
              ),
              FadeAnimation(
                delay: 0.4,
                child: SkillCompoenent(
                  onChange: (int value) =>
                      widget.positionController.velocity = value,
                  title: 'Velocidade',
                ),
              ),
              FadeAnimation(
                delay: 0.6,
                child: SkillCompoenent(
                  onChange: (int value) =>
                      widget.positionController.dribble = value,
                  title: 'Drible',
                ),
              ),
              FadeAnimation(
                  delay: 0.8,
                  child: SkillCompoenent(
                    onChange: (int value) =>
                        widget.positionController.completion = value,
                    title: 'Finalização',
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
