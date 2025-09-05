import 'package:baran_nuts/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MainImage extends StatelessWidget {
  const MainImage({super.key});
  @override
  Widget build(BuildContext context) {
  final loc = AppLocalizations.of(context);
  final locale = Localizations.localeOf(context).languageCode; 
  final TextDirection isRTL = (locale == 'fa') ? TextDirection.rtl : TextDirection.ltr;

   const double imageSize=350;
    return Column(
      children: [
        Center(
          child: Image.asset('assets/main_image.webp', height: imageSize, width: imageSize),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:  8.80),
          child: Center(
            child: Text(loc.homeInfo,
            textAlign: locale == 'fa' ? TextAlign.justify : TextAlign.justify,
            textDirection: isRTL ,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
