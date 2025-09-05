import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:baran_nuts/l10n/app_localizations.dart';

class MenuItem {
  final String title;
  final String route;
  const MenuItem(this.title, this.route);
}

class SidePanel extends StatelessWidget {
  const SidePanel({
    super.key,
    this.profileName = 'Baran Abrishami',
    this.subtitle, // ترجمه از loc می‌آید؛ اگر بخواهی می‌توانی دستی هم بدهی
    ImageProvider? profileImage,
    this.items,    // اگر null باشد از منوی محلی‌سازی‌شده استفاده می‌کنیم
    this.compact = false,
    this.phone = '09152111490',
    this.address = 'خراسان رضوی، کاشمر',
    this.email = 'baran.nuts.intl@gmail.com',
    this.instagramUsername = 'baran_nuts.co',
    this.controller,
  }) : profileImage = profileImage ?? const AssetImage('assets/avatar.png');

  // Profile/menu
  final String profileName;
  final String? subtitle;
  final ImageProvider profileImage;
  final List<MenuItem>? items;
  final bool compact;

  // Contacts
  final String phone;
  final String address;
  final String email;
  final String instagramUsername;

  // Optional external controller for Scrollbar/ScrollView
  final ScrollController? controller;

  bool _isSelected(String current, String route) {
    if (route == '/') return current == '/';
    return current == route || current.startsWith('$route/');
  }

  Future<void> _safeLaunch(Uri uri, {bool inApp = false}) async {
    final mode = inApp ? LaunchMode.inAppWebView : LaunchMode.externalApplication;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: mode);
    }
  }

  Future<void> _launchPhone() async => _safeLaunch(Uri(scheme: 'tel', path: phone));
  Future<void> _launchEmail(BuildContext context) async {
    final loc = AppLocalizations.of(context);
    await _safeLaunch(Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': loc.emailSubjectWebsite},
    ));
  }

  Future<void> _launchInstagram() async {
    final appUri = Uri.parse('instagram://user?username=$instagramUsername');
    final webUri = Uri.parse('https://instagram.com/$instagramUsername');
    if (await canLaunchUrl(appUri)) {
      await _safeLaunch(appUri);
    } else {
      await _safeLaunch(webUri, inApp: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final location = GoRouterState.of(context).uri.toString();
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    // منوی محلی‌سازی‌شده پیش‌فرض (اگر items پاس داده نشده باشد)
    final localizedItems = <MenuItem>[
      MenuItem(loc.menuHome, '/'),
      MenuItem(loc.menuAbout, '/about'),
      MenuItem(loc.menuWorkWithUs, '/WithUs'),
    ];
    final effectiveItems = items ?? localizedItems;

    // زیرعنوان (اگر بیرون مقدار ندادی از ترجمه استفاده می‌کنیم)
    final effectiveSubtitle = subtitle ?? loc.sideSubtitle;

    // Menu list — no internal scroll (let parent scroll)
    final menuList = ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: effectiveItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 6),
      itemBuilder: (context, index) {
        final item = effectiveItems[index];
        final selected = _isSelected(location, item.route);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: _MenuTile(
            title: item.title,
            selected: selected,
            rtl: isRTL,
            onTap: () => context.go(item.route),
          ),
        );
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );

    final contactSection = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ContactTile(icon: Icons.phone, label: loc.contactCall, value: phone, onTap: _launchPhone),
        _ContactTile(faIcon: FontAwesomeIcons.instagram, label: loc.contactInstagram, value: instagramUsername, onTap: _launchInstagram),
        _ContactTile(icon: Icons.email, label: loc.contactEmail, value: email, onTap: () => _launchEmail(context)),
        _ContactTile(icon: Icons.location_pin, label: loc.contactAddress, value: address),
      ],
    );

    // Panel inner content (no scroll here)
    final inner = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 6),
        CircleAvatar(
          radius: 44,
          backgroundColor: theme.colorScheme.surface,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: profileImage,
            backgroundColor: Colors.grey[300],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          profileName,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          effectiveSubtitle,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.black54, height: 1.4),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Divider(color: Colors.grey[300]),
        const SizedBox(height: 8),
        menuList,
        const SizedBox(height: 8),
        Divider(color: Colors.grey[300]),
        const SizedBox(height: 12),
        contactSection,
        const SizedBox(height: 12),
      ],
    );

    // If compact (in Drawer), parent provides scroll + scrollbar → return just content
    if (compact) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          width: double.infinity,
          child: inner,
        ),
      );
    }

    // Non-compact: provide internal scroll + scrollbar with given controller
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: double.infinity,
          child: Directionality(
            textDirection: TextDirection.ltr, // scrollbar on the right
            child: Scrollbar(
              controller: controller,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: controller,
                padding: EdgeInsets.zero,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Directionality(
                    textDirection: TextDirection.rtl, // content stays RTL
                    child: inner,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MenuTile extends StatefulWidget {
  const _MenuTile({required this.title, this.selected = false, required this.rtl, this.onTap});
  final String title;
  final bool selected;
  final bool rtl;
  final VoidCallback? onTap;
  @override
  State<_MenuTile> createState() => _MenuTileState();
}

class _MenuTileState extends State<_MenuTile> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = widget.selected;
    final chevron = widget.rtl ? Icons.chevron_left : Icons.chevron_right;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: selected
            ? theme.colorScheme.surface
            : (_hovered ? theme.colorScheme.surface : Colors.grey[50]),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? const Color(0xFFE9E9E9) : Colors.transparent,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: widget.onTap,
        onHover: (h) => setState(() => _hovered = h),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: selected ? theme.colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              Icon(chevron, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData? icon;
  final IconData? faIcon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ContactTile({this.icon, this.faIcon, required this.label, required this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final leadingIcon = faIcon != null ? FaIcon(faIcon, size: 20) : Icon(icon, size: 22);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            child: Row(
              children: [
                leadingIcon,
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        label,
                        style: TextStyle(color: Colors.grey[700], fontSize: 12),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        value,
                        style: theme.textTheme.titleMedium?.copyWith(fontSize: 14),
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                if (onTap != null) const Icon(Icons.open_in_new, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
