import 'package:studo/model/daysOfWeekModel.dart';

class Class {
  int _id;
  int _subjectID;
  String _type;
  String _room;
  int _teacherID;
  DaysOfWeek _daysOfWeek;
  String _startTime;
  String _endTime;

  Class(this._type, this._room, this._startTime, this._endTime,
      [this._teacherID, this._daysOfWeek]);

  int get id => _id;
  int get subjectID => _subjectID;
  String get type => _type;
  String get room => _room;
  int get teacherID => _teacherID;
  DaysOfWeek get daysOfWeek => _daysOfWeek;
  String get startTime => _startTime;
  String get endTime => _endTime;

  set type(String newType) {
    _type = newType;
  }

  set room(String newRoom) {
    _room = newRoom;
  }

  set teacherID(int newTeacherID) {
    _teacherID = newTeacherID;
  }

  set startTime(String newStartTime) {
    if (newStartTime != _startTime) {
      _startTime = newStartTime;
    }
  }

  set endTime(String newEndTime) {
    if (newEndTime != _endTime) {
      _endTime = newEndTime;
    }
  }

  set daysOfWeek(DaysOfWeek newDaysOfWeek) {
    if (newDaysOfWeek != _daysOfWeek) {
      _daysOfWeek = newDaysOfWeek;
    }
  }

  Class.map(dynamic o) {
    this._type = o["type"];
    this._subjectID = o["subjectID"];
    this._teacherID = o["teacherID"];
    this._room = o["room"];
    this._daysOfWeek = o["daysOfWeek"];
    this._startTime = o["startTIme"];
    this._endTime = o["endTime"];
  }
  
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["type"] = _type;
    map["subjectID"] = _subjectID;
    map["teacherID"] = _teacherID;
    map["room"] = _room;
    map["startTime"] = _startTime;
    map["endTime"] = _endTime;
    return map;
  }
}
