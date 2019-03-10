class DaysOfWeek {
  int _classID;
  bool _monday;
  bool _tuesday;
  bool _wednesday;
  bool _thursday;
  bool _friday;
  bool _saturday;
  bool _sunday;

  DaysOfWeek(this._monday, this._tuesday, this._wednesday, this._thursday,
      this._friday, this._saturday, this._sunday);

  int get id => _classID;
  bool get monday => _monday;
  bool get tuesday => _tuesday;
  bool get wednesday => _wednesday;
  bool get thursday => _thursday;
  bool get friday => _friday;
  bool get saturday => _saturday;
  bool get sunday => _sunday;

  set monday(bool newMonday) {
    _monday = newMonday;
  }

  set tuesday(bool newTuesday) {
    _tuesday = newTuesday;
  }

  set wednesday(bool newWednesday) {
    _wednesday = newWednesday;
  }

  set thursday(bool newThursday) {
    _thursday = newThursday;
  }

  set friday(bool newFriday) {
    _friday = newFriday;
  }

  set saturday(bool newSaturday) {
    _saturday = newSaturday;
  }

  set sunday(bool newSunday) {
    _sunday = newSunday;
  }

  DaysOfWeek.map(dynamic o) {
    this._monday = o["monday"];
    this._tuesday = o["tuesday"];
    this._wednesday = o["wednesday"];
    this._thursday = o["thursday"];
    this._friday = o["friday"];
    this._saturday = o["saturday"];
    this._sunday = o["sunday"];
  }

  

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["monday"] = _monday;
    map["tuesday"] = _tuesday;
    map["wednesday"] = _wednesday;
    map["thursday"] = _thursday;
    map["friday"] = _friday;
    map["saturday"] = _saturday;
    map["sunday"] = _sunday;
    return map;
  }
}
