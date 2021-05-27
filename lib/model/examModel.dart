import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

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
    /* Exam(
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
        description: 'Ne zaboravi olovku!'), */
  ];

  List<Exam> get items {
    return [..._items];
  }

  Future<void> getItems() async {
    try {
      const url =
          'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/exams.json';
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Exam> loadedExams = [];
      if (extractedData != null) {
        extractedData.forEach((examId, examData) {
          loadedExams.add(Exam(
            id: examData['id'],
            subjectID: examData['subjectID'],
            examTimeDate: examData['examTimeDate'],
            location: examData['examTimeDate'],
            description: examData['description'],
          ));
        });
        _items = loadedExams;

        notifyListeners();
      }
    } catch (error) {
      throw (error);
    }
  }

  void deleteExam(String id) {
    _items.removeWhere((exam) => exam.id == id);
    notifyListeners();
  }

  Future<void> addExam(Exam exam) async {
    const url =
        'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/exams.json';

    try {
      final newExam = Exam(
        id: DateTime.now().toString(),
        subjectID: exam.subjectID,
        examTimeDate: exam.examTimeDate,
        location: exam.location,
        description: exam.description,
      );
      await http
          .post(
        url,
        body: json.encode({
          'subjectID': exam.subjectID,
          'examTimeDate': exam.examTimeDate,
          'location': exam.location,
          'description': exam.description,
        }),
      )
          .then((response) {
        _items.add(newExam);
        notifyListeners();
      });
    } catch (error) {
      throw (error);
    }
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
