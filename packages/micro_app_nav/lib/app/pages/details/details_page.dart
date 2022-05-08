import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

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
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Realizado em 12, Abril de 2021',
                  style: AppTypography.t14().copyWith(
                    color: AppColor.textLight,
                  ),
                ).withBottomPadding(bottomPadding: 40),
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
                          'Equipe 1',
                          style:
                              AppTypography.t16().copyWith(color: Colors.white),
                        ).withBottomPadding(bottomPadding: 5),
                        const CircleTeams(),
                      ],
                    ),
                  ),
                ),
                FadeAnimation(
                  delay: 0.2,
                  child: CardDetailsCup(
                    color: AppColor.lightColor,
                    emoji: '⚽',
                    label: Text(
                      'Artilheiro',
                      style: AppTypography.t22WithW800(),
                    ),
                    widget: const RowDetailsCup(
                      name: 'Gabriel Silva',
                      image:
                          'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
                    ).withTopPadding(topPadding: 5),
                  ),
                ),
                FadeAnimation(
                  delay: 0.3,
                  child: CardDetailsCup(
                    color: const Color(0xffF3C955),
                    emoji: '🥅',
                    label: Text(
                      'Melhor goleiro',
                      style: AppTypography.t22WithW800(),
                    ),
                    widget: const RowDetailsCup(
                      name: 'Rogerio C.',
                      image:
                          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                    ).withTopPadding(topPadding: 5),
                  ),
                ),
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
                          'Equipe 1',
                          style:
                              AppTypography.t16().copyWith(color: Colors.white),
                        ).withBottomPadding(bottomPadding: 5),
                        const CircleTeams(),
                      ],
                    ),
                  ),
                ),
              ],
            ).withSymPadding(),
          ),
        ),
      ),
    );
  }
}

class RowDetailsCup extends StatelessWidget {
  final String name;
  final String image;
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
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: Colors.black),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
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

class CircleTeams extends StatelessWidget {
  const CircleTeams({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            right: 85,
            child: FadeAnimation(
              delay: 0.3,
              directionType: DirectionType.translateX,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.lightColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            right: 60,
            child: FadeAnimation(
              delay: 0.6,
              directionType: DirectionType.translateX,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.lightColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1517070208541-6ddc4d3efbcb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            right: 30,
            child: FadeAnimation(
              delay: 0.9,
              directionType: DirectionType.translateX,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1455274111113-575d080ce8cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          FadeAnimation(
            delay: 1.2,
            directionType: DirectionType.translateX,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.dstATop),
                    fit: BoxFit.cover,
                    image: const NetworkImage(
                        'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                  ),
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      '2+',
                      style: AppTypography.t22WithW800()
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
      height: 120,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                label,
                widget,
              ],
            ),
          ),
        ],
      ),
    ).withBottomPadding();
  }
}
