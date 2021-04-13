import 'package:flutter/material.dart';

class Exam with ChangeNotifier {
  final String id;
  final String subjectID;
  final String examTimeDate;
  final String location;
  final String description;

  Exam(
      {@required this.id,
      @required this.subjectID,
      @required this.examTimeDate,
      @required this.location,
      @required this.description});
}

class Exams with ChangeNotifier {
  List<Exam> _items = [
    Exam(
        id: '0',
        subjectID: '1',
        examTimeDate: '2021-04-02 14:45',
        location: '403',
        description: 'Ponesi kalkulator'),
    Exam(
        id: '1',
        subjectID: '0',
        examTimeDate: '2021-04-15 16:45',
        location: '402',
        description: 'Ne zaboravi olovku!'),
  ];

  List<Exam> get items {
    return [..._items];
  }

  void deleteExam(String id) {
    _items.removeWhere((exam) => exam.id == id);
    notifyListeners();
  }

  Future<void> addExam(Exam exam) async {
    final newExam = Exam(
      id: DateTime.now().toString(),
      subjectID: exam.subjectID,
      examTimeDate: exam.examTimeDate,
      location: exam.location,
      description: exam.description,
    );
    _items.add(newExam);
    notifyListeners();
  }

  Exam findById(String id) {
    return items.firstWhere((exam) => exam.id == id);
  }

  void updateExam(String id, Exam newExam) {
    final examIndex = _items.indexWhere((exm) => exm.id == id);
    if (examIndex >= 0) {
      _items[examIndex] = newExam;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
