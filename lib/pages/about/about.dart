import 'package:flutter/material.dart';

import '../home/home_page.dart';

class About extends StatefulWidget {
  @override
  _AboutScreenApp createState() => _AboutScreenApp();
}

class _AboutScreenApp extends State<About> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.blue,
        body: Stack(
          children: [
            Container(
              color: Colors.blue,
              height: 100,
              width: double.infinity,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>Home())
                          );
                        },
                        child: Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 40,)
                    ),
                    Text(
                      'SAIBA MAIS',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

              ),
            ),
            InformacoesLayout(),
          ],
        ),
      );
  }
}

class InformacoesLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 100),
      children: [
        CaixaInformacao(
          titulo: 'Do que se trata o App Give&Get?',
          informacao: 'Give&Get é um aplicativo de doações de aparelhos tecnológicos, focado em pessoas de instituições de ensino que não tenham condições para ter acesso a esses itens. Através de uma doação o doador acumula pontos que poderá trocar por produtos ou serviços de empresas parceiras.',
        ),
        CaixaInformacao(
          titulo: 'Como funciona o Aplicativo?',
          informacao: 'No aplicativo você irá encontrar comunidades, onde você poderá entrar e fazer parte, e, poderá publicar algo que queira doar, ou também poderá demonstrar interesse em algo que esteja sendo doado.',
        ),
        CaixaInformacao(
          titulo: 'Como funciona a pontuação dentro do app?',
          informacao: 'Depois de doar algum aparelho você irá receber pontos universais que poderá ser convertido em produtos, descontos ou serviços pelas empresas parceiras.',
        ),
        CaixaInformacao(
          titulo: 'Como eu faço para me cadastrar?',
          informacao: 'Na tela de acesso clique em "Cadastra-se" e você sera redirecionado a tela de cadastro',
        ),
        CaixaInformacao(
          titulo: 'Como eu posso partcipar de uma comunidade?',
          informacao: 'Dentro do app, depois de realizar o cadastro você poderá participar de alguma comunidade de uma instituição de ensino. Se você fizer parte de alguma instituição cadastrada no app e que possua uma comunidade, orientamos a entrar na comunidade da mesma.',
        ),
        CaixaInformacao(
          titulo: 'Como eu posso doar algo?',
          informacao: 'Dentro das comunidades você poderá publicar algum aparelho que esteja doando e os participantes daquela comunidade poderam demonstrar interesse nesse aparelho.',
        ),
        CaixaInformacao(
          titulo: 'Como eu posso receber uma doação?',
          informacao: 'Após realizar o cadastro e participar de uma comunidade, basta demonstrar interesse em algum aparelho que estiver publicado.',
        ),
        CaixaInformacao(
          titulo: 'Sou uma instituição como faço para me cadastrar?',
          informacao: 'Basta clicar em se cadastrar e escolher a opção sou uma instituição e pronto. Agora é so criar a sua comunidade e receber os doadores e os donatários.',
        ),
      ],
    );
  }
}

class CaixaInformacao extends StatefulWidget {
  final String titulo;
  final String informacao;

  const CaixaInformacao({
    Key? key,
    required this.titulo,
    required this.informacao,
  }) : super(key: key);

  @override
  _CaixaInformacaoState createState() => _CaixaInformacaoState();
}

class _CaixaInformacaoState extends State<CaixaInformacao> {
  bool _exibirInformacao = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            widget.titulo,
            style: TextStyle(
              fontSize: 20.0,
              color: _exibirInformacao ? Colors.white : Colors.white, // Define a cor do texto baseado no estado de expansão
              backgroundColor: Colors.transparent, // Define a cor de fundo baseado no estado de expansão
            ),
          ),
          onTap: () {
            setState(() {
              _exibirInformacao = !_exibirInformacao;
            });
          },
        ),
        if (_exibirInformacao)
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              widget.informacao,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white, // Altera a cor do texto para branco
              ),
            ),
          ),
        Divider(),
      ],
    );
  }
}