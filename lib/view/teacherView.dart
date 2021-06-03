import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studo/model/teacherModel.dart';
import 'package:studo/widgets/bouncy_page_route.dart';
import 'package:studo/widgets/teacher/newTeacher.dart';
import 'package:studo/widgets/teacher/teacher_item.dart';

class TeacherView extends StatefulWidget {
  static const routeName = '/teacher-view';

  @override
  _TeacherViewState createState() => _TeacherViewState();
}

class _TeacherViewState extends State<TeacherView> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Teachers>(context).fetchTeachers().then((_) {
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
    Provider.of<Teachers>(
      context,
      listen: false,
    ).fetchTeachers();
    super.initState();
  }

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
              Navigator.push(context, BouncyPageRoute(NewTeacher()));
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
