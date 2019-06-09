import 'package:flutter/material.dart';
import 'package:studo/util/dbhelper.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardState();
  }
}

class DashboardState extends State {
  DbHelper helper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is where the Dasbhoard should be.'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('FAB pressed!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {},
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Icon(Icons.adb),
      ),
    );
  }
}
