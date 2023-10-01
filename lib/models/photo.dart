// ignore_for_file: public_member_api_docs, sort_constructors_first
class Photo {
  final int? id;
  final String? imagePath;
  final DateTime? timestamp;

  Photo({
    this.id,
    required this.imagePath,
    required this.timestamp,
  });
}
