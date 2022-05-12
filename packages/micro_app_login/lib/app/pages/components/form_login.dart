import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:micro_core/core/theme/theme.dart';

class FormLogin extends StatefulWidget {
  final void Function(String email, String password) onLogin;
  final String? error;
  final bool loading;
  const FormLogin({
    Key? key,
    required this.onLogin,
    this.error,
    this.loading = false,
  }) : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  late TextEditingController textEmailController;
  late TextEditingController textPasswordController;
  late GlobalKey<FormState> formState;

  @override
  void initState() {
    textEmailController = TextEditingController();
    textPasswordController = TextEditingController();

    formState = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    textEmailController.dispose();
    textPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            controller: textEmailController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Preencha o campo!';
              }
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return "Por favor, digite um email válido!";
              }
              return null;
            },
            style: AppTypography.t16(fontName: 'Inter')
                .copyWith(color: AppColor.textTitle),
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email',
              suffixIcon: Icon(Iconsax.sms, color: AppColor.textLight),
            ),
          ).withBottomPadding(),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Preencha o campo!';
              }
              return null;
            },
            controller: textPasswordController,
            style: AppTypography.t16(fontName: 'Inter')
                .copyWith(color: AppColor.textTitle),
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              suffixIcon:
                  const Icon(Iconsax.eye_slash, color: AppColor.textLight),
              errorText: widget.error,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                SystemSound.play(SystemSoundType.click);
              },
              child: Text(
                'Esqueceu sua senha?',
                textAlign: TextAlign.left,
                style: AppTypography.t16(fontName: 'Inter')
                    .copyWith(color: Colors.white),
              ),
            ),
          ).withBottomPadding(bottomPadding: 30),
          SizedBox(
            width: double.infinity,
            height: 66,
            child: ElevatedButton(
              onPressed: !widget.loading
                  ? () {
                      if (formState.currentState!.validate()) {
                        HapticFeedback.lightImpact();
                        widget.onLogin(textEmailController.text,
                            textPasswordController.text);
                      } else {
                        HapticFeedback.vibrate();
                      }
                    }
                  : null,
              child: Visibility(
                replacement: const SizedBox(
                  height: 50,
                  child: Center(
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballPulseSync,
                      colors: [
                        Colors.white,
                      ],
                    ),
                  ),
                ),
                visible: !widget.loading,
                child: Text(
                  'Entrar',
                  style: AppTypography.t16().copyWith(color: Colors.white),
                ),
              ),
            ),
          ).withBottomPadding(),
          SizedBox(
            width: double.infinity,
            height: 66,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: AppDefault.defaultBorderRadius(radius: 10),
                  ),
                ),
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
                AppDefault.navigateTo(context, routeName: '/register');
              },
              child: Text(
                'Eu não tenho uma conta',
                style: AppTypography.t16().copyWith(color: Colors.white),
              ),
            ),
          ).withBottomPadding(),
        ],
      ),
    );
  }
}
