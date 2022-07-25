class VolumeInfo {
  final String title;
  final String author;

  const VolumeInfo({required this.title, required this.author});

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    final title = json['title'] as String;
    final author = json['authors'][0] as String;
    return VolumeInfo(title: title, author: author);
  }
}
