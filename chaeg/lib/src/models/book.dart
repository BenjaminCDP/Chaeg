class Book {
  final int id;
  final String name;

  const Book({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name
    };
  }
  
  @override
  String toString() {
    return 'Book{id: $id, name: $name}';
  }

  
}
