import 'package:flutter/material.dart';
import 'package:micro_core/core/theme/theme.dart';

class SettingsDetails extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Widget widget;
  const SettingsDetails({
    Key? key,
    required this.label,
    required this.widget,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 25,
              color: const Color(0xffACACAC),
            ).withRightPadding(rightPadding: 20),
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color(0xffC4C4C4),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: AppTypography.t16().copyWith(
                      color: const Color(0xffACACAC),
                    ),
                  ),
                  widget,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
