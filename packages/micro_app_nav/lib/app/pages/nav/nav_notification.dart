import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_commons/app/components/error_page.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../components/card_notication.dart';
import '../controllers/notification_controller.dart';
import '../states/notification_state.dart';

class NavNotification extends StatefulWidget {
  final NotificationController controller;
  const NavNotification({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _NavNotificationState createState() => _NavNotificationState();
}

class _NavNotificationState extends State<NavNotification> {
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
    return ValueListenableBuilder<NotificationState>(
        valueListenable: widget.controller,
        builder: (context, value, child) {
          if (value is NotificationErrorState) {
            return ErrorComponent(
              onLoad: () => widget.controller.getNotifications(),
            );
          }
          if (value is NotificationSuccessState) {
            return SafeArea(
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
                      trailing: Visibility(
                        visible: value.notifications.isNotEmpty,
                        child: GestureDetector(
                          onTap: () {
                            SystemSound.play(SystemSoundType.click);
                            widget.controller.clearNotification();
                          },
                          child: Text.rich(TextSpan(
                            style: AppTypography.t16().copyWith(
                              height: 2.0,
                              color: AppColor.secondaryColor,
                            ),
                            children: [
                              TextSpan(
                                  text: _showOnlyIcon ? '' : 'Limpar tudo'),
                              const WidgetSpan(
                                child: Icon(
                                  Iconsax.broom,
                                  color: AppColor.secondaryColor,
                                  size: 25,
                                ),
                              )
                            ],
                          )),
                        ),
                      ),
                      largeTitle: Text(
                        'Notificações',
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
                      Visibility(
                        replacement: CardNotification(
                          title: 'Fique atento as novidades',
                          description:
                              'Você receberá notificações aqui, tenha um bom jogo! 🥳 ',
                          dateTime: DateTime.now().formateDateString(),
                        ),
                        visible: value.notifications.isNotEmpty,
                        child: ListView.builder(
                          itemCount: value.notifications.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            final notification = value.notifications[index];
                            return FadeAnimation(
                              delay: (1.0 + index) / 4,
                              child: CardNotification(
                                title: notification.title,
                                description: notification.description,
                                dateTime:
                                    notification.createdAt.formateDateString(),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ).withSymPadding(),
                ),
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
        });
  }
}
