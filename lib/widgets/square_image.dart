import 'package:flutter/material.dart';

class SquareImage extends StatefulWidget {
  final String imageUrl;
  final Map<String, String> headers;
  const SquareImage(
      {super.key, required this.imageUrl, this.headers = const {}});

  @override
  State<SquareImage> createState() => _SquareImageState();
}

class _SquareImageState extends State<SquareImage> {
  @override
  Widget build(BuildContext context) {
    String image = widget.imageUrl;
    if (image.isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.network(
          "https://api.boterop.io/habit-hero/$image",
          fit: BoxFit.cover,
          headers: widget.headers,
          frameBuilder: (BuildContext context, Widget child, int? frame,
              bool? wasSynchronouslyLoaded) {
            return child;
          },
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            return loadingProgress == null
                ? child
                : Center(
                    child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null),
                  );
          },
        ),
      ),
    );
  }
}
