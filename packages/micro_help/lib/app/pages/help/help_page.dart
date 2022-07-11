import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:micro_commons/app/components/informations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:micro_commons/app/components/policy_and_privacity.dart';
import 'package:micro_commons/app/components/settings_details.dart';
import 'package:micro_commons/app/components/terms_of_conditions.dart';
import 'package:micro_core/core/components/animation.dart';
import 'package:micro_core/core/theme/theme.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (_, inner) {
          return <Widget>[
            const SliverToBoxAdapter(
                child: SizedBox(
              height: 20,
            )),
            CupertinoSliverNavigationBar(
              backgroundColor: Colors.white.withOpacity(0.8),
              leading: GestureDetector(
                onTap: () {
                  SystemSound.play(SystemSoundType.click);
                  AppDefault.close(context);
                },
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    'Voltar',
                    style: AppTypography.t16().copyWith(
                      height: 2.0,
                      color: AppColor.secondaryColor,
                    ),
                  ),
                ),
              ),
              largeTitle: Text(
                'Ajuda',
                style: AppTypography.t28WithW800(),
              ),
              border: Border.all(color: Colors.transparent),
            ),
          ];
        },
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeAnimation(
                delay: 0.2,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xffF4F4F4),
                    borderRadius: AppDefault.defaultBorderRadius(radius: 20),
                  ),
                  child: Column(
                    children: [
                      SettingsDetails(
                        label: 'Problemas com premium',
                        widget: GestureDetector(
                          onTap: () {
                            SystemSound.play(SystemSoundType.click);
                            showCupertinoModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return Material(
                                    color: Colors.white,
                                    child: SizedBox(
                                      height: AppDefault.height(context)
                                          .percent(70),
                                      child: const InformationModal(
                                        description:
                                            '''Ao fazer sua assinatura você terá acesso aos recursos
Premium do aplicativo, sendo possível cadastrar um número
Ilimitado de jogadores e gerar um numero ilimitado de times.

Uma das principais funcionalidades de quem é assinante é
equilibrar os times, essa função permite sortear os times
de modo equilibrado, isso baseando-se nas qualidades cadastradas
de cada jogador.''',
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: const Icon(
                            Iconsax.arrow_circle_right,
                            size: 25,
                            color: Color(0xffACACAC),
                          ).withRightPadding(rightPadding: 20),
                        ),
                      ),
                      SettingsDetails(
                        label: 'Problemas com notificações',
                        widget: GestureDetector(
                          onTap: () {
                            showCupertinoModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return Material(
                                    color: Colors.white,
                                    child: SizedBox(
                                      height: AppDefault.height(context)
                                          .percent(45),
                                      child: const InformationModal(
                                        description:
                                            '''Enviamos notificações e alertas após o término de cada partida para que seja fácil a visualização de quando o jogo acabar.

As notificações são uma maneira de visualizar com o dispositivo em segundo plano, ou em background (com a tela travada/bloqueada)''',
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: const Icon(
                            Iconsax.arrow_circle_right,
                            size: 25,
                            color: Color(0xffACACAC),
                          ).withRightPadding(rightPadding: 20),
                        ),
                      ),
                      SettingsDetails(
                        label: 'Problemas com jogadores',
                        widget: GestureDetector(
                          onTap: () {
                            showCupertinoModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: SizedBox(
                                      height: AppDefault.height(context)
                                          .percent(45),
                                      child: const InformationModal(
                                        description:
                                            '''Se você não é um usuário premium, não será Possível cadastrar mais de 25 jogadores, tornando assim também as equipes limitadas, para ter um número ilimitado de jogadores basta assinar o aplicativo na tela de SER PREMIUM.''',
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: const Icon(
                            Iconsax.arrow_circle_right,
                            size: 25,
                            color: Color(0xffACACAC),
                          ).withRightPadding(rightPadding: 20),
                        ),
                      ),
                      SettingsDetails(
                        label: 'Copinha',
                        widget: GestureDetector(
                          onTap: () {
                            showCupertinoModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: SizedBox(
                                      height: AppDefault.height(context)
                                          .percent(45),
                                      child: const InformationModal(
                                        description:
                                            '''As copinhas são organizadas e administradas pelo próprio usuário e para uma melhor experiencia sugerimos que cadastre os jogadores, dessa forma será fácil verificar o desempenho de cada jogador, artilharia e jogos.
''',
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: const Icon(
                            Iconsax.arrow_circle_right,
                            size: 25,
                            color: Color(0xffACACAC),
                          ).withRightPadding(rightPadding: 20),
                        ),
                      ),
                      SettingsDetails(
                        label: 'Equilibrio de times',
                        widget: GestureDetector(
                          onTap: () {
                            showCupertinoModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return Material(
                                    color: Colors.white,
                                    child: SizedBox(
                                      height: AppDefault.height(context)
                                          .percent(45),
                                      child: const InformationModal(
                                        description:
                                            '''O equilibrar times, é um recurso que só os usuários premium têm, é um algoritmo que equilibra a copinha, fazendo um campeonato justo e competitivo, tal recurso só é possível se o usuário cadastrar junto com o jogador suas habilidades a critério do próprio usuário.''',
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: const Icon(
                            Iconsax.arrow_circle_right,
                            size: 25,
                            color: Color(0xffACACAC),
                          ).withRightPadding(rightPadding: 20),
                        ),
                      ),
                      // SettingsDetails(
                      //   label: 'Sugestões',
                      //   widget: GestureDetector(
                      //     onTap: () {
                      //       SystemSound.play(SystemSoundType.click);
                      //       AppDefault.navigateTo(context,
                      //           routeName: '/subscription');
                      //     },
                      //     child: const Icon(
                      //       Iconsax.arrow_circle_right,
                      //       size: 25,
                      //       color: Color(0xffACACAC),
                      //     ).withRightPadding(rightPadding: 20),
                      //   ),
                      // ),
                      SettingsDetails(
                        label: 'Declaração de privacidade',
                        widget: GestureDetector(
                          onTap: () {
                            SystemSound.play(SystemSoundType.click);
                            AppDefault.navigateToWidget(context,
                                widget: const PolityAndPrivacy());
                          },
                          child: const Icon(
                            Iconsax.arrow_circle_right,
                            size: 25,
                            color: Color(0xffACACAC),
                          ).withRightPadding(rightPadding: 20),
                        ),
                      ),
                      SettingsDetails(
                        label: 'Termos de uso',
                        widget: GestureDetector(
                          onTap: () {
                            SystemSound.play(SystemSoundType.click);
                            AppDefault.navigateToWidget(context,
                                widget: const TermsOfConditions());
                          },
                          child: const Icon(
                            Iconsax.arrow_circle_right,
                            size: 25,
                            color: Color(0xffACACAC),
                          ).withRightPadding(rightPadding: 20),
                        ),
                      ),
                    ],
                  ),
                ).withBottomPadding(),
              ),
            ],
          ).withSymPadding(),
        ),
      ),
    );
  }
}
