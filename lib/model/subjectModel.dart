import 'package:flutter/material.dart';

class Subject with ChangeNotifier {
  String id;
  String name;
  String color;
  String year;

  Subject({
    @required this.id,
    @required this.name,
    @required this.color,
    @required this.year,
  });
}

class Subjects with ChangeNotifier {
  List<Subject> _items = [
    Subject(
      id: '0',
      name: 'Matematika',
      color: '0000FF',
      year: '2021',
    ),
    Subject(
      id: '1',
      name: 'Računovodstvo',
      color: 'FF0000',
      year: '2021',
    ),
    Subject(
      id: '2',
      name: 'PIS',
      color: '00FF00',
      year: '2021',
    ),
  ];

  List<Subject> get items {
    return [..._items];
  }

  void deleteSubject(String id) {
    _items.removeWhere((subject) => subject.id == id);
    notifyListeners();
  }

  Future<void> addSubject(Subject subject) async {
    final newSubject = Subject(
      id: DateTime.now().toString(),
      name: subject.name,
      color: subject.color,
      year: subject.year,
    );
    _items.add(newSubject);
    print(newSubject.id);
    notifyListeners();
  }

  Subject findById(String id) {
    return items.firstWhere((subject) => subject.id == id);
  }

  void updateSubject(String id, Subject newSubject) {
    final subjectIndex = _items.indexWhere((subject) => subject.id == id);
    if (subjectIndex >= 0) {
      _items[subjectIndex] = newSubject;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
