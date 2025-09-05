import 'package:flutter/material.dart';
import 'package:baran_nuts/l10n/app_localizations.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final loc = AppLocalizations.of(context);
  final locale = Localizations.localeOf(context).languageCode; 
  final TextDirection isRTL = (locale == 'fa') ? TextDirection.rtl : TextDirection.ltr;

  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 12),

        // Title
        Text(
          loc.aboutTitle,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 24),

        // Information
        Text(
          loc.aboutInfo,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            height: 1.9,
            color: Colors.grey[800],
          ),
          textAlign: locale == 'fa' ? TextAlign.justify : TextAlign.left,
          textDirection: isRTL ,
        ),
      ],
    ),
  );
}

}
