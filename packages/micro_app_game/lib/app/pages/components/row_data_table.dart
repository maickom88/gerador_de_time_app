import 'package:flutter/material.dart';
import 'package:micro_commons/core/constants/local_image.dart';
import 'package:micro_core/core/theme/theme.dart';

class RowDataTable extends StatelessWidget {
  final String? avatar;
  final String name;
  final String? icon;
  final int? goal;

  const RowDataTable({
    Key? key,
    required this.avatar,
    required this.name,
    this.icon,
    this.goal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffe8e8e8),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 55,
            child: ClipOval(
              child: Builder(
                builder: (context) {
                  if (avatar != null) {
                    return Image.network(
                      avatar!,
                      fit: BoxFit.cover,
                    );
                  }
                  return Image.asset(
                    ProfileImage.hand1,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ).withLeftPadding().withRightPadding(),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: name.splitConvertName(),
                children: [
                  TextSpan(
                    text: icon,
                  ),
                  if (goal != null && goal! > 0)
                    TextSpan(
                      text: ' ⚽️ +$goal',
                    ),
                ],
              ),
            ),
          ),
        ],
      ).withBottomPadding(),
    );
  }
}
