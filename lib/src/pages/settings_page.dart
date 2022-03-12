import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final String title;

  const SettingsPage({Key? key, required this.title}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.title),
    );
  }
}
