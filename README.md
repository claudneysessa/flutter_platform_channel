# flutter_platform_channel

Exemplo de Utilização de Canal de Comunicação entre Flutter e Nativo (Android)

## Project Flutter Version

```bash

    Flutter 3.7.5 • channel stable • https://github.com/flutter/flutter.git
    Framework • revision c07f788888 (11 months ago) • 2023-02-22 17:52:33 -0600
    Engine • revision 0f359063c4
    Tools • Dart 2.19.2 • DevTools 2.20.1

```

## Sobre

Este projeto tem como objetivo demonstrar a utilização de um canal de comunicação entre o Flutter e o Android Nativo.

Em seu desenvolvimento foram feitas as seguintes implementações:

- Chamada ao MethodChannel para execução de uma função nativa
- Chamada ao MethodChannel para execução de uma função nativa passando parâmetros
- Chamada ao EventChannel para execução de uma função nativa que retorna um Stream
- Chamada ao BasicMessageChannel para execução de uma função nativa que retorna um Stream semelhante a uma função com retorno do tipo Future

## Platform Channel

O Platform Channel é um recurso do Flutter que permite a comunicação entre o código Dart e o código nativo (Android, iOS).

O Platform Channel é composto por 3 tipos de canais de comunicação:

- MethodChannel
- EventChannel
- BasicMessageChannel

Abaixo segue a descrição de cada um dos canais de comunicação utilizados neste projeto.

## MethodChannel

O MethodChannel é um canal de comunicação que permite a chamada de funções nativas a partir do Flutter.

No exemplo de utilização do MethodChannel, foi criado um serviço com uma função que retorna uma string podendo esta ser concatenada ou não a uma string informada via argumento para o retorno. Caso seja informando um argumento para a função nativa esta irá retornar a string concatenada com o nome informado.

## EventChannel

O EventChannel é um canal de comunicação que permite a chamada de funções nativas que retornam um Stream.

No exemplo de utilização do EventChannel, foi criado um serviço que retorna uma string concatenando um nome para o evento e a data e hora atual.

### BasicMessageChannel

O BasicMessageChannel é um canal de comunicação que permite a chamada de funções nativas que retornam um Stream semelhante a uma função com retorno do tipo Future.

No exemplo de utilização do BasicMessageChannel, foi criado um serviço que retorna uma imagem direto das libs do android simulando uma espera de 10 segundos.

## Autor

Projeto desenvolvido por Claudney Sarti Sessa

<table>
  <tr>
    <td rowspan="5">
      <img src="https://avatars.githubusercontent.com/u/12506432?v=4" alt="Claudney Sarti Sessa" style="border-radius: 50%; width: 150px; height: 150px;">
    </td>
    <td>GitHub</td>
    <td><a href="https://github.com/claudneysessa">https://github.com/claudneysessa</a></td>
  </tr>
  <tr>
    <td>GitHub Pages</td>
    <td><a href="https://claudneysessa.github.io/">https://claudneysessa.github.io</a></td>
  </tr>
  <tr>
    <td>Instagram</td>
    <td><a href="https://www.instagram.com/claudneysessa/">https://www.instagram.com/claudneysessa</a></td>
  </tr>
  <tr>
    <td>LinkedIn</td>
    <td><a href="https://www.linkedin.com/in/claudneysessa/">https://www.linkedin.com/in/claudneysessa</a></td>
  </tr>
  <tr>
    <td>Gmail</td>
    <td><a href="mailto:claudneysartisessa@gmail.com">claudneysartisessa@gmail.com</a></td>
  </tr>
</table>

## Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](https://github.com/claudneysessa/DartPad/blob/master/LICENSE) para mais detalhes.
