import 'package:flutter/material.dart';
import 'package:studo/view/forms/newExam.dart';

class ExamView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> NewExam()));
          
        },
        child: Icon(Icons.add),
      ),
      appBar: new AppBar(
        title: new Text('Classes'),
      ),
      body: new Center(
        child: new Text('This is where ExamView will be',
            style: new TextStyle(fontSize: 24.0)),
      ),
    );
  }
}
