import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

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
  List<Class> _upcomingClasses = [];
  List<Class> get items {
    return [..._items];
  }

  List<Class> get todayItems {
    return [..._todayItems];
  }

  List<Class> get upcomingClasses {
    return [..._upcomingClasses];
  }

  Future<void> getItems() async {
    try {
      const url =
          'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/classes.json';
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Class> loadedClasses = [];
      if (extractedData != null) {
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
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<void> getGodayItems() async {
    try {
      DateTime date = DateTime.now();
      if (_items != null) {
        _todayItems = _items.where(
          (cl) {
            if (date.weekday == 7 &&
                json.decode(cl.daysOfWeek)[0] == true &&
                int.parse(cl.endTime[0] + cl.endTime[1]) * 60 +
                        int.parse(cl.endTime[3] + cl.endTime[4]) >
                    date.hour * 60 + date.minute) {
              return true;
            } else if (json.decode(cl.daysOfWeek)[date.weekday] == true &&
                int.parse(cl.endTime[0] + cl.endTime[1]) * 60 +
                        int.parse(cl.endTime[3] + cl.endTime[4]) >
                    date.hour * 60 + date.minute) {
              return true;
            } else
              return false;
          },
        ).toList();

        _todayItems.sort((a, b) {
          var aTime = a.startTime;
          var bTime = b.startTime;
          return -bTime.compareTo(aTime);
        });
      }
      _upcomingClasses = _todayItems.skip(1).toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> deleteClass(String id) async {
    const url =
        'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/classes.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    try {
      if (extractedData != null) {
        extractedData.forEach((classId, classData) {
          if (classData['id'] == id) {
            http.delete(Uri.parse(
                'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/classes/' +
                    classId +
                    '.json'));
          }
        });
      }
      _items.removeWhere((cl) => cl.id == id);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
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

  Future<void> updateClass(String id, Class newClass) async {
    const url =
        'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/classes.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final classIndex = _items.indexWhere((element) => element.id == id);
    try {
      if (extractedData != null) {
        extractedData.forEach((classId, classData) {
          if (classData['id'] == id) {
            http.put(
              Uri.parse(
                  'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/classes/' +
                      classId +
                      '.json'),
              body: json.encode({
                'id': newClass.id,
                'subjectID': newClass.subjectID,
                'type': newClass.type,
                'room': newClass.room,
                'teacherID': newClass.teacherID,
                'daysOfWeek': newClass.daysOfWeek,
                'startTime': newClass.startTime,
                'endTime': newClass.endTime
              }),
            );
          }
        });
        if (classIndex >= 0) {
          _items[classIndex] = newClass;
          notifyListeners();
        } else {
          print('...');
        }
      }
    } catch (error) {
      throw (error);
    }
  }
}
