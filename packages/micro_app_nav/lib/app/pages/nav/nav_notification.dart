import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../components/card_notication.dart';

class NavNotification extends StatefulWidget {
  const NavNotification({
    Key? key,
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
              trailing: GestureDetector(
                onTap: () {
                  SystemSound.play(SystemSoundType.click);
                },
                child: Text.rich(TextSpan(
                  style: AppTypography.t16().copyWith(
                    height: 2.0,
                    color: AppColor.secondaryColor,
                  ),
                  children: [
                    TextSpan(text: _showOnlyIcon ? '' : 'Limpar tudo'),
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
              ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return FadeAnimation(
                    delay: (1.0 + index) / 4,
                    child: const CardNotification(
                      title: 'Sua melhor diversão!',
                      description:
                          'Estamos trabalhando em novas versões para tornar suas peladas ainda mais divertidas ✌️',
                    ),
                  );
                },
              )
            ],
          ).withSymPadding(),
        ),
      ),
    );
  }
}
