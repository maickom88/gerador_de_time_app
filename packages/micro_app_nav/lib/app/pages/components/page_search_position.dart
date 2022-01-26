import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/helpers/keyboard_manenger.dart';
import 'package:micro_core/core/theme/theme.dart';

class PageSearchPosition extends StatelessWidget with KeyboardManager {
  const PageSearchPosition({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: CupertinoPageScaffold(
        child: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (_, inner) {
            return <Widget>[
              const SliverToBoxAdapter(
                  child: SizedBox(
                height: 20,
              )),
              CupertinoSliverNavigationBar(
                padding: const EdgeInsetsDirectional.only(top: 5),
                largeTitle: SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: CupertinoTextField(
                        placeholder: 'Pesquisar',
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(
                            Iconsax.search_normal,
                            color: AppColor.textLight,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: AppColor.lightColor,
                            borderRadius: BorderRadius.circular(11))),
                  ),
                ),
                border: Border.all(color: Colors.transparent),
              ),
            ];
          },
          body: Material(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 22,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return FadeAnimation(
                    delay: (1.0 + index) / 4,
                    child: ListTile(
                      onTap: () {
                        SystemSound.play(SystemSoundType.click);
                      },
                      title: Text(
                        'Volante',
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
        ),
      ),
    );
  }
}
