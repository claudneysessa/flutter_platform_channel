import 'package:flutter/material.dart';
import 'package:flutter_channel/commons/style/application_colors.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget? customAppBar({
  String? title,
  String? subtitle,
  double? toolbarHeight,
  double? elevation,
  bool? centerTitle,
  Color? backgroundColor,
  BuildContext? context,
  Widget? leading,
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    toolbarHeight: toolbarHeight ?? 90,
    title: Column(
      mainAxisAlignment: (centerTitle == true)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title ?? 'Title',
          textAlign: (centerTitle == true) ? TextAlign.center : null,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 24,
            color: ApplicationColors().branco,
          ),
        ),
        Visibility(
          visible: subtitle != null,
          child: Text(
            subtitle ?? 'Exemplo de Subtítulo',
            textAlign: (centerTitle == true) ? TextAlign.center : null,
            softWrap: true,
            maxLines: 2,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: ApplicationColors().branco,
            ),
          ),
        ),
      ],
    ),
    leading: (leading != null)
        ? IconButton(
            onPressed: () {
              if (context != null) {
                Navigator.pop(context);
              }
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          )
        : null,
    actions: (actions != null)
        ? [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.help,
              ),
            ),
          ]
        : null,
    centerTitle: centerTitle ?? false,
    backgroundColor: backgroundColor ?? ApplicationColors().primaryColor,
    elevation: elevation, // Remover sombra do AppBar
    bottom: (bottom != null) ? bottom : null,
  );
}
