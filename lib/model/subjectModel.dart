import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

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
  List<Subject> _items = [];

  List<Subject> get items {
    return [..._items];
  }

  Future<void> getItems() async {
    try {
      const url =
          'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/subjects.json';
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Subject> loadedSubjects = [];
      if (extractedData != null) {
        extractedData.forEach((subjectId, subjectData) {
          loadedSubjects.add(Subject(
            id: subjectData['id'],
            name: subjectData['name'],
            color: subjectData['color'],
            year: subjectData['year'],
          ));
        });
        _items = loadedSubjects;
      }
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> deleteSubject(String id) async {
    const url =
        'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/subjects.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    try {
      if (extractedData != null) {
        extractedData.forEach((subjectId, subjectData) {
          if (subjectData['id'] == id) {
            http.delete(Uri.parse(
                'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/subjects/' +
                    subjectId +
                    '.json'));
          }
        });
      }
      _items.removeWhere((subject) => subject.id == id);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addSubject(Subject subject) async {
    const url =
        'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/subjects.json';
    try {
      final newSubject = Subject(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: subject.name,
        color: subject.color,
        year: subject.year,
      );
      await http
          .post(url,
              body: json.encode({
                'id': newSubject.id,
                'name': newSubject.name,
                'color': newSubject.color,
                'year': newSubject.year
              }))
          .then((response) {
        _items.add(newSubject);
      });
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Subject findById(String id) {
    return items.firstWhere((subject) => subject.id == id);
  }

  Future<void> updateSubject(String id, Subject newSubject) async {
    const url =
        'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/subjects.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final subjectIndex = _items.indexWhere((subject) => subject.id == id);
    try {
      if (extractedData != null) {
        extractedData.forEach((subjectId, subjectData) {
          if (subjectData['id'] == id) {
            http.put(
                Uri.parse(
                    'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/subjects/' +
                        subjectId +
                        '.json'),
                body: json.encode({
                  'id': newSubject.id,
                  'name': newSubject.name,
                  'color': newSubject.color,
                  'year': newSubject.year
                }));
          }
        });
      }
      if (subjectIndex >= 0) {
        _items[subjectIndex] = newSubject;
        notifyListeners();
      } else {
        print('...');
      }
    } catch (error) {
      throw (error);
    }
  }
}
