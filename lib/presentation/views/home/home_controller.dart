import 'package:flutter/foundation.dart';

class HomeController extends ChangeNotifier {
  // Método init
  void init() {
    print('HomeController.init');
  }

  // Método dispose
  @override
  void dispose() {
    // Coloque aqui o código para limpar os recursos do controlador
    print('HomeController.dispose');
    super.dispose();
  }
}
