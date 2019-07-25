import 'package:flutter/material.dart';
import 'package:studo/view/forms/newTeacher.dart';
import 'package:studo/util/dbhelper.dart';

class TeachersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      appBar: new AppBar(
        title: new Text('Teachers'),
      ),
      body: new Center(
        child: new Text('This is where TeachersView will be',
            style: new TextStyle(fontSize: 24.0)),
      ),
    floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => NewTeacher()));
        },
        child: Icon(Icons.add),
      ),
    );
    
  }
}
