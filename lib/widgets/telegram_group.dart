import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/colors.dart';

class GroupUI extends StatelessWidget {
  final String? name;
  final String? link;

  const GroupUI({Key? key, required this.name, required this.link})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: 352,
        height: 110,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.group,
                    color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                    size: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    name!,
                    style: GoogleFonts.roboto(
                      color: ThemeColors.BACKGROUD_COLOR_BOTTOM,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final Uri url = Uri.parse(link!);
                      launchUrl(url,mode: LaunchMode.externalNonBrowserApplication);
                    },
                    child: Text("Join"),
                    style: ElevatedButton.styleFrom(
                      primary: ThemeColors.HOMEBUTTONTHREE, // background
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
