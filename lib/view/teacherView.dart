import 'package:flutter/material.dart';
import 'package:studo/model/teacherModel.dart';
import 'package:studo/view/forms/newTeacher.dart';
import 'package:studo/util/dbhelper.dart';

DbHelper helper = DbHelper();

class TeachersView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TeacherViewState();
  }
}

class TeacherViewState extends State {
  Teacher teacher = new Teacher();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Teachers'),
      ),
      body: FutureBuilder<List>(
        future: helper.getTeacher(teacher),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            "Teacher name: " + snapshot.data[index].row[1]),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
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
