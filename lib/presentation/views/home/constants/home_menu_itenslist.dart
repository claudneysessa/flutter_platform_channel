import 'package:flutter/material.dart';

List<Map<String, dynamic>> homeMenuItensList = [
  {
    "title": "Method Channel",
    "subtitle":
        "O MethodChannel é uma classe que fornece um canal nomeado para a comunicação entre o código Dart do Flutter e o código nativo.",
    "icon": Icons.android,
    "route": "/method_channel",
  },
  {
    "title": "Event Channel",
    "subtitle":
        "O EventChannel no é uma classe que fornece um canal nomeado para a comunicação entre o código Dart do Flutter e o código nativo usando fluxos de eventos.",
    "icon": Icons.event,
    "route": "/event_channel",
  },
  {
    "title": "Basic Message Channel",
    "subtitle":
        "O BasicMessageChannel é uma classe que fornece um canal nomeado para a comunicação entre o código Dart do Flutter e o código nativo usando a passagem de mensagens assíncronas.",
    "icon": Icons.message,
    "route": "/basic_message_channel",
  },
];
