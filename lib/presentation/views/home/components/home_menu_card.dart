import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../commons/style/application_colors.dart';

class HomeMenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function()? onTap;

  const HomeMenuCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: ApplicationColors().cardBackground.withAlpha(240),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: ApplicationColors().cardShadow.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            Icon(
              icon,
              color: ApplicationColors().primaryColor.withAlpha(160),
              size: 40,
            ),
            SizedBox(width: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Text(
                        title,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Divider(
                      color: ApplicationColors().primaryColor.withAlpha(160),
                      thickness: 0.4,
                    ),
                    Expanded(
                      child: Text(
                        subtitle,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: ApplicationColors().cinza,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: ApplicationColors().primaryColor,
              size: 20,
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
