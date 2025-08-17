import 'package:flutter/material.dart';

class MainImage extends StatelessWidget {
  const MainImage({super.key});

  @override
  Widget build(BuildContext context) {
   const double imageSize=350;
    return Column(
      children: [
        Center(
          child: Image.asset('assets/main_image.webp', height: imageSize, width: imageSize),
        ),
        Center(
          child: Text(
            """
با افتخار و تعهد، سفر خود را در دنیای پرعطر و طعم پسته و زعفران اصیل ایرانی آغاز می‌کنیم.

از امروز به بعد، اینجا خانه‌ شماست برای کشف:

✓ اصالت و تازگی

✓ عطر و رنگ بی‌مثال
""",
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
