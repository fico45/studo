import 'package:flutter/material.dart';

class NewExam extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewExamState();
  }
}

class NewExamState extends State{
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       appBar: new AppBar(
        title: new Text('New Exam'),
      ),
      body: new Center(
        child: new Text('This is where NewExam will be',
            style: new TextStyle(fontSize: 24.0)),
      ),
    );
  }

  
}