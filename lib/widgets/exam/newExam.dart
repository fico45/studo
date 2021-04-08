import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studo/model/examModel.dart';
import 'package:studo/model/subjectModel.dart';
import 'package:date_time_picker/date_time_picker.dart';

class NewExam extends StatefulWidget {
  static const routeName = '/new-exam';
  @override
  _NewExamState createState() => _NewExamState();
}

class _NewExamState extends State<NewExam> {
  final _form = GlobalKey<FormState>();

  var _editedExam = Exam(
    id: null,
    subjectID: '',
    examTimeDate: '',
    location: '',
    description: '',
  );

  var _initValues = {
    'subjectID': '',
    'examTimeDate': '',
    'location': '',
    'description': '',
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
      final examId = ModalRoute.of(context).settings.arguments as String;
      if (examId != null) {
        _editedExam = Provider.of<Exams>(
          context,
          listen: false,
        ).findById(examId);
        _initValues = {
          'subjectID': _editedExam.subjectID,
          'examTimeDate': _editedExam.examTimeDate,
          'location': _editedExam.location,
          'description': _editedExam.description,
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
    if (_editedExam.id != null) {
      Provider.of<Exams>(
        context,
        listen: false,
      ).updateExam(_editedExam.id, _editedExam);
      setState(() {
        _isLoading = false;
      });
    } else {
      try {
        await Provider.of<Exams>(
          context,
          listen: false,
        ).addExam(_editedExam);
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
    final subjectData = Provider.of<Subjects>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Exam'),
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
                        initialValue: _initValues['location'],
                        decoration: InputDecoration(
                          labelText: 'Exam room',
                        ),
                        onSaved: (value) {
                          _editedExam = Exam(
                            id: _editedExam.id,
                            subjectID: _editedExam.subjectID,
                            examTimeDate: _editedExam.examTimeDate,
                            location: value,
                            description: _editedExam.description,
                          );
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        }),
                    Container(
                      alignment: Alignment.topLeft,
                      child: DateTimePicker(
                        type: DateTimePickerType.dateTimeSeparate,
                        initialValue: _editedExam.examTimeDate,
                        icon: Icon(Icons.event),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        dateLabelText: 'Date',
                        timeLabelText: 'Time',
                        onChanged: (val) => print(val),
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) {
                          _editedExam = Exam(
                            id: _editedExam.id,
                            subjectID: _editedExam.subjectID,
                            examTimeDate: _editedExam.examTimeDate,
                            location: _editedExam.location,
                            description: _editedExam.description,
                          );
                        },
                      ),
                    ),
                    DropdownButtonFormField(),
                  ],
                ),
              ),
            ),
    );
  }
}
