import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import '../styles/colors.dart';

enum _SettingsTileType { simple, switchTile }

class SettingsTile extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? onTap;
  final Function(bool value)? onToggle;
  final bool? switchValue;
  final _SettingsTileType _tileType;

  const SettingsTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.onTap,
  })  : _tileType = _SettingsTileType.simple,
        onToggle = null,
        switchValue = null,
        super(key: key);

  const SettingsTile.switchTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    required this.onToggle,
    required this.switchValue,
  })  : _tileType = _SettingsTileType.switchTile,
        onTap = null,
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(themeChangeNotifierProvider);
    final _theme = themeProvider.getCurrentTheme();

    final Color _titleColor = _theme.brightness == Brightness.light ? lPrimaryTextColor : dPrimaryTextColor;
    final Color _subtitleColor = _theme.brightness == Brightness.light ? Colors.black54 : Colors.white60;

    return androidTile(_theme.scaffoldBackgroundColor, _titleColor, _subtitleColor);
  }

  Widget androidTile(Color backgroundColor, Color titleColor, Color subtitleColor) {
    if (_tileType == _SettingsTileType.switchTile) {
      return Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0), color: Colors.transparent),
          child: SwitchListTile(
            secondary: leading,
            value: switchValue!,
            onChanged: onToggle,
            title: Text(
              title,
              style: TextStyle(color: titleColor),
            ),
            subtitle: subtitle != null ? Text(subtitle!, style: TextStyle(color: subtitleColor)) : null,
          ),
        ),
      );
    } else {
      return Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0), color: Colors.transparent),
          child: ListTile(
            title: Text(title, style: TextStyle(color: titleColor)),
            subtitle: subtitle != null ? Text(subtitle!, style: TextStyle(color: subtitleColor)) : null,
            leading: leading,
            onTap: onTap,
          ),
        ),
      );
    }
  }
}
