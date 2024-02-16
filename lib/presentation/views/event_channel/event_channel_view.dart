import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/services/channels/exempo_event_channel_service.dart';

class EventChannelWidget extends StatefulWidget {
  const EventChannelWidget({Key? key}) : super(key: key);

  @override
  EventChannelWidgetState createState() => EventChannelWidgetState();
}

class EventChannelWidgetState extends State<EventChannelWidget> {
  var exemploEventChannelService = ExemploEventChannelService();
  final TextEditingController _controller =
      TextEditingController(text: 'Nome do Evento');

  late StreamSubscription<dynamic> streamSubscription;
  String eventData = '';

  @override
  void initState() {
    super.initState();

    // Inscrevo o stream
    streamSubscription =
        exemploEventChannelService.receiveBroadcastStream().listen((event) {
      setState(() {
        eventData = event;
      });
    });
  }

  @override
  void dispose() {
    // Cancelo a inscrição do stream
    streamSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          children: [
            Text(
              'Event Channel',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            Text(
              'Retornando Stream do Android Nativo',
              softWrap: true,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[800],
        centerTitle: true,
        elevation: 2, // Remover sombra do AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 300,
                child: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: '',
                    isDense: true,
                    label: Text('Parâmetro (Nome do Evento)'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const Text(
              'Resultado enviado pelo channel:',
            ),
            Text(eventData),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    await exemploEventChannelService.alterarEvento();
                    setState(() {});
                  },
                  child: const Text('Alterar Tipo do Evento'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () async {
                    await exemploEventChannelService.alterarEventoNome(
                      nomeEvento: _controller.text,
                    );
                    setState(() {});
                  },
                  child: const Text('Alterar TIpo e Nome do Evento'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
