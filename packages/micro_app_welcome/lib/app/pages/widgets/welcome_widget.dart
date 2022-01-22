import 'package:flutter/material.dart';
import 'package:micro_core/core/theme/theme.dart';

class WelcomeWidget extends StatelessWidget {
  final String title;
  final String description;

  const WelcomeWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 17, end: 28),
            duration: const Duration(milliseconds: 300),
            builder: (_, size, __) => Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.t28WithW800()
                  .copyWith(fontSize: size, color: Colors.white),
            ).withBottomPadding(),
          ),
        ),
        Flexible(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.1, end: 1.0),
            duration: const Duration(milliseconds: 500),
            builder: (_, size, __) => Opacity(
              opacity: size,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: AppTypography.t18(fontName: 'Inter')
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
