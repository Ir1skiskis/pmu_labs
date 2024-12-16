part of 'home_page.dart';

typedef OnLikeCallback = void Function(String title, bool isLiked)?;

class _CardSign extends StatefulWidget {
  final String text;
  final String descriptionText;
  final String? imageUrl;
  final OnLikeCallback? onLike;
  final VoidCallback? onTap;

  const _CardSign(
    this.text, {
    required this.descriptionText,
    this.imageUrl,
    this.onLike,
    this.onTap,
  });

  factory _CardSign.fromData(
    CardData data, {
    OnLikeCallback? onLike,
    VoidCallback? onTap,
  }) =>
      _CardSign(
        data.text!,
        descriptionText: data.descriptionText!,
        imageUrl: data.imageUrl,
        onLike: onLike,
        onTap: onTap,
      );

  @override
  State<_CardSign> createState() => _CardSignState();
}

class _CardSignState extends State<_CardSign> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
                            widget.imageUrl ?? '',
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
                          widget.text,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          widget.descriptionText,
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
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                        widget.onLike?.call(widget.text, isLiked);
                      },
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
