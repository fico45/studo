import 'package:flutter/material.dart';
import 'package:studo/widgets/newSubject.dart';

class ClassView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Classes'),
      ),
      body: new Column(
        children: <Widget>[
          new ListTile(
              leading: const Icon(Icons.description),
              title: new TextField(
                decoration: new InputDecoration(hintText: "Class name"),
              )),
          new ListTile(
              leading: const Icon(Icons.details),
              title: new DropdownButtonFormField<String>(
                items: [
                  DropdownMenuItem<String>(
                    value: 'Lab',
                    child: Text('Lab'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Seminar',
                    child: Text('Seminar'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Lecture',
                    child: Text('Lecture'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Lecture',
                    child: Text('Lecture'),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
