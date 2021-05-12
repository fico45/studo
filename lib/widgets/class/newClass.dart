import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studo/model/subjectModel.dart';
import 'package:studo/model/classModel.dart';
import 'package:studo/model/teacherModel.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:weekday_selector/weekday_selector.dart';

class NewClass extends StatefulWidget {
  static const routeName = '/new-class';
  @override
  _NewClassState createState() => _NewClassState();
}

class _NewClassState extends State<NewClass> {
  final _form = GlobalKey<FormState>();
  String dropdownValue = '';
  final values = <bool>[null, false, false, false, false, false, null];

  List<String> classTypes = [
    "Lecture",
    "Labs",
    "Seminar",
    "Discussion",
    "Studio",
  ];

  var _editedClass = Class(
    id: null,
    subjectID: '',
    type: '',
    room: '',
    teacherID: '',
    daysOfWeek: '',
    startTime: '',
    endTime: '',
  );

  var _initValues = {
    'subjectID': '',
    'type': '',
    'room': '',
    'teacherID': '',
    'daysOfWeek': '',
    'startTime': '',
    'endTime': '',
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
      final classId = ModalRoute.of(context).settings.arguments as String;
      if (classId != null) {
        _editedClass = Provider.of<Classes>(
          context,
          listen: false,
        ).findById(classId);
        _initValues = {
          'subjectID': _editedClass.subjectID,
          'type': _editedClass.type,
          'room': _editedClass.room,
          'teacherID': _editedClass.teacherID,
          'daysOfWeek': _editedClass.daysOfWeek,
          'startTime': _editedClass.startTime,
          'endTime': _editedClass.endTime,
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
    if (_editedClass.id != null) {
      Provider.of<Classes>(
        context,
        listen: false,
      ).updateClass(_editedClass.id, _editedClass);
      setState(() {
        _isLoading = false;
      });
    } else {
      try {
        await Provider.of<Classes>(
          context,
          listen: false,
        ).addClass(_editedClass);
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
    final subjectData = Provider.of<Subjects>(
      context,
      listen: false,
    );
    final teacherData = Provider.of<Teachers>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Class'),
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
                    DropdownButtonFormField(
                      onChanged: (final String newValue) {
                        dropdownValue = newValue;
                      },
                      items: classTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Type',
                      ),
                      value: _initValues['type'],
                      onSaved: (value) {
                        _editedClass = Class(
                          id: _editedClass.id,
                          subjectID: _editedClass.subjectID,
                          type: value,
                          room: _editedClass.room,
                          teacherID: _editedClass.teacherID,
                          daysOfWeek: _editedClass.daysOfWeek,
                          startTime: _editedClass.startTime,
                          endTime: _editedClass.endTime,
                        );
                      },
                    ),
                    DropdownButtonFormField(
                      onChanged: (final String newValue) {
                        dropdownValue = newValue;
                      },
                      items: subjectData.items
                          .map(
                            (item) => DropdownMenuItem(
                              child: Text(item.name),
                              value: item.id,
                            ),
                          )
                          .toList(),
                      value: _initValues['subjectID'],
                      decoration: InputDecoration(
                        labelText: 'Subject',
                      ),
                      onSaved: (value) {
                        _editedClass = Class(
                          id: _editedClass.id,
                          subjectID: value,
                          type: _editedClass.type,
                          room: _editedClass.room,
                          teacherID: _editedClass.teacherID,
                          daysOfWeek: _editedClass.daysOfWeek,
                          startTime: _editedClass.startTime,
                          endTime: _editedClass.endTime,
                        );
                      },
                    ),
                    DropdownButtonFormField(
                      onChanged: (final String newValue) {
                        dropdownValue = newValue;
                      },
                      items: teacherData.items
                          .map(
                            (item) => DropdownMenuItem(
                              child: Text(item.name),
                              value: item.id,
                            ),
                          )
                          .toList(),
                      value: _initValues['teacherID'],
                      decoration: InputDecoration(
                        labelText: 'Teacher',
                      ),
                      onSaved: (value) {
                        _editedClass = Class(
                          id: _editedClass.id,
                          subjectID: _editedClass.subjectID,
                          type: _editedClass.type,
                          room: _editedClass.room,
                          teacherID: value,
                          daysOfWeek: _editedClass.daysOfWeek,
                          startTime: _editedClass.startTime,
                          endTime: _editedClass.endTime,
                        );
                      },
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          alignment: Alignment.topLeft,
                          child: DateTimePicker(
                            type: DateTimePickerType.time,
                            initialValue: _initValues['startTime'],
                            icon: Icon(Icons.timer),
                            timeLabelText: 'Start time',
                            onChanged: (val) => print(val),
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) {
                              _editedClass = Class(
                                id: _editedClass.id,
                                subjectID: _editedClass.subjectID,
                                type: _editedClass.type,
                                room: _editedClass.room,
                                teacherID: _editedClass.teacherID,
                                daysOfWeek: _editedClass.daysOfWeek,
                                startTime: val,
                                endTime: _editedClass.endTime,
                              );
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          alignment: Alignment.topRight,
                          child: DateTimePicker(
                            type: DateTimePickerType.time,
                            initialValue: _initValues['endTime'],
                            icon: Icon(Icons.lock_clock),
                            timeLabelText: 'End time',
                            onChanged: (val) => print(val),
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) {
                              _editedClass = Class(
                                id: _editedClass.id,
                                subjectID: _editedClass.subjectID,
                                type: _editedClass.type,
                                room: _editedClass.room,
                                teacherID: _editedClass.teacherID,
                                daysOfWeek: _editedClass.daysOfWeek,
                                startTime: _editedClass.startTime,
                                endTime: val,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                        initialValue: _initValues['room'],
                        decoration: InputDecoration(
                          labelText: 'Room',
                        ),
                        onSaved: (value) {
                          _editedClass = Class(
                            id: _editedClass.id,
                            subjectID: _editedClass.subjectID,
                            type: _editedClass.type,
                            room: value,
                            teacherID: _editedClass.teacherID,
                            daysOfWeek: _editedClass.daysOfWeek,
                            startTime: _editedClass.startTime,
                            endTime: _editedClass.endTime,
                          );
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        }),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'Select days of week for the class',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          WeekdaySelector(
                            elevation: 3,
                            color: Colors.black,
                            fillColor: Colors.white,
                            selectedFillColor: Colors.orange,
                            onChanged: (int day) {
                              setState(() {
                                final index = day % 7;

                                values[index] = !values[index];
                                _editedClass = Class(
                                  id: _editedClass.id,
                                  subjectID: _editedClass.subjectID,
                                  type: _editedClass.type,
                                  room: _editedClass.room,
                                  teacherID: _editedClass.teacherID,
                                  daysOfWeek: values.toString(),
                                  startTime: _editedClass.startTime,
                                  endTime: _editedClass.endTime,
                                );
                              });
                            },
                            values: values,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
