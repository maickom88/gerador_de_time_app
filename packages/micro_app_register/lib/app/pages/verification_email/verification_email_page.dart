import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:micro_core/core/theme/theme.dart';

import '../../../core/constants/local_image.dart';

class VerificationEmailPage extends StatefulWidget {
  final String email;
  const VerificationEmailPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  _VerificationEmailPageState createState() => _VerificationEmailPageState();
}

class _VerificationEmailPageState extends State<VerificationEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            LocalImage.sendEmailVerification,
            repeat: false,
          ).withBottomPadding(),
          Text(
            'Para confirmar de que se trata do seu e-mail, enviamos para ${widget.email.lockEmail()}.\nCheque sua caixa de mensagens',
            textAlign: TextAlign.center,
            style: AppTypography.t28(),
          ).withBottomPadding(bottomPadding: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => AppDefault.close(context),
                child: Text(
                  'Começar',
                  style: AppTypography.t16().copyWith(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ).withSymPadding(),
    );
  }
}
