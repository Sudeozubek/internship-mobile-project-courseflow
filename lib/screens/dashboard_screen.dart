import 'package:flutter/material.dart';

import 'academic_calendar_screen.dart';
import 'announcements_screen.dart';
import 'assignments_screen.dart';
import 'exam_schedule_screen.dart';

/// Portal-style home: shortcuts to mock data screens (bundled JSON, no backend).
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: <Widget>[
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Icon(Icons.school_rounded, size: 40, color: cs.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Öğrenci paneli',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ders içerikleri ve çalışma maddeleri için “Dersler” sekmesine geçin. '
                        'Aşağıdaki kutular yerel JSON ile doldurulmuş örnek portal verilerini açar (canlı sistem değil).',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _sectionCard(
          context,
          icon: Icons.assignment_outlined,
          title: 'Ödevler',
          subtitle:
              'Ders kodu, teslim tarihi ve durum — yerel listeden (mock).',
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const AssignmentsScreen(),
              ),
            );
          },
        ),
        _sectionCard(
          context,
          icon: Icons.campaign_outlined,
          title: 'Duyurular',
          subtitle:
              'Kayıt, sınav ve burs duyuruları — kısa metinli örnek kayıtlar.',
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const AnnouncementsScreen(),
              ),
            );
          },
        ),
        _sectionCard(
          context,
          icon: Icons.event_note_outlined,
          title: 'Sınav takvimi',
          subtitle:
              'Vize / final / bütünleme satırları — tarih, saat ve salon (mock).',
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const ExamScheduleScreen(),
              ),
            );
          },
        ),
        _sectionCard(
          context,
          icon: Icons.calendar_month_outlined,
          title: 'Akademik takvim',
          subtitle:
              'Dönem, tatil ve sınav haftaları — tarih aralıkları (mock).',
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const AcademicCalendarScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _sectionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(icon, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
