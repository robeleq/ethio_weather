import 'package:flutter/material.dart';

class WeeklyPage extends StatefulWidget {
  final String title;

  const WeeklyPage({Key? key, required this.title}) : super(key: key);

  @override
  State<WeeklyPage> createState() => _WeeklyPageState();
}

class _WeeklyPageState extends State<WeeklyPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.title),
    );
  }
}
