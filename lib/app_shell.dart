import 'package:baran_nuts/side_panel.dart';
import 'package:flutter/material.dart';
import 'package:baran_nuts/l10n/app_localizations.dart';
import 'package:baran_nuts/main.dart'; // برای MyApp.of(context)

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Breakpoints
  static const double kBreakpointLarge = 1200;

  // Dedicated controllers
  final ScrollController _drawerCtrl = ScrollController(); // Drawer (small)
  final ScrollController _leftCtrl   = ScrollController(); // Left panel (large)
  final ScrollController _bodyCtrl   = ScrollController(); // Center content

  @override
  void dispose() {
    _drawerCtrl.dispose();
    _leftCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  void _switchLocale(Locale locale) {
    MyApp.of(context)?.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final loc         = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLarge     = screenWidth >= kBreakpointLarge;
    final scheme      = Theme.of(context).colorScheme;
    final current     = Localizations.localeOf(context).languageCode; // "fa" | "en"

    // Left panel width
    final leftWidth = screenWidth / 5;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: scheme.surface,

        // AppBar: همیشه نمایش داده شود؛ در حالت کوچک دکمه‌ی منو دارد
        appBar: AppBar(
          title: Text(loc.appTitle),
          leading: isLarge
              ? null
              : IconButton(
                  tooltip: loc.menuTooltip,
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
          actions: [
            // دکمه تغییر زبان
            _LangSwitcher(
              currentCode: current,
              onSelected: (code) {
                if (code == 'fa') _switchLocale(const Locale('fa'));
                if (code == 'en') _switchLocale(const Locale('en'));
              },
            ),
          ],
        ),

        drawer: isLarge
            ? null
            : Drawer(
                child: SafeArea(
                  child: SizedBox(
                    width: leftWidth,
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Scrollbar(
                        controller: _drawerCtrl,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          controller: _drawerCtrl,
                          padding: const EdgeInsets.all(12),
                          child: const SidePanel(compact: true),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

        body: isLarge
            ? _LargeLayout(
                leftWidth: leftWidth,
                child: widget.child,
                leftCtrl: _leftCtrl,
                bodyCtrl: _bodyCtrl,
              )
            : _SmallLayout(
                child: widget.child,
                bodyCtrl: _bodyCtrl,
              ),
      ),
    );
  }
}

/// دکمه‌ی انتخاب زبان در AppBar
class _LangSwitcher extends StatelessWidget {
  const _LangSwitcher({
    required this.currentCode,
    required this.onSelected,
  });

  final String currentCode;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return PopupMenuButton<String>(
      tooltip: loc.changeLanguage,
      icon: const Icon(Icons.language),
      onSelected: onSelected,
      itemBuilder: (context) => [
        CheckedPopupMenuItem(
          value: 'fa',
          checked: currentCode == 'fa',
          child: Text(loc.langFa),
        ),
        CheckedPopupMenuItem(
          value: 'en',
          checked: currentCode == 'en',
          child: Text(loc.langEn),
        ),
      ],
    );
  }
}

/// Small screen: content scrolls; side panel is in Drawer
class _SmallLayout extends StatelessWidget {
  const _SmallLayout({
    required this.child,
    required this.bodyCtrl,
  });
  final Widget child;
  final ScrollController bodyCtrl;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Directionality( // scrollbar on the right side
        textDirection: TextDirection.ltr,
        child: Scrollbar(
          controller: bodyCtrl,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: bodyCtrl,
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: h - kToolbarHeight),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Large screen: two columns — left panel + center content
class _LargeLayout extends StatelessWidget {
  const _LargeLayout({
    required this.child,
    required this.leftWidth,
    required this.leftCtrl,
    required this.bodyCtrl,
  });

  final Widget child;
  final double leftWidth;
  final ScrollController leftCtrl;
  final ScrollController bodyCtrl;

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    final scheme = theme.colorScheme;

    return Directionality( // enforce LTR for row order (left panel first)
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          // Left column: side panel with its own scroll
          SizedBox(
            width: leftWidth,
            child: Card(
              elevation: 3,
              color: scheme.surface,
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: SidePanel(
                controller: leftCtrl,
              ),
            ),
          ),

          // Center column: route content with independent scroll
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Scrollbar(
                controller: bodyCtrl,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: bodyCtrl,
                  padding: const EdgeInsets.all(16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
