import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {

  final String title;
  final String content;

  const EmptyPage({Key key, this.title = '', this.content = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(content),
      ),
    );
  }
}
