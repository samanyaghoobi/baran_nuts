import 'package:baran_nuts/side_pandel.dart';
import 'package:flutter/material.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Breakpoints
  static const double kBreakpointLarge = 1200; // ≥ large => two columns

  // Dedicated controllers
  final ScrollController _drawerCtrl = ScrollController();   // Drawer (small)
  final ScrollController _leftCtrl   = ScrollController();   // Left panel (large)
  final ScrollController _bodyCtrl   = ScrollController();   // Center content (small & large)

  @override
  void dispose() {
    _drawerCtrl.dispose();
    _leftCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLarge = screenWidth >= kBreakpointLarge;
    final scheme = Theme.of(context).colorScheme;

    // Left panel width = 1/3 of screen
    final leftWidth = screenWidth / 3;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: scheme.surface,

        appBar: isLarge
            ? null
            : AppBar(
                title: const Text('Baran'),
                leading: IconButton(
                  tooltip: 'Menu',
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
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
                leftWidth: leftWidth,  // dynamic instead of constant
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

/// Small screen: content scrolls; side panel is in Drawer (above)
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
            controller: bodyCtrl, // attach controller
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              // min height = viewport - appbar to avoid short pages
              constraints: BoxConstraints(minHeight: h - kToolbarHeight),
              child: Directionality( // actual content remains RTL
                textDirection: TextDirection.rtl,
                child: child, // no Align wrapper to avoid overflow with Columns
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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Directionality( // enforce left-to-right for row order (left panel first)
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          // Left column: combined side panel with its own scroll
          SizedBox(
            width: leftWidth,
            child: Card(
              elevation: 3,
              color: scheme.surface,
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SidePanel(
                  // non-compact → it manages its own internal scroll
                  controller: leftCtrl, // attach controller to panel's Scrollbar
                ),
              ),
            ),
          ),

          // Center column: route content with independent scroll
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr, // scrollbar on the right
              child: Scrollbar(
                controller: bodyCtrl,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: bodyCtrl, // attach controller
                  padding: const EdgeInsets.all(16),
                  child: ConstrainedBox(
                    // min height = viewport to align with left panel height
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl, // actual content RTL
                      child: child, // no Align wrapper to avoid overflows
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
