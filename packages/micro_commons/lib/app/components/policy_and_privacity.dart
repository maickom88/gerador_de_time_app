import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micro_core/core/theme/theme.dart';

class PolityAndPrivacy extends StatefulWidget {
  const PolityAndPrivacy({Key? key}) : super(key: key);

  @override
  State<PolityAndPrivacy> createState() => _PolityAndPrivacyState();
}

class _PolityAndPrivacyState extends State<PolityAndPrivacy> {
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
                  'Política de Privacidade',
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
                const Text(
                  '''Michael Frank Dev criou o aplicativo Gerador de Times como um aplicativo gratuito. Este SERVIÇO é fornecido por Michael Frank Dev sem nenhum custo e destina-se ao uso como está.

Esta página é usada para informar os visitantes sobre minhas políticas de coleta, uso e divulgação de Informações Pessoais se alguém decidir usar meu Serviço.

Se você optar por usar meu Serviço, concorda com a coleta e uso de informações em relação a esta política. As Informações Pessoais que eu coleto são usadas para fornecer e melhorar o Serviço. Não usarei ou compartilharei suas informações com ninguém, exceto conforme descrito nesta Política de Privacidade.

Os termos utilizados nesta Política de Privacidade têm os mesmos significados que em nossos Termos e Condições, que estão acessíveis em Gerador de Times, salvo definição em contrário nesta Política de Privacidade.

Coleta e uso de informações

Para uma melhor experiência, ao usar nosso Serviço, posso exigir que você nos forneça determinadas informações de identificação pessoal. As informações que eu solicitar serão retidas no seu dispositivo e não serão coletadas por mim de forma alguma.

O aplicativo usa serviços de terceiros que podem coletar informações usadas para identificá-lo.

Link para a política de privacidade de provedores de serviços terceirizados usados ​​pelo aplicativo''',
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
                const Text(
                  '''Dados de registro



Quero informar que sempre que você usar meu Serviço, em caso de erro no aplicativo, coleto dados e informações (através de produtos de terceiros) em seu telefone chamado Log Data. Esses Dados de Registro podem incluir informações como o endereço do Protocolo de Internet (“IP”) do seu dispositivo, nome do dispositivo, versão do sistema operacional, a configuração do aplicativo ao utilizar meu Serviço, a hora e a data de seu uso do Serviço e outras estatísticas .



Biscoitos



Cookies são arquivos com uma pequena quantidade de dados que são comumente usados ​​como identificadores exclusivos anônimos. Eles são enviados para o seu navegador a partir dos sites que você visita e são armazenados na memória interna do seu dispositivo.

Este Serviço não usa esses “cookies” explicitamente. No entanto, o aplicativo pode usar código de terceiros e bibliotecas que usam “cookies” para coletar informações e melhorar seus serviços. Você tem a opção de aceitar ou recusar esses cookies e saber quando um cookie está sendo enviado ao seu dispositivo. Se você optar por recusar nossos cookies, talvez não consiga usar algumas partes deste Serviço.''',
                ),
                const Text(
                  '''Service Providers



I may employ third-party companies and individuals due to the following reasons:''',
                ),
                const Text(
                  'Se você tiver alguma dúvida ou sugestão sobre meus Termos e Condições, não hesite em me contatar em maickomtutos@gmail.com.',
                ).withBottomPadding(),
                const Bullet('Para facilitar nosso Serviço;'),
                const Bullet('Para fornecer o Serviço em nosso nome;'),
                const Bullet(
                    'Para executar serviços relacionados ao Serviço; ou'),
                const Bullet(
                        'Para nos ajudar a analisar como nosso Serviço é usado.')
                    .withBottomPadding(),
                const Text(
                        '''I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.



Security



I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.



Links to Other Sites



This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.



Children’s Privacy



These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.



Changes to This Privacy Policy



I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.

This policy is effective as of 2022-06-25



Contact Us



If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at maickomtutos@gmail.com.''')
                    .withBottomPadding(),
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
