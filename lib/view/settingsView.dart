import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Settings'),
      ),
      body: new Center(
        child: new Text('This is where Settings will be',
            style: new TextStyle(fontSize: 24.0)),
      ),
    );
  }
}
