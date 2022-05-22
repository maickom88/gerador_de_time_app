import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:micro_commons/app/components/error_page.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../components/card_history.dart';
import '../controllers/historic_controller.dart';
import '../states/historic_state.dart';

class NavHistoric extends StatefulWidget {
  final HistoricController historicController;
  const NavHistoric({
    Key? key,
    required this.historicController,
  }) : super(key: key);

  @override
  State<NavHistoric> createState() => _NavHistoricState();
}

class _NavHistoricState extends State<NavHistoric> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<HistoricState>(
          valueListenable: widget.historicController,
          builder: (context, value, child) {
            if (value is HistoricErrorState) {
              return ErrorComponent(
                onLoad: () => widget.historicController.getHistorics(),
              );
            }
            if (value is HistoricSuccessState) {
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
                      largeTitle: Text(
                        'Historico',
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
                            widget.historicController.searchHistoric(value);
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
                      ListView.builder(
                        itemCount: widget.historicController
                                .searchResultHistorics.isNotEmpty
                            ? widget
                                .historicController.searchResultHistorics.length
                            : value.cups.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final cup = widget.historicController
                                  .searchResultHistorics.isNotEmpty
                              ? widget.historicController
                                  .searchResultHistorics[index]
                              : value.cups[index];
                          return FadeAnimation(
                            delay: (1.0 + index) / 4,
                            child: CardHistoric(
                              isDraft: cup.isDraft,
                              title: cup.sport.name,
                              nameWinner: cup.winner?.name.toUpperCase(),
                              date: cup.date,
                              guidCup: cup.guid!,
                            ),
                          );
                        },
                      )
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
