// lib/home/home_main_content.dart
import 'package:baran_nuts/home/widget/main_image.dart';
import 'package:flutter/material.dart';

class HomeMainContent extends StatelessWidget {
  const HomeMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        MainImage(),
        SizedBox(height: 120),
      ],
    );
  }
}
