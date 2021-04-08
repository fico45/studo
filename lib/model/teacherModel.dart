import 'package:flutter/material.dart';

class Teacher with ChangeNotifier {
  final String id;
  final String name;

  Teacher({
    @required this.id,
    @required this.name,
  });
}

class Teachers with ChangeNotifier {
  List<Teacher> _items = [
    Teacher(
      id: '0',
      name: 'Tihomir',
    ),
    Teacher(
      id: '1',
      name: 'Ante',
    ),
  ];

  List<Teacher> get items {
    return [..._items];
  }

  void deleteTeacher(String id) {
    _items.removeWhere((teacher) => teacher.id == id);
    notifyListeners();
  }

  Future<void> addTeacher(Teacher teacher) async {
    final newTeacher = Teacher(
      id: DateTime.now().toString(),
      name: teacher.name,
    );
    _items.add(newTeacher);
    notifyListeners();
  }

  Teacher findById(String id) {
    return items.firstWhere((teacher) => teacher.id == id);
  }

  void updateTeacher(String id, Teacher newTeacher) {
    final teacherIndex = _items.indexWhere((tchr) => tchr.id == id);
    if (teacherIndex >= 0) {
      _items[teacherIndex] = newTeacher;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
