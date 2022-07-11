import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../../core/constants/local_image.dart';

class ModelBottomError extends StatefulWidget {
  final String description;
  const ModelBottomError({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  State<ModelBottomError> createState() => _ModelBottomErrorState();
}

class _ModelBottomErrorState extends State<ModelBottomError> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        height: AppDefault.height(context).percent(45),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      SystemSound.play(SystemSoundType.click);
                      AppDefault.close(context);
                    },
                    child: Text(
                      'Sair',
                      style: AppTypography.t16().copyWith(
                        color: AppColor.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ).withBottomPadding(),
              Center(child: Image.asset(LocalImage.imageNotLoad)),
              Center(
                child: Text(
                  'Ocorreu um error inesperado!',
                  style: AppTypography.t22WithW800(),
                ).withBottomPadding(),
              ),
              Center(
                child: Text(
                  widget.description,
                  textAlign: TextAlign.center,
                  style: AppTypography.t16(fontName: 'Inter')
                      .copyWith(color: AppColor.textLight),
                ).withBottomPadding(),
              ),
              Center(
                child: Text(
                  'Por favor tente novamente 😅',
                  textAlign: TextAlign.center,
                  style: AppTypography.t16(fontName: 'Inter')
                      .copyWith(color: AppColor.textLight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
