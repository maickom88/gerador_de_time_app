import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/services.dart';
import 'package:micro_commons/app/components/error_message.dart';
import 'package:micro_commons/app/components/policy_and_privacity.dart';
import 'package:micro_commons/app/components/terms_of_conditions.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/customs/custum_in_app_purchase.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:micro_core/core/helpers/keyboard_manenger.dart';
import 'package:micro_core/core/theme/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/constants/local_image.dart';
import '../controller/subscription_controller.dart';
import '../states/subscription_state.dart';

class SubscriptionPage extends StatefulWidget {
  final SubscriptionController controller;
  const SubscriptionPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage>
    with KeyboardManager {
  @override
  void initState() {
    CustumInAppPurchese.instance.onBuy.listen(
        (event) {
          widget.controller.saveBuy(4.99, 25.66);
        },
        onDone: () {},
        onError: (error) {
          showCupertinoModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.only(top: 30),
                    height: 300,
                    child: ErrorMessage(
                      description: error.message,
                      height: 120,
                    ),
                  ),
                );
              });
        });
    super.initState();
  }

  @override
  void dispose() {
    CustumInAppPurchese.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff2D2D30),
          elevation: 0,
          toolbarHeight: 40,
          leadingWidth: 80,
          leading: TextButton(
            onPressed: () => AppDefault.close(context),
            child: const Text('Voltar'),
          ),
          actions: [
            TextButton.icon(
              onPressed: () async {
                widget.controller.setLoading();
                await CustumInAppPurchese.instance.restorePurchases();
                widget.controller.closeLoading();
              },
              icon: const Icon(
                Iconsax.refresh,
                size: 18,
              ),
              label: const Text('Restaurar compra'),
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          height: AppDefault.height(context),
          clipBehavior: Clip.none,
          decoration: const BoxDecoration(
            color: Color(0xff2D2D30),
            image: DecorationImage(
              image: AssetImage(LocalImage.circle),
              scale: 2.8,
              alignment: Alignment(0, -0.8),
            ),
          ),
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FadeAnimation(
                    delay: 0,
                    child: ClipRRect(
                      borderRadius: AppDefault.defaultBorderRadius(),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 13.0, sigmaY: 13.0),
                        child: IntrinsicHeight(
                          child: Container(
                            clipBehavior: Clip.none,
                            width: AppDefault.width(context),
                            height: AppDefault.height(context).percent(75),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xff3E3E42).withOpacity(0.60),
                              borderRadius: AppDefault.defaultBorderRadius(),
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    FadeAnimation(
                                      delay: 0.1,
                                      child: Text(
                                        'Torne-se premium',
                                        textAlign: TextAlign.center,
                                        style: AppTypography.t28WithW800()
                                            .copyWith(
                                                fontSize: 28,
                                                color: Colors.white),
                                      ),
                                    ),
                                    FadeAnimation(
                                      delay: 0.1,
                                      child: Text(
                                        'Sem compromisso. Cancele a qualquer momento.',
                                        textAlign: TextAlign.center,
                                        style:
                                            AppTypography.t18(fontName: 'Inter')
                                                .copyWith(color: Colors.white),
                                      ).withBottomPadding(),
                                    ),
                                    FadeAnimation(
                                      delay: 0.2,
                                      child: const CardSubscription()
                                          .withBottomPadding(),
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable: widget.controller,
                                        builder: (context, value, child) {
                                          if (value
                                              is SubscriptionLoandingState) {
                                            return const SizedBox(
                                              height: 50,
                                              child: Center(
                                                child: LoadingIndicator(
                                                  indicatorType:
                                                      Indicator.ballPulseSync,
                                                  colors: [
                                                    Colors.white,
                                                  ],
                                                ),
                                              ),
                                            ).withBottomPadding();
                                          }
                                          return FadeAnimation(
                                            delay: 0.3,
                                            child: SizedBox(
                                              width: double.infinity,
                                              height: 66,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  widget.controller
                                                      .setLoading();
                                                  await CustumInAppPurchese
                                                      .instance
                                                      .buy();
                                                  widget.controller
                                                      .closeLoading();
                                                },
                                                child: Text(
                                                  'Assinar',
                                                  style: AppTypography.t16()
                                                      .copyWith(
                                                          color: Colors.white),
                                                ),
                                              ),
                                            ).withBottomPadding(),
                                          );
                                        }),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          const TextSpan(
                                              text:
                                                  'Esta assinatura é renovada automaticamente por um mês no valor de US\$ 4.99, a menos que seja cancelada com 24 horas de antecedência. O gratuito é cobrado na sua conta do iTunes na confirmação da compra. Você pode gerenciar suas assinaturas e desativar a renovação automática acessando as Configurações da sua conta. Nenhum cancelamento da assinatura atual é permitido durante o período de assinatura ativa. Qualquer parte não utilizada de um período de teste gratuito será reforçada quando você adquirir uma assinatura dessa publicação. Ao se cadastrar, aceite nossos '),
                                          WidgetSpan(
                                            child: GestureDetector(
                                              onTap: () {
                                                AppDefault.navigateToWidget(
                                                  context,
                                                  widget:
                                                      const TermsOfConditions(),
                                                );
                                              },
                                              child: Text(
                                                'Termos de Uso ',
                                                style:
                                                    AppTypography.t13WithW800(
                                                            fontName: 'Inter')
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                              ),
                                            ),
                                          ),
                                          const TextSpan(text: 'e '),
                                          WidgetSpan(
                                            child: GestureDetector(
                                              onTap: () {
                                                AppDefault.navigateToWidget(
                                                    context,
                                                    widget:
                                                        const PolityAndPrivacy());
                                              },
                                              child: Text(
                                                  'Política de Privacidade.',
                                                  style:
                                                      AppTypography.t13WithW800(
                                                              fontName: 'Inter')
                                                          .copyWith(
                                                              color: Colors
                                                                  .white)),
                                            ),
                                          )
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                      style:
                                          AppTypography.t12(fontName: 'Inter')
                                              .copyWith(
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardSubscription extends StatelessWidget {
  const CardSubscription({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white.withOpacity(0.2)),
        color: const Color(0xff2D2D30).withOpacity(0.8),
        borderRadius: AppDefault.defaultBorderRadius(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextSubscriptionCard(
              description: 'Possibilidade de equilibrar times'),
          const TextSubscriptionCard(
              description: 'Número ilimitado de jogadores'),
          const TextSubscriptionCard(description: 'Número ilimitado de times'),
          Center(
            child: Text(
              'Bonús: acesso a novos esportes',
              textAlign: TextAlign.center,
              style: AppTypography.t14(fontName: 'Inter')
                  .copyWith(color: Colors.white.withOpacity(0.5)),
            ).withBottomPadding(bottomPadding: 20),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.white.withOpacity(0.3),
          ).withBottomPadding(),
          Center(
            child: Text(
              '\$4.99/Mês',
              textAlign: TextAlign.center,
              style: AppTypography.t16(fontName: 'Inter')
                  .copyWith(color: Colors.white),
            ),
          ).withBottomPadding(bottomPadding: 8),
          Center(
            child: Text(
              'R\$25,66',
              textAlign: TextAlign.center,
              style: AppTypography.t14(fontName: 'Inter')
                  .copyWith(color: Colors.white.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }
}

class TextSubscriptionCard extends StatelessWidget {
  final String description;
  const TextSubscriptionCard({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style:
            AppTypography.t18(fontName: 'Inter').copyWith(color: Colors.white),
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primaryColor,
              ),
            ),
          ),
          TextSpan(
            text: '  $description',
          ),
        ],
      ),
    ).withBottomPadding(bottomPadding: 10);
  }
}
