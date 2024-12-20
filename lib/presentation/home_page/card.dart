part of 'home_page.dart';

typedef OnLikeCallback = void Function(String? id, String title, bool isLiked)?;

class _CardSign extends StatelessWidget {
  final String text;
  final String descriptionText;
  final String? imageUrl;
  final OnLikeCallback? onLike;
  final VoidCallback? onTap;
  final String id;
  final bool isLiked;

  const _CardSign(
    this.text, {
    required this.descriptionText,
    this.imageUrl,
    this.onLike,
    this.onTap,
    required this.id,
    this.isLiked = false,
  });

  factory _CardSign.fromData(
    CardData data, {
    OnLikeCallback? onLike,
    VoidCallback? onTap,
    bool isLiked = false,
  }) =>
      _CardSign(
        data.text!,
        id: data.id,
        descriptionText: data.descriptionText!,
        imageUrl: data.imageUrl,
        onLike: onLike,
        onTap: onTap,
        isLiked: isLiked,
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          //padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  child: SizedBox(
                    height: 160,
                    width: 160,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            imageUrl ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Placeholder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          descriptionText,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 16,
                      bottom: 16,
                    ),
                    child: GestureDetector(
                      onTap: () => onLike?.call(id, text, isLiked),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: isLiked
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                                key: ValueKey<int>(0),
                              )
                            : const Icon(
                                Icons.favorite_border,
                                key: ValueKey<int>(1),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
