class Exam {
  int _id;
  int _subjectID;
  DateTime _examTime;
  String _location;
  int _duration;
  String _description;

  Exam(this._examTime, this._duration, [this._location, this._description]);

  int get id => _id;
  DateTime get examTime => _examTime;
  String get location => _location;
  int get duration => _duration;
  String get description => _description;
  int get subjectID => _subjectID;

  set examTime(DateTime newExamTime) => _examTime = newExamTime;
  set location(String newLocation) => _location = newLocation;
  set duration(int newDuration) => _duration = newDuration;
  set description(String newDescription) => _description = newDescription;
  set subjectID(int newSubjectID) => _subjectID = newSubjectID;

  Exam.map(dynamic o) {
    this._subjectID = o["subjectID"];
    this._examTime = o["examTime"];
    this._location = o["location"];
    this._duration = o["duration"];
    this._description = o["description"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["subjectID"] = _subjectID;
    map["examTime"] = _examTime;
    map["location"] = _location;
    map["duration"] = _duration;
    map["description"] = _description;
  }

  
}
