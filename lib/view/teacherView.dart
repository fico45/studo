import 'package:flutter/material.dart';


class TeachersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      appBar: new AppBar(
        title: new Text('Classes'),
      ),
      body: new Center(
        child: new Text('This is where TeachersView will be',
            style: new TextStyle(fontSize: 24.0)),
      ),
    );
  }
}
