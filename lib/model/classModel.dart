import 'package:flutter/material.dart';

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
    Class(
      id: '0',
      subjectID: '1',
      type: 'Labs',
      room: '203',
      teacherID: '1',
      daysOfWeek: '',
      startTime: '14:45',
      endTime: '15:30',
    ),
    Class(
      id: '1',
      subjectID: '2',
      type: 'Predavanja',
      room: '203',
      teacherID: '1',
      daysOfWeek: '',
      startTime: '15:45',
      endTime: '16:30',
    ),
  ];

  List<Class> get items {
    return [..._items];
  }

  void deleteClass(String id) {
    _items.removeWhere((cl) => cl.id == id);
    notifyListeners();
  }

  Future<void> addClass(Class cl) async {
    final newClass = Class(
      id: DateTime.now().toString(),
      subjectID: cl.subjectID,
      type: cl.type,
      room: cl.room,
      teacherID: cl.teacherID,
      daysOfWeek: cl.daysOfWeek,
      startTime: cl.startTime,
      endTime: cl.endTime,
    );
    _items.add(newClass);
    notifyListeners();
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
