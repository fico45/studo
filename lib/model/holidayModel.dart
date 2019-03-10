class Holiday {
  int _id;
  DateTime _startDate;
  DateTime _endDate;

  Holiday(this._startDate, this._endDate);

  int get id => _id;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;

  set startDate(DateTime newStartDate) {
    _startDate = newStartDate;
  }

  set endDate(DateTime newEndDate) {
    _endDate = newEndDate;
  }

  Holiday.map(dynamic o) {
    this._startDate = o["startDate"];
    this._endDate = o["endDate"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["startDate"] = _startDate;
    map["endDate"] = _endDate;
    return map;
  }
}
