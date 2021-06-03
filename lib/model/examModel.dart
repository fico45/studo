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
            location: examData['location'],
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

  Future<void> deleteExam(String id) async {
    const url =
        'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/exams.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    try {
      if (extractedData != null) {
        extractedData.forEach((examId, examData) {
          if (examData['id'] == id) {
            http.delete(Uri.parse(
                'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/exams/' +
                    examId +
                    '.json'));
          }
        });
      }
      _items.removeWhere((exam) => exam.id == id);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addExam(Exam exam) async {
    const url =
        'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/exams.json';

    try {
      final newExam = Exam(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        subjectID: exam.subjectID,
        examTimeDate: exam.examTimeDate,
        location: exam.location,
        description: exam.description,
      );
      await http
          .post(
        url,
        body: json.encode({
          'id': newExam.id,
          'subjectID': newExam.subjectID,
          'examTimeDate': newExam.examTimeDate,
          'location': newExam.location,
          'description': newExam.description,
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

  Future<void> updateExam(String id, Exam newExam) async {
    const url =
        'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/exams.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final examIndex = _items.indexWhere((element) => element.id == id);
    try {
      if (extractedData != null) {
        extractedData.forEach((examId, examData) {
          if (examData['id'] == id) {
            http.put(
              Uri.parse(
                  'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/exams/' +
                      examId +
                      '.json'),
              body: json.encode({
                'id': newExam.id,
                'subjectID': newExam.subjectID,
                'examTimeDate': newExam.examTimeDate,
                'location': newExam.location,
                'description': newExam.description,
              }),
            );
          }
        });
        if (examIndex >= 0) {
          _items[examIndex] = newExam;
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
