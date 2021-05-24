import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:studo/model/daysOfWeekModel.dart';

class Class with ChangeNotifier {
  final String id;
  final String subjectID;
  final String type;
  final String room;
  final String teacherID;
  final String daysOfWeek;
  final String startTime;
  final String endTime;

  Class({
    @required this.id,
    @required this.subjectID,
    @required this.type,
    @required this.room,
    @required this.teacherID,
    @required this.daysOfWeek,
    @required this.startTime,
    @required this.endTime,
  });
}

class Classes with ChangeNotifier {
  List<Class> _items = [
    /* Class(
      id: '0',
      subjectID: '1',
      type: 'Labs',
      room: '203',
      teacherID: '1',
      daysOfWeek: '[null, false, false, false, false, true, null]',
      startTime: '14:45',
      endTime: '15:30',
    ),
    Class(
      id: '1',
      subjectID: '2',
      type: 'Lecture',
      room: '203',
      teacherID: '0',
      daysOfWeek: '[null, true, true, true, true, true, null]',
      startTime: '15:45',
      endTime: '16:30',
    ), */
  ];

  List<Class> _todayItems = [];
  List<Class> get items {
    return [..._items];
  }

  List<Class> get todayItems {
    return [..._todayItems];
  }

  Future<void> getItems() async {
    try {
      const url =
          'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/classes.json';
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Class> loadedClasses = [];
      extractedData.forEach((classId, classData) {
        loadedClasses.add(Class(
          id: classData['id'],
          subjectID: classData['subjectID'],
          type: classData['type'],
          room: classData['room'],
          teacherID: classData['teacherID'],
          daysOfWeek: classData['daysOfWeek'],
          startTime: classData['startTime'],
          endTime: classData['endTime'],
        ));
      });
      _items = loadedClasses;
      getGodayItems();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> getGodayItems() async {
    try {
      DateTime date = DateTime.now();
      print('Sada je:' + date.hour.toString());
      print('Kaže: ');
      _todayItems = _items.where(
        (cl) {
          if (date.weekday == 7 &&
              json.decode(cl.daysOfWeek)[0] == true &&
              int.parse(cl.startTime) > date.hour) {
            return true;
          } else if (json.decode(cl.daysOfWeek)[date.weekday] == true) {
            if (int.parse(cl.endTime[0] + cl.endTime[1]) > date.hour) {
              if (int.parse(cl.endTime[3] + cl.endTime[4]) > date.minute) {
                return true;
              }
            }
          }
          return false;
        },
      ).toList();
      _todayItems.sort((a, b) {
        var aTime = a.startTime;
        var bTime = b.startTime;
        return -bTime.compareTo(aTime);
      });
      notifyListeners();

      /* _items.forEach((classData) {
        print(json.decode(classData.daysOfWeek)[date.weekday]);
        //print(date.weekday);
        if (date.day == 7 && json.decode(classData.daysOfWeek)[0] == true) {
          todayItems.add(Class(
            id: classData.id,
            subjectID: classData.subjectID,
            type: classData.type,
            room: classData.room,
            teacherID: classData.teacherID,
            daysOfWeek: classData.daysOfWeek,
            startTime: classData.startTime,
            endTime: classData.endTime,
          ));
        } else if (json.decode(classData.daysOfWeek)[date.weekday] == true) {
          todayItems.add(Class(
            id: classData.id,
            subjectID: classData.subjectID,
            type: classData.type,
            room: classData.room,
            teacherID: classData.teacherID,
            daysOfWeek: classData.daysOfWeek,
            startTime: classData.startTime,
            endTime: classData.endTime,
          ));
        }
      });

      notifyListeners();
      print('Itemi: ' + todayItems.toString());
      print('Dužina: ' + todayItems.length.toString()); */

      /* const url =
          'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/classes.json';
      final response = await http.get(url);
      final List<Class> todayClasses = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((key, classData) {
        if (date.day == 7 && classData.daysOfWeek[0] == true) {
          todayClasses.add(Class(
            id: classData['id'],
            subjectID: classData['subjectID'],
            type: classData['type'],
            room: classData['room'],
            teacherID: classData['teacherID'],
            daysOfWeek: classData['daysOfWeek'],
            startTime: classData['startTime'],
            endTime: classData['endTime'],
          ));
        } else if (classData.daysOfWeek[date.day] == true) {
          todayClasses.add(Class(
            id: classData['id'],
            subjectID: classData['subjectID'],
            type: classData['type'],
            room: classData['room'],
            teacherID: classData['teacherID'],
            daysOfWeek: classData['daysOfWeek'],
            startTime: classData['startTime'],
            endTime: classData['endTime'],
          ));
        }
      });
      _todayItems = todayClasses;
      notifyListeners(); */
    } catch (error) {
      throw (error);
    }
    /*  _items.where(
      (cl) {
        if (date.day == 7 && cl.daysOfWeek[0] == true) {
          return true;
        } else if (cl.daysOfWeek[date.day] == true) {
          print(cl.daysOfWeek[date.day]);
          return true;
        }
        return false;
      },
    ).toList(); */
  }

  void deleteClass(String id) {
    _items.removeWhere((cl) => cl.id == id);
    notifyListeners();
  }

  Future<void> addClass(Class cl) async {
    const url =
        'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/classes.json';
    try {
      final newClass = Class(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        subjectID: cl.subjectID,
        type: cl.type,
        room: cl.room,
        teacherID: cl.teacherID,
        daysOfWeek: cl.daysOfWeek,
        startTime: cl.startTime,
        endTime: cl.endTime,
      );

      await http
          .post(
        url,
        body: json.encode({
          'id': newClass.id,
          'subjectID': cl.subjectID,
          'type': cl.type,
          'room': cl.room,
          'teacherID': cl.teacherID,
          'daysOfWeek': cl.daysOfWeek,
          'startTime': cl.startTime,
          'endTime': cl.endTime
        }),
      )
          .then((response) {
        _items.add(newClass);
        notifyListeners();
      });
    } catch (error) {
      throw (error);
    }
  }

  Class findById(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  void updateClass(String id, Class newClass) {
    final classIndex = _items.indexWhere((element) => element.id == id);
    if (classIndex >= 0) {
      _items[classIndex] = newClass;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
