import 'package:flutter/foundation.dart';
import 'package:flutter_channel/infrastructure/services/channels/exempo_method_channel_service.dart';

class MethodChannelSimpleController extends ChangeNotifier {
  ExemploMethodChannelService service = ExemploMethodChannelService();
  String channelResult = '';
}
