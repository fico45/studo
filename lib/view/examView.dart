import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studo/model/examModel.dart';
import 'package:studo/widgets/exam/newExam.dart';
import 'package:studo/widgets/exam/exam_item.dart';
import 'package:studo/model/subjectModel.dart';

class ExamView extends StatelessWidget {
  static const routeName = '/exam-view';

  @override
  Widget build(BuildContext context) {
    final examData = Provider.of<Exams>(context);
    final subjectData = Provider.of<Subjects>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exams'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(NewExam.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: examData.items.length,
            itemBuilder: (_, i) => Column(
                  children: [
                    ExamItem(
                      examData.items[i].id,
                      subjectData.findById(examData.items[i].subjectID).name,
                      subjectData.findById(examData.items[i].subjectID).color,
                    ),
                    Divider(),
                  ],
                )),
      ),
    );
  }
}
