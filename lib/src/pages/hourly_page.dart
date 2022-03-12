import 'package:flutter/material.dart';

class HourlyPage extends StatefulWidget {
  final String title;

  const HourlyPage({Key? key, required this.title}) : super(key: key);

  @override
  State<HourlyPage> createState() => _HourlyPageState();
}

class _HourlyPageState extends State<HourlyPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.title),
    );
  }
}
