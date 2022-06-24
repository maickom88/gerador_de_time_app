import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../controllers/performace_controller.dart';
import '../states/performace_state.dart';
import 'error_page.dart';

class ModelBottomPerformance extends StatefulWidget {
  final PerformaceController controller;
  final String photo;
  final String guid;
  final bool isLoadLocalImage;
  final String heroTag;
  final String name;

  final int? skillValue;
  final String position;
  const ModelBottomPerformance({
    Key? key,
    required this.photo,
    required this.controller,
    this.skillValue = 0,
    required this.guid,
    required this.heroTag,
    required this.name,
    required this.position,
    this.isLoadLocalImage = false,
  }) : super(key: key);

  @override
  State<ModelBottomPerformance> createState() => _ModelBottomPerformanceState();
}

class _ModelBottomPerformanceState extends State<ModelBottomPerformance> {
  late double doublePercente;
  @override
  void initState() {
    doublePercente = 50;
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: AppDefault.height(context).percent(doublePercente),
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
                      'Desempenho',
                      style: AppTypography.t16().copyWith(),
                    ),
                  ),
                ],
              ).withBottomPadding(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Stack(
                        children: [
                          Container(
                            width: 85,
                            height: 85,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.textLight,
                            ),
                            child: ClipOval(
                              child: Builder(
                                builder: (context) {
                                  if (!widget.isLoadLocalImage) {
                                    return Hero(
                                      tag: widget.heroTag,
                                      child: ExtendedImage.network(
                                        widget.photo,
                                        fit: BoxFit.cover,
                                        height: 85,
                                        width: 85,
                                        timeLimit: const Duration(days: 15),
                                      ),
                                    );
                                  }
                                  return Hero(
                                    tag: widget.heroTag,
                                    child: Image.asset(
                                      widget.photo,
                                      fit: BoxFit.cover,
                                      height: 85,
                                      width: 85,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.name,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.t22WithW800(),
                          ),
                          Row(
                            children: [
                              ...List.generate(
                                5,
                                (value) => Icon(
                                    value < widget.skillValue!
                                        ? Iconsax.star1
                                        : Iconsax.star,
                                    size: widget.skillValue! > value ? 25 : 19,
                                    color: AppColor.primaryColor),
                              ).toList(),
                            ],
                          ).withBottomPadding(bottomPadding: 10),
                          Container(
                            height: 28,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: AppColor.lightColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: IntrinsicWidth(
                              child: Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: AppColor.secondaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'POSIÇÃO',
                                      style: AppTypography.t14()
                                          .copyWith(color: Colors.white),
                                    )),
                                  ).withRightPadding(rightPadding: 5),
                                  Flexible(
                                    child: Text(
                                      widget.position.toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ).withBottomPadding(),
              ValueListenableBuilder<PerformaceState>(
                  valueListenable: widget.controller,
                  builder: (context, value, child) {
                    if (value is PerformaceErrorState) {
                      Future.delayed(Duration.zero, () async {
                        setState(() {
                          doublePercente = 65;
                        });
                      });

                      return ErrorComponent(
                        height: 80,
                        onLoad: () =>
                            widget.controller.getPerformace(widget.guid),
                      );
                    }
                    if (value is PerformaceSuccessState) {
                      return Column(
                        children: [
                          FadeAnimation(
                            delay: 0.2,
                            child: PerformaceDetails(
                              emoji: '🏆',
                              label: 'Vitorias',
                              value: value.perfomace.totalWinnerCups,
                              color: Colors.green,
                            ),
                          ),
                          FadeAnimation(
                            delay: 0.4,
                            child: PerformaceDetails(
                              emoji: '⚽️',
                              color: Colors.yellow[700]!,
                              label: 'Gols marcados',
                              value: value.perfomace.goals.length,
                            ),
                          ),
                          FadeAnimation(
                            delay: 0.6,
                            child: PerformaceDetails(
                              emoji: '🔥',
                              color: AppColor.secondaryColor,
                              label: 'Copinhas',
                              value: value
                                  .perfomace.totalNumberOfCupParticipations,
                            ),
                          ),
                        ],
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
            ],
          ),
        ),
      ),
    );
  }
}

class PerformaceDetails extends StatelessWidget {
  final String label;
  final String emoji;
  final int value;
  final Color color;
  const PerformaceDetails({
    Key? key,
    required this.label,
    required this.color,
    required this.emoji,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            emoji,
            style: AppTypography.t28(),
          ).withRightPadding(rightPadding: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: AppColor.lightColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: AppTypography.t22WithW300()
                        .copyWith(color: AppColor.textLight),
                  ),
                  Container(
                    constraints: const BoxConstraints(minWidth: 60),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: color,
                    ),
                    child: Center(
                      child: Text(
                        value.toString(),
                        style:
                            AppTypography.t16().copyWith(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
