import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studo/model/classModel.dart';
import 'package:studo/widgets/class/newClass.dart';
import 'package:studo/widgets/class/class_item.dart';
import '../widgets/app_drawer.dart';
import 'package:studo/model/subjectModel.dart';

class ClassView extends StatelessWidget {
  static const routeName = '/class-view';

  @override
  Widget build(BuildContext context) {
    final classData = Provider.of<Classes>(context);
    final subjectData = Provider.of<Subjects>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classes'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(NewClass.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: classData.items.length,
            itemBuilder: (_, i) => Column(
                  children: [
                    ClassItem(
                        classData.items[i].id,
                        classData.items[i].subjectID,
                        classData.items[i].type,
                        classData.items[i].room,
                        classData.items[i].teacherID,
                        classData.items[i].daysOfWeek,
                        classData.items[i].startTime,
                        classData.items[i].endTime,
                        subjectData
                            .findById(classData.items[i].subjectID)
                            .color),
                    Divider(),
                  ],
                )),
      ),
    );
  }
}
