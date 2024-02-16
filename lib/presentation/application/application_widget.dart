import 'package:flutter/material.dart';
import 'package:flutter_channel/commons/style/application_colors.dart';
import 'package:flutter_channel/infrastructure/routes/application_routes.dart';
import 'package:flutter_channel/presentation/application/application_controller.dart';

class ApplicationWidget extends StatefulWidget {
  final String title = 'ApplicationWidget';

  const ApplicationWidget({Key? key}) : super(key: key);

  @override
  ApplicationWidgetState createState() => ApplicationWidgetState();
}

class ApplicationWidgetState extends State<ApplicationWidget> {
  ApplicationController controller = ApplicationController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Exemplo de Utilização do Method Channel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: ApplicationColors().primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: ApplicationColors().primaryColor,
          iconTheme: IconThemeData(
            color: ApplicationColors().branco,
          ),
        ),
      ),
      routes: applicationRoutes,
      initialRoute: controller.initialRoute,
    );
  }
}
