import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/theme/theme.dart';

class TermsOfConditions extends StatefulWidget {
  const TermsOfConditions({Key? key}) : super(key: key);

  @override
  State<TermsOfConditions> createState() => _TermsOfConditionsState();
}

class _TermsOfConditionsState extends State<TermsOfConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
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
                  'Termos de uso',
                  style: AppTypography.t28WithW800(),
                ),
                border: Border.all(color: Colors.transparent),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Termos & Condições de Uso do Gerador de Times para os usuários',
                    textAlign: TextAlign.center,
                    style: AppTypography.t14()
                        .copyWith(color: AppColor.secondaryLightColor),
                  ),
                ),
                Center(
                  child: Text(
                    'Data de atualização: 15 de julho de 2022',
                    textAlign: TextAlign.center,
                    style:
                        AppTypography.t12().copyWith(color: AppColor.textLight),
                  ),
                ).withBottomPadding(),
                const Text(
                  'Ao baixar ou usar o aplicativo, esses termos se aplicarão automaticamente a você – portanto, certifique-se de lê-los atentamente antes de usar o aplicativo. Você não tem permissão para copiar ou modificar o aplicativo, qualquer parte do aplicativo ou nossas marcas registradas de forma alguma. Você não tem permissão para tentar extrair o código-fonte do aplicativo e também não deve tentar traduzir o aplicativo para outros idiomas ou fazer versões derivadas. O aplicativo em si e todas as marcas registradas, direitos autorais, direitos de banco de dados e outros direitos de propriedade intelectual relacionados a ele ainda pertencem a Michael Frank Dev.',
                ).withBottomPadding(),
                const Bullet('Google Play Services'),
                const Bullet('Google Analytics for Firebase'),
                const Bullet('Firebase Crashlytics').withBottomPadding(),
                const Text(
                    '''Você deve estar ciente de que há certas coisas pelas quais Michael Frank Dev não se responsabilizará. Certas funções do aplicativo exigirão que o aplicativo tenha uma conexão ativa com a Internet. A conexão pode ser Wi-Fi ou fornecida pelo seu provedor de rede móvel, mas Michael Frank Dev não pode se responsabilizar pelo aplicativo não funcionar com funcionalidade total se você não tiver acesso a Wi-Fi e não tiver nenhum dos sua franquia de dados restante.

Se você estiver usando o aplicativo fora de uma área com Wi-Fi, lembre-se de que os termos do contrato com seu provedor de rede móvel ainda se aplicam. Como resultado, você pode ser cobrado pela sua operadora de celular pelo custo dos dados pela duração da conexão durante o acesso ao aplicativo ou outras cobranças de terceiros. Ao usar o aplicativo, você aceita a responsabilidade por tais cobranças, incluindo cobranças de dados de roaming se você usar o aplicativo fora de seu território (ou seja, região ou país) sem desativar o roaming de dados. Se você não for o pagador de contas do dispositivo em que está usando o aplicativo, saiba que assumimos que você recebeu permissão do pagador de contas para usar o aplicativo.

Na mesma linha, Michael Frank Dev nem sempre pode assumir a responsabilidade pela maneira como você usa o aplicativo, ou seja, você precisa garantir que seu dispositivo permaneça carregado - se ficar sem bateria e você não puder ligá-lo para aproveitar o serviço, Michael Frank Dev não pode aceitar responsabilidade.

Com relação à responsabilidade de Michael Frank Dev pelo uso do aplicativo, quando você estiver usando o aplicativo, é importante ter em mente que, embora nos esforcemos para garantir que ele esteja sempre atualizado e correto, confiamos em terceiros para nos fornecer informações para que possamos disponibilizá-las para você. Michael Frank Dev não aceita nenhuma responsabilidade por qualquer perda, direta ou indireta, que você experimente como resultado de confiar totalmente nesta funcionalidade do aplicativo.

Em algum momento, podemos querer atualizar o aplicativo. O aplicativo está atualmente disponível para Android e iOS – os requisitos para ambos os sistemas (e para quaisquer sistemas adicionais para os quais decidirmos estender a disponibilidade do aplicativo) podem mudar, e você precisará baixar as atualizações se quiser manter usando o aplicativo. Michael Frank Dev não promete que sempre atualizará o aplicativo para que seja relevante para você e/ou funcione com a versão Android e iOS que você instalou no seu dispositivo. No entanto, você promete sempre aceitar as atualizações do aplicativo quando oferecidas a você. Também podemos desejar interromper o fornecimento do aplicativo e encerrar o uso dele a qualquer momento sem aviso de rescisão a você. A menos que lhe digamos o contrário, após qualquer rescisão, (a) os direitos e licenças concedidos a você nestes termos terminarão; (b) você deve parar de usar o aplicativo e (se necessário) excluí-lo do seu dispositivo.'''),
                Text(
                  'Alterações a estes Termos e Condições',
                  style: AppTypography.t16WithW800(),
                ),
                const Text(
                  '''Posso atualizar nossos Termos e Condições de tempos em tempos. Assim, recomendamos que você revise esta página periodicamente para quaisquer alterações. Vou notificá-lo sobre quaisquer alterações publicando os novos Termos e Condições nesta página.

Estes termos e condições estão em vigor a partir de 25/06/2022''',
                ),
                Text(
                  'Contate-nos',
                  style: AppTypography.t16WithW800(),
                ),
                const Text(
                  'Se você tiver alguma dúvida ou sugestão sobre meus Termos e Condições, não hesite em me contatar em maickomtutos@gmail.com.',
                ),
              ],
            ).withSymPadding(),
          ),
        ),
      ),
    );
  }
}

class Bullet extends Text {
  const Bullet(
    String data, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
  }) : super(
          '• $data',
          key: key,
          style: style,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
        );
}
