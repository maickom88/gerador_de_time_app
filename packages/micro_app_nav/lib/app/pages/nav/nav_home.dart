import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:extended_image/extended_image.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:micro_commons/app/components/error_page.dart';
import 'package:micro_commons/customs/file_picker_custum.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../../core/constants/local_image.dart';
import '../components/card_sport.dart';
import '../controllers/home_controller.dart';
import '../states/home_state.dart';

class NavHome extends StatefulWidget {
  final HomeController homeController;
  const NavHome({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  @override
  State<NavHome> createState() => _NavHomeState();
}

class _NavHomeState extends State<NavHome> {
  @override
  void initState() {
    CustumFilePicker.instance.onProgress.listen((event) {}).onDone(() async {
      widget.homeController.getUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<HomeState>(
          valueListenable: widget.homeController,
          builder: (context, value, child) {
            if (value is HomeErrorState) {
              return ErrorComponent(
                onLoad: () => widget.homeController.getSports(context),
              );
            }
            if (value is HomeSuccessState) {
              return NestedScrollView(
                physics: const BouncingScrollPhysics(),
                headerSliverBuilder: (_, inner) {
                  return <Widget>[
                    const SliverToBoxAdapter(
                        child: SizedBox(
                      height: 20,
                    )),
                    SliverAppBar(
                      leadingWidth: 85,
                      excludeHeaderSemantics: false,
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 28),
                        child: Container(
                          width: 85,
                          height: 85,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.textLight,
                          ),
                          child: ClipOval(
                            child: Builder(
                              builder: (context) {
                                if (widget.homeController.userEntity?.photo
                                        .isNotEmpty ==
                                    true) {
                                  return ExtendedImage.network(
                                    widget.homeController.userEntity!.photo,
                                    fit: BoxFit.cover,
                                    height: 85,
                                    width: 85,
                                    timeRetry: const Duration(days: 15),
                                  );
                                }
                                return Image.asset(
                                  ProfileImage.hand1,
                                  fit: BoxFit.cover,
                                  height: 85,
                                  width: 85,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              style: AppTypography.t28(),
                              children: [
                                const TextSpan(text: 'Olá '),
                                TextSpan(
                                  text:
                                      widget.homeController.userEntity?.name ??
                                          '',
                                  style: AppTypography.t28WithW800(),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Hoje é um ótimo dia para jogar 😁',
                            style: AppTypography.t16WithW300(fontName: 'Inter')
                                .copyWith(color: AppColor.textLight),
                          ),
                          const SizedBox(height: 8)
                        ],
                      ),
                    ),
                    CupertinoSliverNavigationBar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      largeTitle: Text(
                        'Esportes',
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
                            widget.homeController.searchSport(value);
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
                      SizedBox(
                        height: 325,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget
                                  .homeController.searchResultSports.isNotEmpty
                              ? widget.homeController.searchResultSports.length
                              : value.sports.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (_, index) {
                            final sport = widget.homeController
                                    .searchResultSports.isNotEmpty
                                ? widget
                                    .homeController.searchResultSports[index]
                                : value.sports[index];
                            return FadeAnimation(
                              delay: (1.8 + index) / 4,
                              child: CardSport(
                                description: sport.description,
                                photoUrl: sport.photoUrL,
                                title: sport.name,
                                isAvailable: sport.isAvailable,
                              ),
                            );
                          },
                        ),
                      ).withBottomPadding(),
                      FadeAnimation(
                        delay: 1.2,
                        child: Image.asset(
                          LocalImage.banner,
                          fit: BoxFit.fill,
                        ),
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
