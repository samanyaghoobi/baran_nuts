import 'package:baran_nuts/about_us/about_us.dart';
import 'package:baran_nuts/app_shell.dart';
import 'package:baran_nuts/home/home_main_content.dart';
import 'package:baran_nuts/working_with_us/woorking.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


// AppShell جدید در مسیر layout/

/// کانفیگ اصلی GoRouter
final GoRouter appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        // شِل ثابت: ستون چپ SidePanel + محتوای وسط
        return AppShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const PageWithLoading(
            child: HomeMainContent(),
          ),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) =>  PageWithLoading(
            child: AboutUs(),
          ),
        ),
        GoRoute(
          path: '/WithUs',
          builder: (context, state) =>  PageWithLoading(
            child: WorkingWithUs(),
          ),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) =>
      const PageWithLoading(child: HomeMainContent()),
);

/// رپر کوچک برای نمایش لودر کوتاه قبل از هر صفحه
class PageWithLoading extends StatefulWidget {
  final Widget child;
  const PageWithLoading({super.key, required this.child});

  @override
  State<PageWithLoading> createState() => _PageWithLoadingState();
}

class _PageWithLoadingState extends State<PageWithLoading> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => _loading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return widget.child;
  }
}
