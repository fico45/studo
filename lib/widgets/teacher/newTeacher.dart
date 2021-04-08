import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studo/model/teacherModel.dart';

class NewTeacher extends StatefulWidget {
  static const routeName = '/new-teacher';
  @override
  _NewTeacherState createState() => _NewTeacherState();
}

class _NewTeacherState extends State<NewTeacher> {
  final _form = GlobalKey<FormState>();
  var _editedTeacher = Teacher(
    id: null,
    name: '',
  );

  var _initValues = {
    'name': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final teacherId = ModalRoute.of(context).settings.arguments as String;
      if (teacherId != null) {
        _editedTeacher = Provider.of<Teachers>(
          context,
          listen: false,
        ).findById(teacherId);
        _initValues = {
          'name': _editedTeacher.name,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    setState(() {
      _isLoading = true;
    });
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    if (_editedTeacher.id != null) {
      Provider.of<Teachers>(
        context,
        listen: false,
      ).updateTeacher(_editedTeacher.id, _editedTeacher);
      setState(() {
        _isLoading = false;
      });
    } else {
      try {
        await Provider.of<Teachers>(
          context,
          listen: false,
        ).addTeacher(_editedTeacher);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occured'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
    Navigator.of(context).pop();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Teacher'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        initialValue: _initValues['name'],
                        decoration: InputDecoration(
                          labelText: 'Teacher name',
                        ),
                        onSaved: (value) {
                          _editedTeacher = Teacher(
                            id: _editedTeacher.id,
                            name: value,
                          );
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        }),
                  ],
                ),
              ),
            ),
    );
  }
}

/* class NewTeacher extends StatefulWidget {
  final String id;
  final String name;
  @override
  State<StatefulWidget> createState() {
    return NewTeacherState(teacher);
  }
}

class NewTeacherState extends State {
  Teacher teacher = new Teacher();
  NewTeacherState(this.teacher);
  final _teacherController = TextEditingController();
  final _teacherFormKey = UniqueKey();
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
                  decoration: new InputDecoration(hintText: 'Teacher name'),
                  onFieldSubmitted: (value) {
                    teacher.name = _teacherController.text;
                  },
                ),
                new SizedBox(
                  height: 15.0,
                ),
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
    teacher.name = val;
    helper.insertTeacher(teacher);
    dispose();
    Navigator.pop(context, true);
  }
}
 */
