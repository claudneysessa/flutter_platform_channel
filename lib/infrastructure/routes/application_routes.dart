import 'package:flutter/material.dart';

import '../../presentation/views/basic_message_channel/basic_message_channel_view.dart';
import '../../presentation/views/event_channel/event_channel_view.dart';
import '../../presentation/views/home/home_view.dart';
import '../../presentation/views/method_channel/method_channel_arguments/method_channel_arguments_view.dart';
import '../../presentation/views/method_channel/method_channel_simple/method_channel_simple_view.dart';
import '../../presentation/views/method_channel/method_channel_view.dart';

Map<String, Widget Function(BuildContext)> applicationRoutes = {
  '/': (context) => HomeView(),
  '/method_channel': (context) => MethodChannelView(),
  '/method_channel/simple': (context) => MethodChannelSimpleView(),
  '/method_channel/arguments': (context) => MethodChannelArgumentsView(),
  '/event_channel': (context) => EventChannelWidget(),
  '/basic_message_channel': (context) => BasicMessageChannelWidget(),
};
