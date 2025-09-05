import 'package:flutter/material.dart';
import 'package:baran_nuts/l10n/app_localizations.dart';

class WorkingWithUs extends StatelessWidget {
  const WorkingWithUs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode; 
    final TextDirection isRTL = (locale == 'fa') ? TextDirection.rtl : TextDirection.ltr;


    final partners = loc.workWithUsList
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // تیتر
            Center(
              child: Text(
                loc.workWithUs, // ← اسم کلید طبق خواسته‌ی تو
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
          textDirection: isRTL ,
              ),
            ),
            const SizedBox(height: 24),

            // زیرتیتر
            Center(
              child: Text(
                loc.workWithUsSubtitle,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                  height: 1.9,
                  color: Colors.grey[800],
                ),
          textDirection: isRTL ,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // لیست با آیکن
            ...partners.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: 
Row(
  mainAxisAlignment: locale == 'fa'
      ? MainAxisAlignment.start 
      : MainAxisAlignment.end,  
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    if (locale == 'fa') ...[
      const Icon(Icons.group, color: Colors.black, size: 24),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          item,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            height: 1.6,
            color: Colors.grey[800],
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    ] else ...[
      Expanded(
        child: Text(
          item,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 16,
            height: 1.6,
            color: Colors.grey[800],
          ),
          textAlign: TextAlign.left,
        ),
      ),
      const SizedBox(width: 8),
      const Icon(Icons.group, color: Colors.black, size: 24),
    ],
  ],
),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
