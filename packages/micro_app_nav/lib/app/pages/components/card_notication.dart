import 'package:flutter/material.dart';
import 'package:micro_core/core/theme/theme.dart';

class CardNotification extends StatelessWidget {
  final String title;
  final String description;
  final String dateTime;

  const CardNotification({
    Key? key,
    required this.title,
    required this.description,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  Container(
                    height: 135,
                    width: 1,
                    color: AppColor.lightColor,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 3),
                child: Text(
                  dateTime,
                  style:
                      AppTypography.t14().copyWith(color: AppColor.textLight),
                ),
              )
            ],
          ),
          Positioned.fill(
            top: 15,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: IntrinsicHeight(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                                style: AppTypography.t22WithW800()
                                    .copyWith(height: 1.3)
                                    .copyWith(color: const Color(0xff5C5C5C)))
                            .withBottomPadding(bottomPadding: 5),
                        IntrinsicHeight(
                          child: Text(
                            description,
                            style: AppTypography.t16().copyWith(
                                color: AppColor.textLight, height: 1.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
