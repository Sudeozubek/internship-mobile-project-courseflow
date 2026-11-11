import 'package:flutter/material.dart';

import '../models/course.dart';
import 'course_image.dart';

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
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double h = constraints.maxHeight.isFinite
              ? constraints.maxHeight
              : 240;
          final double imageHeight = (h * 0.42).clamp(92.0, h * 0.52);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: imageHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    CourseImage(course: course),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            cs.scrim.withValues(alpha: 0.0),
                            cs.scrim.withValues(alpha: 0.42),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          visualDensity: VisualDensity.compact,
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
                          minimumSize: const Size.fromHeight(40),
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
          );
        },
      ),
    );
  }
}
