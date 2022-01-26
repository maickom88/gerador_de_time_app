import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  final DirectionType? directionType;

  const FadeAnimation(
      {Key? key,
      required this.delay,
      required this.child,
      this.directionType = DirectionType.translateY})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, 0.0.tweenTo(1.0), 500.milliseconds)
      ..add(AniProps.translateY, (-30.0).tweenTo(0.0), 500.milliseconds,
          Curves.easeOut);

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
            offset: directionType == DirectionType.translateY
                ? Offset(0, value.get(AniProps.translateY))
                : Offset(value.get(AniProps.translateY), 0),
            child: child),
      ),
    );
  }
}

enum AniProps { opacity, translateY, translatey }

enum DirectionType { translateY, translateX }
