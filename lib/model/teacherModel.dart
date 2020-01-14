class Teacher {
  int _id;
  String _name;

  Teacher();
  
  

  int get id => _id;
  String get name => _name;

  set name(String newName) {
    _name = newName;
  }

  Teacher.map(dynamic o) {
    this._name = o["name"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    return map;
  }
}