import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studo/model/classModel.dart';
import 'package:studo/widgets/bouncy_page_route.dart';
import 'package:studo/widgets/class/newClass.dart';
import 'package:studo/widgets/class/class_item.dart';

import 'package:studo/model/subjectModel.dart';

class ClassView extends StatefulWidget {
  static const routeName = '/class-view';

  @override
  _ClassViewState createState() => _ClassViewState();
}

class _ClassViewState extends State<ClassView> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Subjects>(context, listen: false);
      Provider.of<Classes>(
        context,
        listen: false,
      ).getItems().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    /*  Provider.of<Classes>(
      context,
      listen: false,
    ).getItems(); */

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final classData = Provider.of<Classes>(context);
    final subjectData = Provider.of<Subjects>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Predavanja'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              //Navigator.of(context).pushNamed(NewClass.routeName);
              Navigator.push(context, BouncyPageRoute(NewClass()));
            },
          ),
        ],
      ),
      body: _isInit
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                  itemCount: classData.items.length,
                  itemBuilder: (_, i) {
                    return Column(
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
                        /* Text('Element: ' + i.toString()),
                        Text(classData.items.length.toString()), */
                        Divider(),
                      ],
                    );
                  }),
            ),
    );
  }
}
