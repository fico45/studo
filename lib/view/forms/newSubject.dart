import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';

class NewSubject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewSubjectState();
  }
}

class NewSubjectState extends State {
  final subjectController = TextEditingController();

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
        body: new Column(
          children: <Widget>[
            new ListTile(
              leading: const Icon(Icons.class_),
              title: new TextField(
                decoration: new InputDecoration(hintText: "Subject name"),
              ),
            ),
            new ListTile(
                leading: const Icon(Icons.color_lens),

                //color picker from here
                title: new RaisedButton(
                    elevation: 3.0,
                    onPressed: () {
                      showGeneralDialog(
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionBuilder: (context, a1, a2, widget) {
                            return Transform.scale(
                              scale: a1.value,
                              child: Opacity(
                                  opacity: a1.value,
                                  child: AlertDialog(
                                    title: const Text('Pick a color!'),
                                    content: SingleChildScrollView(
                                      child: BlockPicker(
                                        pickerColor: currentColor,
                                        onColorChanged: changeMaterialColor,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text('Close'),
                                        onPressed: () {
                                          setState(
                                              () => currentColor = pickerColor);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  )),
                            );
                          },
                          transitionDuration: Duration(milliseconds: 200),
                          barrierDismissible: true,
                          barrierLabel: '',
                          context: context,
                          pageBuilder: (context, animation1, animation2) {});
                    })
                //all the way to here (color picker)
                ),
            new ListTile(
                leading: const Icon(Icons.date_range),
                title: new DropdownButtonFormField(
                  items: [],
                ))
          ],
        ));
  }
}
