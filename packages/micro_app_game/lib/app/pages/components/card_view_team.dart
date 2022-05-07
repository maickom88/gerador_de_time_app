import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/theme/theme.dart';

import 'card_player.dart';

class ModalViewCardTeam extends StatelessWidget {
  const ModalViewCardTeam({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      color: Colors.transparent,
      child: Container(
        height: 360,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        SystemSound.play(SystemSoundType.click);
                        AppDefault.close(context);
                      },
                      child: Text(
                        'Cancelar',
                        style: AppTypography.t16().copyWith(
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Registrar gol',
                      style: AppTypography.t16().copyWith(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        SystemSound.play(SystemSoundType.click);
                        AppDefault.close(context);
                      },
                      child: Text(
                        'Pronto',
                        style: AppTypography.t16().copyWith(
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ).withBottomPadding(),
              AppDefault.defaultSpaceHeight(),
              Text('Atribuir gol', style: AppTypography.t16WithW800())
                  .withBottomPadding(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: const [
                    CardPlayer(
                      name: 'Mauricio P.',
                      photo:
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                      position: 'Pivô',
                    ),
                    CardPlayer(
                      name: 'Mauricio P.',
                      photo:
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                      position: 'Pivô',
                    ),
                    CardPlayer(
                      name: 'Mauricio P.',
                      photo:
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                      position: 'Pivô',
                    ),
                    CardPlayer(
                      name: 'Mauricio P.',
                      photo:
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                      position: 'Pivô',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ColorsWidget extends StatelessWidget {
  const ColorsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
