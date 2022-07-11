import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:micro_commons/app/components/error_page.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/helpers/keyboard_manenger.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../domain/entities/position_entity.dart';
import '../controllers/custum_position_controller.dart';
import '../states/position_state.dart';

class PageSearchPosition extends StatelessWidget with KeyboardManager {
  final Function(PositionEntity position) onPosition;
  const PageSearchPosition({
    Key? key,
    required this.onPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: CupertinoPageScaffold(
        backgroundColor: Colors.white,
        child: ValueListenableBuilder<PositionState>(
          valueListenable: CustumPositionController.instance.controller,
          builder: (context, value, child) {
            if (value is PositionErrorState) {
              return ErrorComponent(
                onLoad: () =>
                    CustumPositionController.instance.controller.getPositions(),
              );
            }
            if (value is PositionSuccessState) {
              return NestedScrollView(
                physics: const BouncingScrollPhysics(),
                headerSliverBuilder: (_, inner) {
                  return <Widget>[
                    const SliverToBoxAdapter(
                        child: SizedBox(
                      height: 20,
                    )),
                    CupertinoSliverNavigationBar(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsetsDirectional.only(top: 5),
                      largeTitle: SizedBox(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: CupertinoTextField(
                            placeholder: 'Pesquisar',
                            onChanged: (value) => CustumPositionController
                                .instance.controller
                                .searchPosition(value),
                            prefix: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(
                                Iconsax.search_normal,
                                color: AppColor.textLight,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.lightColor,
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                        ),
                      ),
                      border: Border.all(color: Colors.transparent),
                    ),
                    // SizedBox(width: 60, height: 20, child: TextFormField())
                  ];
                },
                body: Material(
                  type: MaterialType.transparency,
                  color: Colors.white,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: CustumPositionController.instance.controller
                              .searchResultPositions.isNotEmpty
                          ? CustumPositionController
                              .instance.controller.searchResultPositions.length
                          : value.positions.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final position = CustumPositionController.instance
                                .controller.searchResultPositions.isNotEmpty
                            ? CustumPositionController.instance.controller
                                .searchResultPositions[index]
                            : value.positions[index];
                        return FadeAnimation(
                          delay: (1.0 + index) / 4,
                          child: ListTile(
                            onTap: () {
                              SystemSound.play(SystemSoundType.click);
                              onPosition(position);
                              AppDefault.close(context);
                            },
                            title: Text(
                              position.name,
                              style: AppTypography.t16()
                                  .copyWith(color: AppColor.textLight),
                            ),
                            trailing: const Icon(
                              Iconsax.arrow_right,
                              color: AppColor.textLight,
                            ),
                          ),
                        );
                      }),
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
          },
        ),
      ),
    );
  }
}
