import 'package:flutter/material.dart';
import 'package:flutter_channel/presentation/views/method_channel/method_channel_simple/method_channel_simple_controller.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../commons/style/application_colors.dart';

class MethodChannelSimpleView extends StatefulWidget {
  const MethodChannelSimpleView({super.key});

  @override
  MethodChannelSimpleViewState createState() => MethodChannelSimpleViewState();
}

class MethodChannelSimpleViewState extends State<MethodChannelSimpleView> {
  MethodChannelSimpleController controller = MethodChannelSimpleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ApplicationColors().background[10],
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        'Este exemplo irá invocar um método no Channel e retornar uma mensagem padrão.',
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        softWrap: true,
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        'Mensagem Padrão:',
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        softWrap: true,
                        style: GoogleFonts.inter(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Center(
                      child: Text(
                        '"Olá, este é um exemplo de retorno do MethodChannel."',
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        softWrap: true,
                        style: GoogleFonts.inter(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: ApplicationColors().primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Divider(),
                  ),
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Resultado da Requisição:',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      controller.channelResult,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => ApplicationColors().primaryColor,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () async {
                  controller.channelResult =
                      await controller.service.callSimpleMethodChannel();
                  setState(() {});
                },
                child: Text(
                  'Executar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: ApplicationColors().branco,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
