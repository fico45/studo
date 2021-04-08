import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import 'package:studo/widgets/subject/newSubject.dart';
import 'package:studo/widgets/subject/subject_item.dart';
import 'package:studo/model/subjectModel.dart';

class SubjectView extends StatelessWidget {
  static const routeName = '/subject-view';
  @override
  Widget build(BuildContext context) {
    final subjectsData = Provider.of<Subjects>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(NewSubject.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: subjectsData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              SubjectItem(
                subjectsData.items[i].id,
                subjectsData.items[i].name,
                subjectsData.items[i].color,
                subjectsData.items[i].year,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
