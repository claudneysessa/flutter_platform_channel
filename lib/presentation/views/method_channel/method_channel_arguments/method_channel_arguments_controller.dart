import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../infrastructure/services/channels/exempo_method_channel_service.dart';

class MethodChannelArgumentsController extends ChangeNotifier {
  ExemploMethodChannelService service = ExemploMethodChannelService();

  String channelResult = '';
  TextEditingController textEditingController =
      TextEditingController(text: 'Visitante');
}
