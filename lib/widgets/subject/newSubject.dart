import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flex_color_picker/flex_color_picker.dart';

import 'package:studo/model/subjectModel.dart';

class NewSubject extends StatefulWidget {
  static const routeName = '/new-subject';

  @override
  _NewSubjectState createState() => _NewSubjectState();
}

class _NewSubjectState extends State<NewSubject> {
  final _form = GlobalKey<FormState>();

  Color colorPicker = Colors.blue;

  var _editedSubject = Subject(
    id: null,
    name: '',
    color: '',
    year: '',
  );

  var _initValues = {
    'name': '',
    'color': '',
    'year': '',
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
      final subjectId = ModalRoute.of(context).settings.arguments as String;
      if (subjectId != null) {
        _editedSubject = Provider.of<Subjects>(
          context,
          listen: false,
        ).findById(subjectId);
        _initValues = {
          'name': _editedSubject.name,
          'color': _editedSubject.color,
          'year': _editedSubject.year,
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

    if (_editedSubject.id != null) {
      Provider.of<Subjects>(
        context,
        listen: false,
      ).updateSubject(_editedSubject.id, _editedSubject);
      setState(() {
        _isLoading = false;
      });
    } else {
      try {
        await Provider.of<Subjects>(
          context,
          listen: false,
        ).addSubject(_editedSubject);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Subject'),
        backgroundColor: colorPicker,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
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
                          return 'Please provide a value';
                        }
                        return null;
                      },
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(
                        labelText: 'Subject name',
                      ),
                      onSaved: (value) {
                        _editedSubject = Subject(
                          id: _editedSubject.id,
                          name: value,
                          color: _editedSubject.color,
                          year: _editedSubject.year,
                        );
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus();
                      },
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value';
                        }
                        return null;
                      },
                      initialValue: _initValues['year'],
                      decoration: InputDecoration(
                        labelText: 'Year',
                      ),
                      onSaved: (value) {
                        _editedSubject = Subject(
                          id: _editedSubject.id,
                          name: _editedSubject.name,
                          color: _editedSubject.color,
                          year: value,
                        );
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus();
                      },
                    ),
                    ColorPicker(
                      color: colorPicker,
                      onColorChanged: (Color newColor) {
                        setState(() => colorPicker = newColor);
                        _editedSubject.color =
                            '#${colorPicker.value.toRadixString(16)}';
                      },
                      heading: Text(
                        'Select color',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      subheading: Text(
                        'Select color shade',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
