import 'package:chaeg/src/models/image_links.dart';
import 'package:chaeg/src/models/volume_info.dart';

class Book {
  final VolumeInfo volumeInfo;
  final ImageLinks imageLinks;

  Book({required this.volumeInfo, required this.imageLinks});
}
