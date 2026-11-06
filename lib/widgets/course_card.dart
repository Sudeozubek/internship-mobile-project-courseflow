import 'package:flutter/material.dart';

import '../models/course.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    required this.onDetail,
  });

  final Course course;
  final VoidCallback onDetail;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      surfaceTintColor: cs.surfaceTint,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  course.image,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (
                    BuildContext context,
                    Object error,
                    StackTrace? stackTrace,
                  ) {
                    return ColoredBox(
                      color: cs.primaryContainer,
                      child: Icon(
                        Icons.menu_book_rounded,
                        size: 48,
                        color: cs.onPrimaryContainer.withValues(alpha: 0.7),
                      ),
                    );
                  },
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        cs.scrim.withValues(alpha: 0.05),
                        cs.scrim.withValues(alpha: 0.5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(
                        course.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              course.code,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: cs.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              course.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: cs.onSurfaceVariant,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onDetail,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Detay'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
