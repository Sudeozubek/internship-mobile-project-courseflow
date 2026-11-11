import 'package:flutter/material.dart';

import '../app_routes.dart';
import '../services/want_api_service.dart';

/// Portal-style home: kısayollar yerel JSON verilerine gider (arka uç yok).
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 16 / 5,
            child: Image.network(
              WantApiService.bannerUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => ColoredBox(
                color: cs.primaryContainer,
                child: Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 40,
                    color: cs.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
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
                        'Aşağıdaki kutular özet bilgilere ve ilgili listelere gider.',
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
          subtitle: 'Ders kodu, teslim tarihi ve durum bilgisi.',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.assignments);
          },
        ),
        _sectionCard(
          context,
          icon: Icons.campaign_outlined,
          title: 'Duyurular',
          subtitle:
              'Kayıt, sınav ve burs duyuruları; tarih ve detay metinleri.',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.announcements);
          },
        ),
        _sectionCard(
          context,
          icon: Icons.event_note_outlined,
          title: 'Sınav takvimi',
          subtitle:
              'Vize, final ve bütünleme; tarih, saat ve salon bilgileri.',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.examSchedule);
          },
        ),
        _sectionCard(
          context,
          icon: Icons.calendar_month_outlined,
          title: 'Akademik takvim',
          subtitle: 'Dönem, tatil ve sınav dönemleri; tarih aralıkları.',
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.academicCalendar);
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
