class Book {
  String name;

  Book({required this.name});

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  setName(String name) {
    this.name = name;
  }

  @override
  String toString() {
    return 'Book{name: $name}';
  }
}
