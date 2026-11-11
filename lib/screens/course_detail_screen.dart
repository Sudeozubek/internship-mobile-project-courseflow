import 'package:flutter/material.dart';

import '../models/course.dart';
import '../widgets/course_image.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key, required this.course});

  final Course course;

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    final Course course = widget.course;
    final ThemeData theme = Theme.of(context);
    final bool catalogItem = course.fromApi;

    return Scaffold(
      appBar: AppBar(
        title: Text(course.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Geri',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: CourseImage(course: course),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(catalogItem ? 'Ürün adı' : 'Ders adı'),
                  subtitle: Text(course.name),
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(catalogItem ? 'Katalog kodu' : 'Ders kodu'),
                  subtitle: Text(course.code),
                ),
                const Divider(height: 1),
                ListTile(
                  title: Text(
                    catalogItem ? 'Kısa açıklama' : 'Öğretim görevlisi',
                  ),
                  subtitle: Text(course.instructor),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Açıklama'),
                  subtitle: Text(course.description),
                ),
                if (course.price != null) ...<Widget>[
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Fiyat'),
                    subtitle: Text(course.price!),
                  ),
                ],
                if (!catalogItem) ...<Widget>[
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Kredi'),
                    subtitle: Text('${course.credits}'),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    catalogItem ? 'İnceleme görevi' : 'Çalışma görevi',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(course.task),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: _isCompleted
                      ? null
                      : () {
                          setState(() {
                            _isCompleted = true;
                          });
                        },
                  child: const Text('Tamamlandı'),
                ),
              ),
            ],
          ),
          if (_isCompleted) ...<Widget>[
            const SizedBox(height: 12),
            Text(
              '✓ Tamamlandı',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
