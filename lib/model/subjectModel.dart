class Subject {
  int _id;
  String _name;
  String _color;
  String _year;

  Subject(this._name, this._year, [this._color]);

  int get id => _id;
  String get name => _name;
  String get color => _color;
  String get year => _year;

  set name(String newName) {
    if (newName.length <= 255) {
      _name = newName;
    }
  }

  set color(String newColor) {
    if (newColor.length <= 6) {
      _color = newColor;
    }
  }

  set year(String newYear) {
    _year = newYear;
  }

  Subject.map(dynamic o) {
    this._name = o["name"];
    this._color = o["color"];
    this._year = o["year"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["color"] = _color;
    map["year"] = _year;
    return map;
  }
}
