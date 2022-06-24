import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_commons/app/components/circle_teams.dart';
import 'package:micro_commons/app/components/error_page.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:extended_image/extended_image.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../../core/constants/local_image.dart';
import '../controllers/cup_information_controller.dart';
import '../states/cup_information_state.dart';

class DetailsPage extends StatefulWidget {
  final String guidCup;
  final CupInformationController controller;
  const DetailsPage({
    Key? key,
    required this.guidCup,
    required this.controller,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void dispose() {
    widget.controller.dispose();
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
                leading: GestureDetector(
                  onTap: () {
                    SystemSound.play(SystemSoundType.click);
                    AppDefault.close(context);
                  },
                  child: Material(
                    color: Colors.transparent,
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
                  'Copinha',
                  style: AppTypography.t28WithW800(),
                ),
                border: Border.all(color: Colors.transparent),
              ),
            ];
          },
          body: ValueListenableBuilder<CupInformationState>(
              valueListenable: widget.controller,
              builder: (context, value, child) {
                if (value is CupInformationErrorState) {
                  return ErrorComponent(
                    onLoad: () =>
                        widget.controller.getCupInformations(widget.guidCup),
                  );
                }
                if (value is CupInformationSuccessState) {
                  return SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Realizado em ${value.cupInformation.date.formateDateString()}',
                          style: AppTypography.t14().copyWith(
                            color: AppColor.textLight,
                          ),
                        ).withBottomPadding(bottomPadding: 40),
                        if (value.cupInformation.winner != null)
                          FadeAnimation(
                            delay: 0.1,
                            child: CardDetailsCup(
                              color: AppColor.secondaryColor,
                              emoji: '🏆',
                              label: Text(
                                'Vencedor da copinha',
                                style: AppTypography.t22WithW800()
                                    .copyWith(color: Colors.white),
                              ),
                              widget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value.cupInformation.winner!.name,
                                    style: AppTypography.t16()
                                        .copyWith(color: Colors.white),
                                  ).withBottomPadding(bottomPadding: 5),
                                  CircleTeams(
                                    players:
                                        value.cupInformation.winner?.players ??
                                            [],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (value.cupInformation.bestPlayer != null)
                          FadeAnimation(
                            delay: 0.2,
                            child: CardDetailsCup(
                              color: AppColor.lightColor,
                              emoji: '⚽',
                              label: Text(
                                'Artilheiro',
                                style: AppTypography.t22WithW800(),
                              ),
                              widget: RowDetailsCup(
                                name: value.cupInformation.bestPlayer!.name,
                                image: value.cupInformation.bestPlayer?.photo,
                              ).withTopPadding(topPadding: 5),
                            ),
                          ),
                        if (value.cupInformation.goalkeeper != null)
                          FadeAnimation(
                            delay: 0.3,
                            child: CardDetailsCup(
                              color: const Color(0xffF3C955),
                              emoji: '🥅',
                              label: Text(
                                'Melhor goleiro',
                                style: AppTypography.t22WithW800(),
                              ),
                              widget: RowDetailsCup(
                                name: value.cupInformation.goalkeeper!.name,
                                image: value.cupInformation.goalkeeper?.photo,
                              ).withTopPadding(topPadding: 5),
                            ),
                          ),
                        if (value.cupInformation.worstTeam != null)
                          FadeAnimation(
                            delay: 0.4,
                            child: CardDetailsCup(
                              color: const Color(0xffD53030),
                              emoji: '😩',
                              label: Text(
                                'Pior equipe',
                                style: AppTypography.t22WithW800()
                                    .copyWith(color: Colors.white),
                              ),
                              widget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value.cupInformation.worstTeam!.name,
                                    style: AppTypography.t16()
                                        .copyWith(color: Colors.white),
                                  ).withBottomPadding(bottomPadding: 5),
                                  CircleTeams(
                                    players: value.cupInformation.worstTeam
                                            ?.players ??
                                        [],
                                  ),
                                ],
                              ),
                            ),
                          ),
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

class RowDetailsCup extends StatelessWidget {
  final String name;
  final String? image;
  const RowDetailsCup({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.textLight,
          ),
          child: ClipOval(
            child: Builder(
              builder: (context) {
                if (image != null) {
                  return ExtendedImage.network(
                    image!,
                    fit: BoxFit.cover,
                    timeLimit: const Duration(days: 15),
                  );
                }
                return Image.asset(
                  ProfileImage.hand1,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ).withRightPadding(),
        Text(
          name,
          style: AppTypography.t16(),
        ),
      ],
    );
  }
}

class CardDetailsCup extends StatelessWidget {
  final Color color;
  final Widget label;
  final Widget widget;
  final String emoji;

  const CardDetailsCup({
    Key? key,
    required this.color,
    required this.label,
    required this.widget,
    required this.emoji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      height: 135,
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppDefault.defaultBorderRadius(),
      ),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 50),
          ).withRightPadding(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  label,
                  widget,
                ],
              ),
            ),
          ),
        ],
      ),
    ).withBottomPadding();
  }
}
