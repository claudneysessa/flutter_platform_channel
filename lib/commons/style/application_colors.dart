import 'package:flutter/material.dart';
import 'package:flutter_channel/commons/functions/create_materialcolor.dart';

class ApplicationColors {
  final Color _primaryColor = Color.fromARGB(255, 31, 112, 33);
  final Color _background = Color.fromARGB(255, 212, 210, 210);
  final Color _cardBackground = Color.fromARGB(255, 245, 244, 244);

  final Color _cardShadow = Color(0xFF0a0a0a);
  final Color _darkPrimary = Color(0xFF1f1a24);
  final Color _dark = Color(0xFF1f1b24);

  final Color _cinza = Colors.grey;
  final Color _branco = Colors.white;

  late final MaterialColor primaryColor;
  late final MaterialColor background;
  late final MaterialColor cardBackground;

  late final MaterialColor cardShadow;
  late final MaterialColor darkPrimary;
  late final MaterialColor dark;

  late final MaterialColor cinza;
  late final MaterialColor branco;

  // Criação da instância estática privada
  static final ApplicationColors _instance = ApplicationColors._internal();

  // Construtor de fábrica
  factory ApplicationColors() {
    return _instance;
  }

  // Construtor interno
  ApplicationColors._internal() {
    primaryColor = createMaterialColor(_primaryColor);
    background = createMaterialColor(_background);
    cardBackground = createMaterialColor(_cardBackground);
    cardShadow = createMaterialColor(_cardShadow);
    darkPrimary = createMaterialColor(_darkPrimary);
    dark = createMaterialColor(_dark);
    cinza = createMaterialColor(_cinza);
    branco = createMaterialColor(_branco);
  }
}
