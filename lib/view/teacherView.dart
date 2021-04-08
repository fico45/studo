import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studo/model/teacherModel.dart';
import 'package:studo/widgets/teacher/newTeacher.dart';
import 'package:studo/widgets/teacher/teacher_item.dart';
import '../widgets/app_drawer.dart';

class TeacherView extends StatelessWidget {
  static const routeName = '/teacher-view';

  @override
  Widget build(BuildContext context) {
    final teachersData = Provider.of<Teachers>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(NewTeacher.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: teachersData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              TeacherItem(
                teachersData.items[i].id,
                teachersData.items[i].name,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

/* class TeachersView extends StatefulWidget {
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
 */
