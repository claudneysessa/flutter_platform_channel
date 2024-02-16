import 'package:flutter/material.dart';
import 'package:flutter_channel/commons/style/application_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFooter extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const CustomFooter({
    Key? key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ApplicationColors().primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: ApplicationColors().cardShadow.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title ?? 'Desenvolvido por:',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: ApplicationColors().branco,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4), // Add some space between the title and subtitle
          Text(
            subtitle ?? 'Claudney Sarti Sessa',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: ApplicationColors().branco,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
