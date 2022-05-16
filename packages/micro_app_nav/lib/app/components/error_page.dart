import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../core/constants/local_image.dart';

class ErrrorComponent extends StatelessWidget {
  final Function onLoad;
  const ErrrorComponent({Key? key, required this.onLoad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Oups!',
              style: AppTypography.t28WithW800()
                  .copyWith(color: AppColor.primaryColor)),
          SizedBox(
              height: 300,
              child: Lottie.asset(
                LocalImage.error2,
                repeat: false,
              )).withBottomPadding(),
          Text(
            'Ocorreu um error inesperado!',
            style: AppTypography.t22WithW800(),
          ).withBottomPadding(),
          Text(
            'Encontramos um error\nao tentar conectar com o servidor',
            textAlign: TextAlign.center,
            style: AppTypography.t16(fontName: 'Inter')
                .copyWith(color: AppColor.textLight),
          ).withBottomPadding(),
          Text(
            'Por favor tente novamente 😅',
            textAlign: TextAlign.center,
            style: AppTypography.t16(fontName: 'Inter')
                .copyWith(color: AppColor.textLight),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: SizedBox(
              width: double.infinity,
              height: 66,
              child: ElevatedButton(
                onPressed: () {
                  onLoad.call();
                },
                child: Text(
                  'Tentar novamente',
                  style: AppTypography.t16().copyWith(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
