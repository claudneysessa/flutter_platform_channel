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

#### Service MethodChannel

```dart
import 'package:flutter/services.dart';

class ExemploMethodChannelService {
  var platform = const MethodChannel('br.com.claudneysessa/ExemploMethodChannel');

  ExemploMethodChannelService() {
    platform.setMethodCallHandler(_callbackPlatformChannel);
  }

  Future<String> callSimpleMethodChannel() async => await platform.invokeMethod('getHelloWorld');

  Future<String> callSimpleMethodChannelWithParams(String param) async {
    if (param.isEmpty) return '';
    return await platform.invokeMethod('getHelloWorld', {'message': param});
  }

  Future<void> _callbackPlatformChannel(MethodCall call) async {
    final String args = call.arguments;
    switch (call.method) {
      case 'methodCallback':
        print('Method Channel Callback -> $args');
    }
  }
}

```

No exemplo acima, foi criado um serviço que utiliza o MethodChannel para chamar uma função nativa que retorna uma string.

```dart
var platform = const MethodChannel('br.com.claudneysessa/ExemploMethodChannel');
```

#### Platform MethodChannel

Este é o canal de comunicação que será utilizado para chamar a função nativa neste caso o `java`.

```java
public class ExemploMethodChannel {

  private static final String CHANNEL = "br.com.claudneysessa/ExemploMethodChannel";

  public ExemploMethodChannel(Context context, FlutterEngine flutterEngine) {
    new MethodChannel(
      flutterEngine.getDartExecutor().getBinaryMessenger(),
      CHANNEL
    )
      .setMethodCallHandler(
        new MethodCallHandler() {
          @Override
          public void onMethodCall(MethodCall call, Result result) {
            if ("getHelloWorld".equals(call.method)) {
              String message = call.argument("message");
              if (message == null) {
                result.success("Exemplo de MethodChannel");
              } else {
                result.success("Exemplo de MethodChannel, Texto Concatenado -> " + message);
                new MethodChannel(
                  flutterEngine.getDartExecutor().getBinaryMessenger(),
                  CHANNEL
                )
                  .invokeMethod("methodCallback", "result callback kt");
              }
            } else {
              result.notImplemented();
            }
          }
        }
      );
  }
}
```

## EventChannel

O EventChannel é um canal de comunicação que permite a chamada de funções nativas que retornam um Stream.

No exemplo de utilização do EventChannel, foi criado um serviço que retorna uma string concatenando um nome para o evento e a data e hora atual.

#### Platform Channel (Java Nativo)

```java
public class ExemploEventChannel {

  private static final String CHANNEL_Method = "br.com.claudneysessa/ExemploEventChannelMethos";
  private static final String CHANNEL_Event = "br.com.claudneysessa/ExemploEventChannelEvents";

  private EventSink eventSink;
  private Handler handler;
  private FlutterEngine flutterEngine;

  String nomeEvento = "";
  int tipoEvento = 0;

  public ExemploEventChannel(Context context, FlutterEngine flutterEngine) {

    System.out.println("ExemploEventChannel -> Criando o Channel");

    this.flutterEngine = flutterEngine;

    setupEventChannel();

  }

  private void setupEventChannel() {

    System.out.println("ExemploEventChannel -> Configurando o MethodChannel");

    new MethodChannel(
      flutterEngine.getDartExecutor().getBinaryMessenger(),
      CHANNEL_Method
    )
      .setMethodCallHandler(

        new MethodCallHandler() {

          @Override
          public void onMethodCall(MethodCall call, Result result) {
            switch (call.method) {


              //
              // Altera o Tipo do Evento
              //

              case "alterarEvento":

                alterarEvento();

                break;

              //
              // Altera o Nome do Evento e o Tipo do Evento
              //

              case "alterarEventoNome":

                HashMap map = call.argument("args");
                String nomeParametro = (String) map.get("nomeEvento");

                alterarEventoNome(nomeParametro);

                break;

            }

          }

        }

      );

    System.out.println("ExemploEventChannel -> Configurando o EventChannel");

    EventChannel eventChannel = new EventChannel(
      flutterEngine.getDartExecutor().getBinaryMessenger(),
      CHANNEL_Event
    );

    System.out.println("ExemploEventChannel -> Configurando o CustomStreamHandler");

    eventChannel.setStreamHandler(new CustomStreamHandler());
  }

  public void alterarEvento() {

    System.out.println("ExemploEventChannel -> Alterando o Tipo do Evento");

    if (tipoEvento == 0) {
      tipoEvento = 1;
    } else {
      tipoEvento = 0;
    }

  }

  public void alterarEventoNome(String value) {

    System.out.println("ExemploEventChannel -> Alterando o Nome e o Tipo do Evento");

    nomeEvento = value;

    if (tipoEvento == 0) {
      tipoEvento = 1;
    } else {
      tipoEvento = 0;
    }
  }

  private void cancelEventChannel() {

    System.out.println("ExemploEventChannel -> Cancelando o EventChannel");

    if (eventSink != null) {
      eventSink.endOfStream();
      eventSink = null;
    }

    if (handler != null) {
      handler.removeCallbacksAndMessages(null);
      handler = null;
    }

  }

  private class CustomStreamHandler implements StreamHandler {

    @Override
    public void onListen(Object arguments, EventSink events) {

      eventSink = events;
      handler = new Handler(Looper.getMainLooper());

      System.out.println("ExemploEventChannel -> Iniciando o CustomStreamHandler");

      handler.postDelayed(
        new Runnable() {
          @Override
          public void run() {

            if (eventSink != null) {
              String retornoFuncao = "";

              SimpleDateFormat sdf = new SimpleDateFormat("dd/M/yyyy hh:mm:ss");

              if (tipoEvento == 0) {
                retornoFuncao = nomeEvento + " 1 - " + sdf.format(new Date());
              } else {
                retornoFuncao = nomeEvento + " 2 - " + sdf.format(new Date());
              }

              eventSink.success(retornoFuncao);

              handler.postDelayed(this, 1000);
            }
          }
        },
        0
      );
    }

    @Override
    public void onCancel(Object arguments) {

      System.out.println("ExemploEventChannel -> Solicitando o cancelamento do EventChannel");

      cancelEventChannel();

    }
  }
}
```

Além do MethodChannel Foram adicionados 2 eventos para alterar o tipo de retorno do Stream, sendo eles:

- alterarEvento: Altera o tipo do evento entre 1 e 2
- alterarEventoNome 2: Altera o nome do evento para e o tipo do evento entre 1 e 2

```java

    new MethodChannel(
        flutterEngine.getDartExecutor().getBinaryMessenger(),
        CHANNEL_Method
    )
        .setMethodCallHandler(

        new MethodCallHandler() {

            @Override
            public void onMethodCall(MethodCall call, Result result) {
            switch (call.method) {


                //
                // Altera o Tipo do Evento
                //

                case "alterarEvento":

                alterarEvento();

                break;

                //
                // Altera o Nome do Evento e o Tipo do Evento
                //

                case "alterarEventoNome":

                HashMap map = call.argument("args");
                String nomeParametro = (String) map.get("nomeEvento");

                alterarEventoNome(nomeParametro);

                break;

            }

            }

        }

        );

    public void alterarEvento() {

        System.out.println("ExemploEventChannel -> Alterando o Tipo do Evento");

        if (tipoEvento == 0) {
            tipoEvento = 1;
        } else {
            tipoEvento = 0;
        }

    }

    public void alterarEventoNome(String value) {

        System.out.println("ExemploEventChannel -> Alterando o Nome e o Tipo do Evento");

        nomeEvento = value;

        if (tipoEvento == 0) {
            tipoEvento = 1;
        } else {
            tipoEvento = 0;
        }
    }
```

Estes eventos foram criados em um MethodChannel separado que é chamado a partir do Flutter.

```java
private static final String CHANNEL_Method = "br.com.claudneysessa/ExemploEventChannelMethos";
```

#### Service MethodChannel (Dart/Flutter)

Service no Flutter que chama o MethodChannel que invoca as funções para alterar o tipo de evento e o nome do evento.

```dart
import 'package:flutter/services.dart';

class ExemploEventChannelService {
  late MethodChannel _platformChannel;

  ExemploEventChannelService() {
    _platformChannel = const MethodChannel('br.com.claudneysessa/ExemploEventChannelMethos');
  }

  Future<void> alterarEvento() async {
    _platformChannel.invokeMethod('alterarEvento');
  }

  Future<void> alterarEventoNome({
    String nomeEvento = '',
  }) async {
    _platformChannel.invokeMethod(
      'alterarEventoNome',
      {
        'args': {
          'nomeEvento': nomeEvento,
        }
      },
    );
  }
}

```

#### Platform EventChannel (Java Nativo)

Também foi criado um EventChannel que retorna um Stream com o nome do evento e a data e hora atual.

```java

    private void setupEventChannel() {

    EventChannel eventChannel = new EventChannel(
        flutterEngine.getDartExecutor().getBinaryMessenger(),
        CHANNEL_Event
    );

    eventChannel.setStreamHandler(new CustomStreamHandler());
    }

    private class CustomStreamHandler implements StreamHandler {

        @Override
        public void onListen(Object arguments, EventSink events) {

            eventSink = events;
            handler = new Handler(Looper.getMainLooper());

            System.out.println("ExemploEventChannel -> Iniciando o CustomStreamHandler");

            handler.postDelayed(
            new Runnable() {
                @Override
                public void run() {

                if (eventSink != null) {
                    String retornoFuncao = "";

                    SimpleDateFormat sdf = new SimpleDateFormat("dd/M/yyyy hh:mm:ss");

                    if (tipoEvento == 0) {
                    retornoFuncao = nomeEvento + " 1 - " + sdf.format(new Date());
                    } else {
                    retornoFuncao = nomeEvento + " 2 - " + sdf.format(new Date());
                    }

                    eventSink.success(retornoFuncao);

                    handler.postDelayed(this, 1000);
                }
                }
            },
            0
            );
        }

        @Override
        public void onCancel(Object arguments) {
            cancelEventChannel();
        }
    }
```

#### Service EventChannel (Dart/Flutter)

Service no Flutter que chama o EventChannel que disponibiliza o Stream.

```dart
import 'package:flutter/services.dart';

class ExemploEventChannelService {
  late EventChannel _eventStream;

  ExemploEventChannelService() {
    _eventStream = const EventChannel('br.com.claudneysessa/ExemploEventChannelEvents');
  }

  Stream<dynamic> receiveBroadcastStream() {
    return _eventStream.receiveBroadcastStream();
  }

}
```

#### Service MethodChannel/EventChannel Completo

Como ambos os canais de comunicação estão no mesmo serviço, foi criado um serviço que chama o EventChannel que disponibiliza o Stream e também chama o MethodChannel que invoca as funções para alterar o tipo de evento e o nome do evento.

#### Java Nativo

```java
public class ExemploEventChannel {

  private static final String CHANNEL_Method = "br.com.claudneysessa/ExemploEventChannelMethos";
  private static final String CHANNEL_Event = "br.com.claudneysessa/ExemploEventChannelEvents";

  private EventSink eventSink;
  private Handler handler;
  private FlutterEngine flutterEngine;

  String nomeEvento = "";
  int tipoEvento = 0;

  public ExemploEventChannel(Context context, FlutterEngine flutterEngine) {

    System.out.println("ExemploEventChannel -> Criando o Channel");

    this.flutterEngine = flutterEngine;

    setupEventChannel();

  }

  private void setupEventChannel() {

    System.out.println("ExemploEventChannel -> Configurando o MethodChannel");

    new MethodChannel(
      flutterEngine.getDartExecutor().getBinaryMessenger(),
      CHANNEL_Method
    )
      .setMethodCallHandler(

        new MethodCallHandler() {

          @Override
          public void onMethodCall(MethodCall call, Result result) {
            switch (call.method) {


              //
              // Altera o Tipo do Evento
              //

              case "alterarEvento":

                alterarEvento();

                break;

              //
              // Altera o Nome do Evento e o Tipo do Evento
              //

              case "alterarEventoNome":

                HashMap map = call.argument("args");
                String nomeParametro = (String) map.get("nomeEvento");

                alterarEventoNome(nomeParametro);

                break;

            }

          }

        }

      );

    System.out.println("ExemploEventChannel -> Configurando o EventChannel");

    EventChannel eventChannel = new EventChannel(
      flutterEngine.getDartExecutor().getBinaryMessenger(),
      CHANNEL_Event
    );

    System.out.println("ExemploEventChannel -> Configurando o CustomStreamHandler");

    eventChannel.setStreamHandler(new CustomStreamHandler());
  }

  public void alterarEvento() {

    System.out.println("ExemploEventChannel -> Alterando o Tipo do Evento");

    if (tipoEvento == 0) {
      tipoEvento = 1;
    } else {
      tipoEvento = 0;
    }

  }

  public void alterarEventoNome(String value) {

    System.out.println("ExemploEventChannel -> Alterando o Nome e o Tipo do Evento");

    nomeEvento = value;

    if (tipoEvento == 0) {
      tipoEvento = 1;
    } else {
      tipoEvento = 0;
    }
  }

  private void cancelEventChannel() {

    System.out.println("ExemploEventChannel -> Cancelando o EventChannel");

    if (eventSink != null) {
      eventSink.endOfStream();
      eventSink = null;
    }

    if (handler != null) {
      handler.removeCallbacksAndMessages(null);
      handler = null;
    }

  }

  private class CustomStreamHandler implements StreamHandler {

    @Override
    public void onListen(Object arguments, EventSink events) {

      eventSink = events;
      handler = new Handler(Looper.getMainLooper());

      System.out.println("ExemploEventChannel -> Iniciando o CustomStreamHandler");

      handler.postDelayed(
        new Runnable() {
          @Override
          public void run() {

            if (eventSink != null) {
              String retornoFuncao = "";

              SimpleDateFormat sdf = new SimpleDateFormat("dd/M/yyyy hh:mm:ss");

              if (tipoEvento == 0) {
                retornoFuncao = nomeEvento + " 1 - " + sdf.format(new Date());
              } else {
                retornoFuncao = nomeEvento + " 2 - " + sdf.format(new Date());
              }

              eventSink.success(retornoFuncao);

              handler.postDelayed(this, 1000);
            }
          }
        },
        0
      );
    }

    @Override
    public void onCancel(Object arguments) {

      System.out.println("ExemploEventChannel -> Solicitando o cancelamento do EventChannel");

      cancelEventChannel();

    }
  }
}

```

#### Dart/Flutter

```dart
import 'package:flutter/services.dart';

class ExemploEventChannelService {
  late EventChannel _eventStream;
  late MethodChannel _platformChannel;

  ExemploEventChannelService() {
    _eventStream = const EventChannel('br.com.claudneysessa/ExemploEventChannelEvents');
    _platformChannel = const MethodChannel('br.com.claudneysessa/ExemploEventChannelMethos');
  }

  Stream<dynamic> receiveBroadcastStream() {
    return _eventStream.receiveBroadcastStream();
  }

  Future<void> alterarEvento() async {
    _platformChannel.invokeMethod('alterarEvento');
  }

  Future<void> alterarEventoNome({
    String nomeEvento = '',
  }) async {
    _platformChannel.invokeMethod(
      'alterarEventoNome',
      {
        'args': {
          'nomeEvento': nomeEvento,
        }
      },
    );
  }
}
```

O objetivo deste exemplo foi executar o serviço nativo que fica em execução e alterar o tipo de retorno do Stream mantendo a conexão com o serviço.

### BasicMessageChannel

O BasicMessageChannel é um canal de comunicação que permite a chamada de funções nativas que retornam um Stream semelhante a uma função com retorno do tipo Future.

#### Java Nativo

```java
public class ExemploBasicMessageChannel {

  private static final String CHANNEL =
    "br.com.claudneysessa/ExemploBasicMessageChannel";

  private Handler handler;

  public ExemploBasicMessageChannel(
    Context context,
    FlutterEngine flutterEngine
  ) {

    CustomLogger logger = new CustomLogger();

    logger.info("Criando o Channel");

    ExemploBasicMessageChannel outerInstance = this;

    new BasicMessageChannel<>(
      flutterEngine.getDartExecutor().getBinaryMessenger(),
      CHANNEL,
      StandardMessageCodec.INSTANCE
    )
      .setMessageHandler(

        new BasicMessageChannel.MessageHandler<Object>() {
          @Override
          public void onMessage(
            Object message,
            BasicMessageChannel.Reply<Object> reply
          ) {

            logger.info("Criando o Channel");
            logger.error("Criando o Channel");
            logger.warning("Criando o Channel");
            logger.alert("Criando o Channel");
            logger.log("Criando o Channel");
            logger.printCustomMsgBox("Criando o Channel", "info", CHANNEL);

            HashMap map = (HashMap) message;

            System.out.println(message);

            logger.info("Funcao: " + map.get("funcaoNome"));

            String funcaoNome = (String) map.get("funcaoNome");
            String funcaoParametro = (String) map.get("funcaoParametro");

            switch (funcaoNome) {
              case "obterImagemAndroidAssets":

                logger.info("Executando funcao obterImagemAndroidAssets");

                try {
                  outerInstance.handler = new Handler(Looper.getMainLooper());

                  InputStream inputStream = context
                    .getAssets()
                    .open(funcaoParametro);

                  byte[] imageBytes = new byte[inputStream.available()];

                  inputStream.read(imageBytes);

                  outerInstance.handler.postDelayed(
                    () -> {

                      logger.info("Enviando imagem para o Flutter");

                      reply.reply(imageBytes);

                    },
                    10000
                  );

                } catch (IOException e) {

                  logger.error("Erro ao obter imagem");

                  e.printStackTrace();

                  reply.reply(null);

                }
                break;
            }

          }
        }
      );
  }
}
```

#### Dart/Flutter

Service no Flutter que chama o BasicMessageChannel que invoca a função para obter a imagem da pasta assets do android.

```dart
import 'package:flutter/services.dart';

class ExemploBasicMessageChannelService {
  static const _basicMessageChannel = BasicMessageChannel<dynamic>(
    'br.com.claudneysessa/ExemploBasicMessageChannel',
    StandardMessageCodec(),
  );

  static Future<Uint8List> getImage() async {
    final reply = await _basicMessageChannel.send(
      {
        'funcaoNome': 'obterImagemAndroidAssets',
        'funcaoParametro': 'flutter2.jpg',
      },
    ) as Uint8List?;

    if (reply == null) {
      throw PlatformException(
        code: 'Error',
        message: 'Falha ao buscar imagem no Android',
        details: null,
      );
    }

    return reply;
  }
}
```

No exemplo de utilização do BasicMessageChannel, foi criado um serviço que retorna uma imagem da pasta assets do android e tudo isto após aguardar 10 segundos programados na função.

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
