import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuItem {
  final String title;
  final String route;
  const MenuItem(this.title, this.route);
}

class SidePanel extends StatelessWidget {
  const SidePanel({
    super.key,
    this.profileName = 'Baran Abrishami',
    this.subtitle = 'صادرات و فروش تخصصی پسته و زعفران با کیفیت',
    ImageProvider? profileImage,
    this.items = const [
      MenuItem('خانه', '/'),
      MenuItem('درباره ما', '/about'),
      MenuItem('دعوت به مشارکت', '/WithUs'),
    ],
    this.compact = false,           // compact=true → no internal scroll (used in Drawer)
    this.phone = '09152111490',
    this.address = 'خراسان رضوی، کاشمر',
    this.email = 'baran.nuts.intl@gmail.com',
    this.instagramUsername = 'baran_nuts.co',
    this.controller,                // external scroll controller (non-compact)
  }) : profileImage = profileImage ?? const AssetImage('assets/avatar.png');

  // Profile/menu
  final String profileName;
  final String subtitle;
  final ImageProvider profileImage;
  final List<MenuItem> items;
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
  Future<void> _launchEmail() async => _safeLaunch(Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {'subject': 'تماس از وب‌سایت'},
      ));
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
    final location = GoRouterState.of(context).uri.toString();

    // Menu list — no internal scroll (let parent scroll)
    final menuList = ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 6),
      itemBuilder: (context, index) {
        final item = items[index];
        final selected = _isSelected(location, item.route);
        return _MenuTile(
          title: item.title,
          selected: selected,
          onTap: () => context.go(item.route),
        );
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );

    final contactSection = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Text('راه‌های ارتباطی', style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
        // const SizedBox(height: 16),
        _ContactTile(icon: Icons.phone, label: 'تماس', value: phone, onTap: _launchPhone),
        _ContactTile(faIcon: FontAwesomeIcons.instagram, label: 'اینستاگرام', value: instagramUsername, onTap: _launchInstagram),
        _ContactTile(icon: Icons.email, label: 'ایمیل', value: email, onTap: _launchEmail),
        _ContactTile(icon: Icons.location_pin, label: 'آدرس', value: address),
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
          subtitle,
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
              controller: controller,          // must match the scroll view's controller
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: controller,        // attach the same controller
                padding: EdgeInsets.zero,
                child: ConstrainedBox(
                  // minHeight = viewport height so panel fills full column
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
  const _MenuTile({required this.title, this.selected = false, this.onTap});
  final String title;
  final bool selected;
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
              const Icon(Icons.chevron_left, size: 18),
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
