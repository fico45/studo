import 'package:sqflite/sqflite.dart';
import 'dart:core';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:studo/model/examModel.dart';
import 'package:studo/model/yearModel.dart';
import 'package:studo/model/holidayModel.dart';
import 'package:studo/model/classModel.dart';
import 'package:studo/model/subjectModel.dart';
import 'package:studo/model/daysOfWeekModel.dart';
import 'package:studo/model/teacherModel.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();
  factory DbHelper() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "studo.db";

    var dbStudo = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbStudo;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute(
        "CREATE TABLE Year(id INTEGER PRIMARY KEY, startDate DATETIME, endDate DATETIME)");
    await db.execute(
        "CREATE TABLE Holiday(id INTEGER PRIMARY KEY, startDate DATETIME, endDate DATETIME, yearID REFERENCES Year(id))");
    await db.execute(
        "CREATE TABLE Subject (id INTEGER PRIMARY KEY, name TEXT, color TEXT, academicYearID INTEGER)");
    await db.execute("CREATE TABLE Teacher(id INTEGER PRIMARY KEY, name TEXT)");
    await db.execute(
        "CREATE TABLE Class (id INTEGER PRIMARY KEY, subjectID INTEGER REFERENCES Subject(id), type TEXT, room TEXT, startTime TEXT, endTime TEXT, teacherID INTEGER REFERENCES Teacher(id))");
    await db.execute(
        "CREATE TABLE Exam(SubjectID INTEGER PRIMARY KEY REFERENCES Subject(id), examTime DATETIME, location TEXT, duration INTEGER, description TEXT)");
    await db.execute(
        "CREATE TABLE DaysOfWeek(classID INTEGER REFERENCES Class(id) PRIMARY KEY, monday BOOL, tuesday BOOL, wednesday BOOL, thuesday BOOL, friday BOOL, saturday BOOL, sunday BOOL)");
  }

//Exam CRUD

  Future<int> insertExam(Exam exam) async {
    Database db = await this.db;
    var result = await db.insert('Exam', exam.toMap());
    return result;
  }

  Future<List> getExams() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM Exam");
    return result;
  }

  Future<int> updateExam(Exam exam) async {
    Database db = await this.db;
    var result = await db
        .update("exam", exam.toMap(), where: "id = ?", whereArgs: [exam.id]);
    return result;
  }

  Future<int> deleteExam(int id) async {
    var result;
    Database db = await this.db;
    result = await db.delete("Exam", where: 'id= ?', whereArgs: [id]);
    return result;
  }

//Year CRUD

  Future<int> insertYear(Year year) async {
    Database db = await this.db;
    var result = await db.insert('Year', year.toMap());
    return result;
  }

  Future<List> getYears() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM Year");
    return result;
  }

  Future<int> updateYear(Year year) async {
    Database db = await this.db;
    var result = await db
        .update('Year', year.toMap(), where: "id = ?", whereArgs: [year.id]);
    return result;
  }

  Future<int> deleteYear(int id) async {
    Database db = await this.db;
    var result = await db.delete('Year', where: "id = ?", whereArgs: [id]);
    return result;
  }

  //Holiday CRUD

  Future<int> insertHoliday(Holiday holiday) async {
    Database db = await this.db;
    var result = await db.insert('Holiday', holiday.toMap());
    return result;
  }

  Future<List> getHoliday(Holiday holiday) async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM Holiday");
    return result;
  }

  Future<int> updateHoliday(Holiday holiday) async {
    Database db = await this.db;
    var result = await db.update('Holiday', holiday.toMap(),
        where: "id = ?", whereArgs: [holiday.id]);
    return result;
  }

  Future<int> deleteHoliday(int id) async {
    Database db = await this.db;
    var result = await db.delete('Holiday', where: "id = ?", whereArgs: [id]);
    return result;
  }

//Class CRUD

  Future<int> insertClass(Class cl) async {
    Database db = await this.db;
    var result = await db.insert('Class', cl.toMap());
    return result;
  }

  Future<List> getClass(Class cl) async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM Class");
    return result;
  }

  Future<int> updateClass(Class cl) async {
    Database db = await this.db;
    var result = await db
        .update('Class', cl.toMap(), where: "id = ?", whereArgs: [cl.id]);
    return result;
  }

  Future<int> deleteClass(int id) async {
    Database db = await this.db;
    var result = await db.delete('Class', where: "id = ?", whereArgs: [id]);
    return result;
  }

// Subject CRUD

  Future<int> insertSubject(Subject subject) async {
    Database db = await this.db;
    var result = await db.insert('Subject', subject.toMap());
    return result;
  }

  Future<List> getSubject(Subject subject) async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM Subject");
    return result;
  }

  Future<int> updateSubject(Subject subject) async {
    
    Database db = await this.db;
    var result = await db.update('Subject', subject.toMap(),
        where: "id = ?", whereArgs: [subject.id]);
    return result;
  }

  Future<int> deleteSubject(int id) async {
    Database db = await this.db;
    var result = await db.delete('Subject', where: "id = ?", whereArgs: [id]);
    return result;
  }

//Teacher CRUD

  Future<int> insertTeacher(Teacher teacher) async {
    Database db = await this.db;
    var result = await db.insert('Teacher', teacher.toMap());
    return result;
  }

  Future<List> getTeacher(Teacher teacher) async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM Teacher");
    return result;
  }

  Future<int> updateTeacher(Teacher teacher) async {
    Database db = await this.db;
    var result = await db.update('Teacher', teacher.toMap(),
        where: "id = ?", whereArgs: [teacher.id]);
    return result;
  }

  Future<int> deleteTeacher(int id) async {
    Database db = await this.db;
    var result = await db.delete('Teacher', where: "id = ?", whereArgs: [id]);
    return result;
  }

//DaysOfWeek CRUD

  Future<int> insertDaysOfWeek(DaysOfWeek daysOfWeek) async {
    Database db = await this.db;
    var result = await db.insert('DaysOfWeek', daysOfWeek.toMap());
    return result;
  }

  Future<List> getDaysOfWeek(DaysOfWeek daysOfWeek) async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM DaysOfWeek");
    return result;
  }

  Future<int> updateDaysOfWeek(DaysOfWeek daysOfWeek) async {
    Database db = await this.db;
    var result = await db.update('DaysOfWeek', daysOfWeek.toMap(),
        where: "id = ?", whereArgs: [daysOfWeek.id]);
    return result;
  }

  Future<int> deleteDaysOfWeek(int id) async {
    Database db = await this.db;
    var result =
        await db.delete('DaysOfWeek', where: "id = ?", whereArgs: [id]);
    return result;
  }
}
