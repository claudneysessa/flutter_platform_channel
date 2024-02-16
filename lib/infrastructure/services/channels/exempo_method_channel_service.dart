import 'package:flutter/services.dart';

class ExemploMethodChannelService {
  var platform =
      const MethodChannel('br.com.claudneysessa/ExemploMethodChannel');

  ExemploMethodChannelService() {
    platform.setMethodCallHandler(_callbackPlatformChannel);
  }

  Future<String> callSimpleMethodChannel() async =>
      await platform.invokeMethod('getHelloWorld');

  Future<String> callSimpleMethodChannelWithParams({String param = ''}) async {
    if (param.isEmpty) return 'Parâmetro não informado!';
    return await platform
        .invokeMethod('getHelloWorld', {'message': param.trim()});
  }

  Future<void> _callbackPlatformChannel(MethodCall call) async {
    final String args = call.arguments;
    switch (call.method) {
      case 'methodCallback':
        print('Method Channel Callback -> $args');
    }
  }
}
