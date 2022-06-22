import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../core/constants/local_image.dart';

class DeleteAccount extends StatelessWidget {
  final double? height;
  final Function onLoad;
  final bool? showDetails;
  const DeleteAccount(
      {Key? key,
      this.showDetails = true,
      this.height = 300,
      required this.onLoad})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: height,
              child: Lottie.asset(
                LocalImage.deleteAccount,
              )).withBottomPadding(),
          Visibility(
            visible: !showDetails!,
            child: Text(
              'Deseja excluir sua conta?',
              style: AppTypography.t22WithW800(),
            ).withBottomPadding(),
          ),
          Text(
            'Seus dados serão apagados, e você retornará para a tela de login',
            textAlign: TextAlign.center,
            style: AppTypography.t16(fontName: 'Inter')
                .copyWith(color: AppColor.textLight),
          ).withBottomPadding(),
          Text(
            'Deseja confirmar essa ação 😰',
            textAlign: TextAlign.center,
            style: AppTypography.t16(fontName: 'Inter')
                .copyWith(color: AppColor.textLight),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: SizedBox(
              width: double.infinity,
              height: 66,
              child: ElevatedButton(
                onPressed: () {
                  onLoad.call();
                },
                child: Text(
                  'Sim, excluir conta',
                  style: AppTypography.t16().copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () => AppDefault.close(context),
              child: Text(
                'Cancelar',
                style: AppTypography.t14().copyWith(color: Colors.grey),
              ))
        ],
      ),
    );
  }
}
