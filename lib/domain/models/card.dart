class CardData {
  final String text;
  final String descriptionText;
  final String? imageUrl;
  final String signDesc;

  CardData(
    this.text, {
    required this.descriptionText,
    this.imageUrl,
    required this.signDesc,
  });
}
