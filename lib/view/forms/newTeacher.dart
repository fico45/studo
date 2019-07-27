import 'package:flutter/material.dart';
import 'package:studo/util/dbhelper.dart';
import 'package:studo/model/teacherModel.dart';

DbHelper helper = DbHelper();

class NewTeacher extends StatefulWidget {
  Teacher teacher;
  @override
  State<StatefulWidget> createState() {
    return NewTeacherState(teacher);
  }
}

class NewTeacherState extends State {
  Teacher teacher = new Teacher();
  NewTeacherState(this.teacher);
  final _teacherController = TextEditingController();
  final _teacherFormKey = GlobalKey<NewTeacherState>();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _teacherController.dispose();
    super.dispose();
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('New Teacher'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Form(
            key: this._teacherFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new TextFormField(
                  controller: _teacherController,
                  decoration: new InputDecoration(
                      hintText: 'Teacher name'),
                  onFieldSubmitted: (value) {
                    teacher.name = _teacherController.text;
                  },
                ),
                new SizedBox(height: 15.0,),
                new RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    _submitForm(_teacherController.text);
                    
                    /*return showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          content: Text(_teacherController.text),
                        );
                      }
                    );*/
                  },
                )
              ],
            )),
      ),
    );
  }

  void _submitForm(String val) {
    Teacher teacher = new Teacher();
    teacher.name=val;
    helper.insertTeacher(teacher);
    dispose();
    Navigator.pop(context, true);
  }
}
