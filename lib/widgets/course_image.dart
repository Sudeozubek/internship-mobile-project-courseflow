import 'package:flutter/material.dart';

import '../models/course.dart';

/// Asset veya ağ kaynağı (API görseli).
class CourseImage extends StatelessWidget {
  const CourseImage({
    super.key,
    required this.course,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  });

  final Course course;
  final BoxFit fit;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    Widget errorPlaceholder() {
      return ColoredBox(
        color: cs.primaryContainer,
        child: Icon(
          Icons.menu_book_rounded,
          size: 44,
          color: cs.onPrimaryContainer.withValues(alpha: 0.75),
        ),
      );
    }

    if (course.usesNetworkImage) {
      return Image.network(
        course.image,
        fit: fit,
        alignment: alignment,
        filterQuality: FilterQuality.medium,
        loadingBuilder: (
          BuildContext context,
          Widget child,
          ImageChunkEvent? loadingProgress,
        ) {
          if (loadingProgress == null) {
            return child;
          }
          final int? total = loadingProgress.expectedTotalBytes;
          final int loaded = loadingProgress.cumulativeBytesLoaded;
          return Center(
            child: CircularProgressIndicator(
              value: total != null ? loaded / total : null,
            ),
          );
        },
        errorBuilder: (_, __, ___) => errorPlaceholder(),
      );
    }

    return Image.asset(
      course.image,
      fit: fit,
      alignment: alignment,
      filterQuality: FilterQuality.medium,
      errorBuilder: (_, __, ___) => errorPlaceholder(),
    );
  }
}
