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
              TextButton(
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
