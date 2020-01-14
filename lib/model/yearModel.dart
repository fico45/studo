import 'package:studo/model/holidayModel.dart';

class Year {
  int _id;
  DateTime _startTime;
  DateTime _endTime;
  Holiday _holiday;

  Year(this._startTime, this._endTime, [this._holiday]);

  int get id => _id;
  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;
  Holiday get holiday => _holiday;

  set startTime(DateTime newStartTime) => _startTime = newStartTime;
  set endTime(DateTime newEndTime) => _endTime = newEndTime;
  set holidays(Holiday newHoliday) => _holiday = newHoliday;

  Year.map(dynamic o) {
    this._startTime = o["startTime"];
    this._endTime = o["endTime"];
    this._holiday = o["holiday"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["startTime"] = _startTime;
    map["endTime"] = _endTime;
    map["holiday"] = _holiday;
    return map;
  }
}
