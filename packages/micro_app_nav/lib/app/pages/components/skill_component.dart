import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_core/core/theme/theme.dart';

class SkillCompoenent extends StatefulWidget {
  final String title;
  final int initialValue;
  final Function(int value) onChange;
  const SkillCompoenent({
    Key? key,
    required this.title,
    this.initialValue = 1,
    required this.onChange,
  }) : super(key: key);

  @override
  State<SkillCompoenent> createState() => _SkillCompoenentState();
}

class _SkillCompoenentState extends State<SkillCompoenent> {
  late int initialValue;

  @override
  void initState() {
    initialValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      height: 50,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: AppColor.lightColor),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style:
                AppTypography.t16WithW800().copyWith(color: AppColor.textLight),
          ),
          AnimatedToggleSwitch<int>.rolling(
            current: initialValue,
            values: const [1, 2, 3, 4, 5],
            onChanged: (i) {
              setState(() => initialValue = i);
              widget.onChange(i);
            },
            iconOpacity: 1,
            iconBuilder: (value, size, valuebool) {
              if (value <= initialValue) {
                IconData data = Iconsax.star1;
                return Icon(data,
                    color: AppColor.primaryColor,
                    size: min(size.width, size.height));
              }
              IconData data = Iconsax.star;
              return Icon(data,
                  color: AppColor.primaryColor,
                  size: min(size.width, size.height));
            },
            borderColor: Colors.transparent,
            indicatorSize: const Size(32.0, double.infinity),
            borderWidth: 0,
            selectedIconRadius: 16.0,
            innerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
