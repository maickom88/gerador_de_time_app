import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uuid/uuid.dart';
import 'package:micro_commons/app/components/avatar_photo.dart';
import 'package:micro_commons/app/components/model_bottom_performace.dart';
import 'package:micro_commons/app/controllers/performace_controller.dart';
import 'package:micro_commons/app/factories/build_resources.dart';
import 'package:micro_commons/core/constants/local_image.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CardPlayer extends StatefulWidget {
  final String name;
  final String? photo;
  final String position;
  final String guid;
  final int? skillValue;
  final Function(bool value) isSelect;
  final bool select;
  const CardPlayer({
    Key? key,
    required this.name,
    required this.isSelect,
    required this.select,
    this.skillValue = 0,
    required this.guid,
    required this.position,
    required this.photo,
  }) : super(key: key);

  @override
  _CardPlayerState createState() => _CardPlayerState();
}

class _CardPlayerState extends State<CardPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.isSelect(!widget.select);
          });
        },
        child: AnimatedContainer(
          width: widget.select ? AppDefault.width(context).percent(80) : 120,
          padding: const EdgeInsets.all(10),
          height: 138,
          decoration: BoxDecoration(
            color: AppColor.lightColor,
            borderRadius: BorderRadius.circular(17),
            border: widget.select
                ? Border.all(
                    width: 2,
                    color: Theme.of(context).secondaryHeaderColor,
                  )
                : null,
            boxShadow:
                widget.select ? AppDefault.defaultBoxShadow(blur: 1) : null,
          ),
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Builder(builder: (context) {
                const locaImage = ProfileImage.hand1;
                return AvatarPhoto(
                  icon: Iconsax.trend_up,
                  isLoadImageLocal: widget.photo == null ? true : false,
                  photo: widget.photo != null ? widget.photo! : locaImage,
                  heroTag: const Uuid().v1(),
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      context: context,
                      builder: (context) => ModelBottomPerformance(
                          photo:
                              widget.photo != null ? widget.photo! : locaImage,
                          isLoadLocalImage: widget.photo == null ? true : false,
                          heroTag: widget.name.hashCode.toString(),
                          name: widget.name,
                          position: widget.position,
                          guid: widget.guid,
                          controller:
                              PerformaceController(getPerformacePlayerUsecase)
                                ..getPerformace(widget.guid)),
                    );
                  },
                );
              }),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.t22WithW800(),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        child: Row(
                          children: [
                            ...List.generate(
                              5,
                              (value) => Icon(
                                  value < widget.skillValue!
                                      ? Iconsax.star1
                                      : Iconsax.star,
                                  size: widget.skillValue! > value ? 25 : 19,
                                  color: AppColor.primaryColor),
                            ).toList(),
                          ],
                        ).withBottomPadding(bottomPadding: 10),
                      ),
                      Container(
                        height: 28,
                        width: 185,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              width: 80,
                              height: 28,
                              decoration: BoxDecoration(
                                color: AppColor.secondaryColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                  child: Text(
                                'POSIÇÃO',
                                style: AppTypography.t14()
                                    .copyWith(color: Colors.white),
                              )),
                            ).withRightPadding(rightPadding: 5),
                            Center(
                              child: Text(
                                widget.position.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ).withBottomPadding(),
        ),
      ),
    );
  }
}
