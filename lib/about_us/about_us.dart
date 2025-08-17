import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  AboutUs({super.key});

  final String info = """
شرکت باران با رویکردی تخصصی در حوزه تأمین، فرآوری و صادرات پسته و زعفران ایرانی فعالیت می‌کند.

این مجموعه با تکیه بر تجربه و دانش فنی در زنجیره تولید و صادرات محصولات کشاورزی، مأموریت خود را بر پایه ارائه محصولات باکیفیت، قابل‌اعتماد و منطبق با استانداردهای بین‌المللی بنا نهاده است.

محصولات باران از مزارع و باغات منتخب در ایران تأمین می‌شوند و با استفاده از روش‌های علمی و سیستم‌های کنترل کیفیت، تحت نظارت دقیق فرآوری و بسته‌بندی می‌گردند.

این فرایند تضمین می‌کند که مشتریان ما در بازارهای داخلی و خارجی، محصولی اصیل، سالم و منطبق با نیازهای روز دریافت نمایند.

ما در باران بر اصول شفافیت، مسئولیت‌پذیری و تعهد به کیفیت پایبند هستیم و همواره تلاش می‌کنیم تا به‌عنوان شریک تجاری قابل‌اتکا، پاسخ‌گوی نیاز مشتریان و همکاران تجاری خود باشیم.
""";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return  // اضافه کردن SingleChildScrollView
       Padding(
         padding:  const EdgeInsets.symmetric(horizontal: 50),
         child: Column(
          children: [
         
            SizedBox(height: 12 ,),
            // تیتر
            Text(
              'درباره ما',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
         
            // متن
            Text(
              info,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                height: 1.9,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.justify,
            ),
          ],
             ),
       );
  }
}
