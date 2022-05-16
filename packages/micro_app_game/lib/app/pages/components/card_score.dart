import 'package:flutter/material.dart';
import 'package:micro_core/core/theme/theme.dart';

class CardScore extends StatelessWidget {
  final int score;
  final bool isRight;
  final String nameTeam;
  final Color color;

  const CardScore({
    Key? key,
    required this.score,
    required this.nameTeam,
    this.isRight = true,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 60,
      child: Stack(
        alignment: isRight
            ? AlignmentDirectional.topStart
            : AlignmentDirectional.topEnd,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  nameTeam,
                  maxLines: 2,
                  style:
                      AppTypography.t16WithW800().copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned.fill(
            right: 3,
            top: -27,
            child: Align(
              alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
              child: Text(
                score.toString(),
                textScaleFactor: 1.1,
                style: const TextStyle(
                    color: AppColor.textLight,
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -6,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        offset: Offset(1, 0),
                        color: Colors.black,
                      )
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
