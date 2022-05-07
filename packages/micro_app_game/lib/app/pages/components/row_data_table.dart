import 'package:flutter/material.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:micro_core/utils/split_convert_name.dart';

class RowDataTable extends StatelessWidget {
  final String avatar;
  final String name;
  final String? icon;

  const RowDataTable({
    Key? key,
    required this.avatar,
    required this.name,
    this.icon,
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
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 15,
            backgroundImage: NetworkImage(avatar),
          ).withLeftPadding().withRightPadding(),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: name.splitConvertName(),
                children: [
                  TextSpan(
                    text: icon,
                  )
                ],
              ),
            ),
          ),
        ],
      ).withBottomPadding(),
    );
  }
}
