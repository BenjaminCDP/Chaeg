class Book {
  String _name;
  String get getName {
    return _name;
  }

  set setName(String name) {
    _name = name;
  }

  Book(this._name);
}
