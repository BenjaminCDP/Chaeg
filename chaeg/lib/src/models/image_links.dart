class ImageLinks {
  final String? smallThumbnail;
  final String? thumbnail;
  final String? small;
  final String? medium;
  final String? large;
  final String? extraLarge;

  const ImageLinks(
      {required this.smallThumbnail,
      required this.thumbnail,
      required this.small,
      required this.medium,
      required this.large,
      required this.extraLarge});

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    final smallThumbnail = json['smallThumbnail'] as String?;
    final thumbnail = json['thumbnail'] as String?;
    final small = json['small'] as String?;
    final medium = json['medium'] as String?;
    final large = json['large'] as String?;
    final extraLarge = json['extraLarge'] as String?;
    return ImageLinks(smallThumbnail: smallThumbnail,thumbnail: thumbnail, small: small, medium: medium, large: large, extraLarge: extraLarge);
  }
}
