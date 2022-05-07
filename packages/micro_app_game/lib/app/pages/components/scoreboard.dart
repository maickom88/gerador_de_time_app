import 'package:flutter/material.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:iconsax/iconsax.dart';

import 'card_score.dart';

class Scoreboard extends StatelessWidget {
  final String nameTeam;
  final VoidCallback onTap;
  final int score;
  final Color color;

  const Scoreboard({
    Key? key,
    required this.nameTeam,
    required this.score,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CardScore(
          color: color,
          score: score,
          nameTeam: nameTeam,
        ).withBottomPadding(),
        Row(
          children: [
            GestureDetector(
              onTap: () => onTap(),
              child: const Icon(
                Iconsax.minus_square,
                color: AppColor.textLight,
              ).withRightPadding(rightPadding: 40),
            ),
            GestureDetector(
              onTap: () => onTap(),
              child: const Icon(
                Iconsax.add_square,
                color: AppColor.textLight,
              ),
            ),
          ],
        )
      ],
    );
  }
}
