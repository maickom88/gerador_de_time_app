import 'package:flutter/material.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../core/constants/local_image.dart';
import '../domain/entities/player_entity.dart';

class CircleTeams extends StatelessWidget {
  final List<PlayerEntity> players;
  final bool isTable;
  final double? firstPositionRight;
  final double? secondPositionRight;
  const CircleTeams({
    Key? key,
    required this.players,
    this.isTable = false,
    this.firstPositionRight,
    this.secondPositionRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (players.isEmpty) return const SizedBox();
    return SizedBox(
      width: double.infinity,
      child: Visibility(
        replacement: CardOnTable(players: players),
        visible: !isTable,
        child: Stack(
          children: [
            if (players.containsAt(0))
              Positioned.fill(
                right: firstPositionRight ?? 85,
                child: FadeAnimation(
                  delay: 0.3,
                  directionType: DirectionType.translateX,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: Colors.white),
                          color: AppColor.textLight,
                        ),
                        child: ClipOval(
                          child: Builder(
                            builder: (context) {
                              if (players[0].photo != null) {
                                return Image.network(
                                  players[0].photo!,
                                  fit: BoxFit.cover,
                                );
                              }
                              return Image.asset(
                                ProfileImage.hand1,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      )),
                ),
              ),
            if (players.containsAt(1))
              Positioned.fill(
                right: secondPositionRight ?? 60,
                child: FadeAnimation(
                  delay: 0.6,
                  directionType: DirectionType.translateX,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.textLight,
                          border: Border.all(width: 1, color: Colors.white),
                        ),
                        child: ClipOval(
                          child: Builder(
                            builder: (context) {
                              if (players[1].photo != null) {
                                return Image.network(
                                  players[1].photo!,
                                  fit: BoxFit.cover,
                                );
                              }
                              return Image.asset(
                                ProfileImage.hand1,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      )),
                ),
              ),
            if (players.containsAt(2))
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.white),
                        color: AppColor.textLight,
                      ),
                      child: ClipOval(
                        child: Builder(
                          builder: (context) {
                            if (players[2].photo != null) {
                              return Image.network(
                                players[2].photo!,
                                fit: BoxFit.cover,
                              );
                            }
                            return Image.asset(
                              ProfileImage.hand1,
                              fit: BoxFit.cover,
                            );
                          },
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
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: Stack(
                    children: [
                      if (players.containsAt(3))
                        Opacity(
                          opacity: 0.5,
                          child: ClipOval(
                            child: Builder(
                              builder: (context) {
                                if (players[3].photo != null) {
                                  return Image.network(
                                    players[3].photo!,
                                    fit: BoxFit.cover,
                                  );
                                }
                                return Image.asset(
                                  ProfileImage.hand1,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                      Center(
                        child: FittedBox(
                          child: Text(
                            players.length.toNumberPlayer(),
                            style: AppTypography.t22WithW800()
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension ToNumberPlayer on int {
  String toNumberPlayer() {
    final number = this - 4;
    if (number <= 0) {
      return ' ';
    }
    return '$number+';
  }

  String toNumberPlayerOnTable() {
    final number = this - 2;
    if (number <= 0) {
      return ' ';
    }
    return '$number+';
  }
}

extension ListExtensions<T> on List<T> {
  bool containsAt(int index) {
    if (asMap().containsKey(index)) {
      return true;
    }
    return false;
  }
}

class CardOnTable extends StatelessWidget {
  final List<PlayerEntity> players;
  const CardOnTable({
    Key? key,
    required this.players,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (players.containsAt(0))
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.white),
                    color: AppColor.textLight,
                  ),
                  child: ClipOval(
                    child: Builder(
                      builder: (context) {
                        if (players[2].photo != null) {
                          return Image.network(
                            players[2].photo!,
                            fit: BoxFit.cover,
                          );
                        }
                        return Image.asset(
                          ProfileImage.hand1,
                          fit: BoxFit.cover,
                        );
                      },
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
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: Stack(
                children: [
                  if (players.containsAt(1))
                    Opacity(
                      opacity: 0.5,
                      child: ClipOval(
                        child: Builder(
                          builder: (context) {
                            if (players[1].photo != null) {
                              return Image.network(
                                players[1].photo!,
                                fit: BoxFit.cover,
                              );
                            }
                            return Image.asset(
                              ProfileImage.hand1,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  Center(
                    child: FittedBox(
                      child: Text(
                        players.length.toNumberPlayerOnTable(),
                        style: AppTypography.t22WithW800()
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
