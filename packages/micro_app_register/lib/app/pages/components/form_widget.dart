import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/helpers/keyboard_manenger.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:iconsax/iconsax.dart';

class FormWidget extends StatefulWidget with KeyboardManager {
  final String title;
  final String label;
  final String? password;
  final String labelButton;
  final Function(String value) onEnter;
  final Function(String value) onChanged;
  final Function(bool focus) onFocus;

  const FormWidget({
    Key? key,
    required this.title,
    required this.onChanged,
    this.password,
    required this.label,
    required this.labelButton,
    required this.onEnter,
    required this.onFocus,
  }) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget>
    with AutomaticKeepAliveClientMixin<FormWidget> {
  late TextEditingController textController;
  late GlobalKey<FormState> formState;
  @override
  void initState() {
    textController = TextEditingController();
    formState = GlobalKey<FormState>();
    super.initState();
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 17, end: 28),
          duration: const Duration(milliseconds: 300),
          builder: (_, size, __) => Text(
            widget.title,
            textAlign: TextAlign.center,
            style: AppTypography.t28WithW800()
                .copyWith(fontSize: size, color: Colors.white),
          ),
        ).withBottomPadding(),
        Form(
          key: formState,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: FocusScope(
            child: Focus(
              onFocusChange: (focus) => widget.onFocus(focus),
              child: TextFormField(
                onChanged: (value) {
                  if (formState.currentState!.validate()) {
                    widget.onChanged(textController.text);
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Preencha o campo!';
                  }
                  if (widget.label.contains('email')) {
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Por favor, digite um email válido!";
                    }
                  }
                  if (widget.label.contains('senha')) {
                    if (!validateStructure(value)) {
                      return "A sua senha deve conter pelo menos 8 caracteres, um número, uma letra maiúscula e uma letra minúscula, exemplo: @Usuario01";
                    }
                  }
                  if (widget.title.contains('Confirme')) {
                    if (widget.password != value) {
                      return 'Senha e confirmar senha não são iguais!';
                    }
                  }
                  return null;
                },
                controller: textController,
                obscureText: widget.label.contains('senha'),
                textCapitalization: widget.label.contains('nome')
                    ? TextCapitalization.sentences
                    : TextCapitalization.none,
                keyboardType: widget.label.contains('email')
                    ? TextInputType.emailAddress
                    : TextInputType.text,
                style: AppTypography.t16(fontName: 'Inter')
                    .copyWith(color: AppColor.textTitle),
                decoration: InputDecoration(
                  hintText: widget.label,
                  suffixIcon: const Icon(Iconsax.personalcard,
                      color: AppColor.textLight),
                ),
              ).withBottomPadding(bottomPadding: 50),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 66,
          child: ElevatedButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              if (formState.currentState!.validate()) {
                widget.hideKeyboard(context);
                widget.onEnter(textController.text);
              } else {
                HapticFeedback.vibrate();
              }
            },
            child: Text(
              widget.labelButton,
              style: AppTypography.t16().copyWith(color: Colors.white),
            ),
          ),
        ).withBottomPadding(bottomPadding: 35),
      ],
    ).withSymPadding(vPadding: 0);
  }

  @override
  bool get wantKeepAlive => true;
}
