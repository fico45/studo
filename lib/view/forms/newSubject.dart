import 'package:flutter/material.dart';
import 'package:studo/model/subjectModel.dart';
import 'package:studo/util/dbhelper.dart';

DbHelper helper = DbHelper();

class NewSubject extends StatefulWidget {
  Subject subject;

  @override
  State<StatefulWidget> createState() {
    return NewSubjectState(subject);
  }
}

class NewSubjectState extends State {
  Subject subject;
  NewSubjectState(this.subject);
  final subjectController = TextEditingController();
  final _subjectFormKey = GlobalKey<NewSubjectState>();
  //colorpicker

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  ValueChanged<Color> onColorChanged;

  changeSimpleColor(Color color) => setState(() => currentColor = color);
  changeMaterialColor(Color color) => setState(() {
        currentColor = color;
        Navigator.of(context).pop();
      });

  //used for disposing controller after no longer needed

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('New Subject'),
        ),
        body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._subjectFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(
                      hintText: 'Subject name', labelText: 'Subject name'),
                ),
                new ListTile(
                    leading: const Icon(Icons.color_lens),

                    //color picker from here
                    
                    //all the way to here (color picker)
                    ),
                new TextFormField(
                  decoration: new InputDecoration(
                      labelText: 'Year',
                      alignLabelWithHint: true,
                      hintText: 'Year'),
                ),
                new RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    save();
                  },
                )
              ],
            ),
          ),
        ));
  }

  void save() {
    
      helper.insertSubject(subject);
      dispose();
    
    Navigator.pop(context, true);
  }
}
