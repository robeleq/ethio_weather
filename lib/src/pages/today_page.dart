import 'package:flutter/material.dart';

class TodayPage extends StatefulWidget {
  final String title;

  const TodayPage({Key? key, required this.title}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.title),
    );
  }
}
