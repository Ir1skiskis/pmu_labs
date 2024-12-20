class CardData {
  final String? text;
  final String? descriptionText;
  final String? imageUrl;
  final String? signDesc;
  late final String id;

  CardData(
    this.text, {
    required this.descriptionText,
    this.imageUrl,
    required this.signDesc,
    required this.id,
  });
}
