import 'package:flutter/material.dart';

class WorkingWithUs extends StatelessWidget {
  WorkingWithUs({super.key});

  // عنوان و لیست همکاری
  final List<String> partners = [
    'صادرکنندگان پسته و زعفران',
    'خریداران بین‌المللی و نمایندگان بازرگانی خارج از کشور',
    'مصرف‌کنندگان عمده (کارخانه‌ها، شرکت‌های بسته‌بندی، کارگاه‌های شیرینی و شکلات‌سازی، صنایع غذایی)',
    'مغازه‌داران و فروشگاه‌های خشکبار',
    'فروشگاه‌های زنجیره‌ای و سوپرمارکت‌های بزرگ',
    'رستوران‌ها، هتل‌ها و کافه‌ها',
    'پخش‌کنندگان و عمده‌فروشان خشکبار',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12 ,),
              // تیتر
              Center(
                child: Text(
                  'دعوت به مشارکت',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),

              // توضیح کوتاه
              Center(
                child: Text(
                  'اگر در یکی از حوزه‌های زیر فعالیت دارید، افتخار می‌کنیم همراه و شریک تجاری شما باشیم:',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    height: 1.9,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // لیست با آیکن
              ...partners.map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.group, color: Colors.black, size: 24),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          // textAlign: TextAlign.center,
                          item,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
