import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

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
    /* Teacher(
      id: '0',
      name: 'Tihomir',
    ),
    Teacher(
      id: '1',
      name: 'Ante',
    ), */
  ];

  List<Teacher> get items {
    return [..._items];
  }

  Future<void> deleteTeacher(String id) async {
    const url =
        'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/teachers.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    try {
      if (extractedData != null) {
        extractedData.forEach((teacherId, teacherData) {
          if (teacherData['id'] == id) {
            http.delete(Uri.parse(
                'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/teachers/' +
                    teacherId +
                    '.json'));
          }
        });
      }
      _items.removeWhere((teacher) => teacher.id == id);
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> fetchTeachers() async {
    const url =
        'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/teachers.json';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Teacher> loadedTeachers = [];
      if (extractedData != null) {
        extractedData.forEach((teacherId, teacherData) {
          loadedTeachers.add(Teacher(
            id: teacherData['id'],
            name: teacherData['name'],
          ));
        });
      }

      _items = loadedTeachers;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addTeacher(Teacher teacher) async {
    final String newID = DateTime.now().millisecondsSinceEpoch.toString();
    const url =
        'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/teachers/.json';
    try {
      final newTeacher = Teacher(
        id: newID,
        name: teacher.name,
      );
      http
          .post(
        url,
        body: json.encode({
          'id': newTeacher.id,
          'name': newTeacher.name,
        }),
      )
          .then((response) {
        _items.add(newTeacher);
        notifyListeners();
      });
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Teacher findById(String id) {
    return items.firstWhere((teacher) => teacher.id == id);
  }

  Future<void> updateTeacher(String id, Teacher newTeacher) async {
    const url =
        'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/teachers.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    final teacherIndex = _items.indexWhere((tchr) => tchr.id == id);
    try {
      if (extractedData != null) {
        extractedData.forEach((teacherId, teacherData) {
          if (teacherData['id'] == id) {
            http.put(
              Uri.parse(
                  'https://studo-afbaa-default-rtdb.europe-west1.firebasedatabase.app/teachers/' +
                      teacherId +
                      '.json'),
              body: json.encode({
                'id': newTeacher.id,
                'name': newTeacher.name,
              }),
            );
          }
        });
        if (teacherIndex >= 0) {
          _items[teacherIndex] = newTeacher;
          notifyListeners();
        }
      }
    } catch (error) {
      throw (error);
    }

    _items[teacherIndex] = newTeacher;
    notifyListeners();
  }
}
