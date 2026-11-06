import 'package:flutter/material.dart';

/// Minimal “portal style” home: static sections only (no backend, no extra features).
/// Full UBİS parity is out of scope for the internship brief; this is a visual stub.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating),
    );
  }

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
                        'Dersler ve görevler için “Dersler” sekmesini kullanın. '
                        'Aşağıdaki kutular örnek portal düzeni içindir (sabit metin).',
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
              'Bu sürümde ödev listesi yok; görevler ders detayındaki çalışma maddesinde.',
          onTap: () => _toast(context, 'Ödevler: örnek alan (veri yok).'),
        ),
        _sectionCard(
          context,
          icon: Icons.campaign_outlined,
          title: 'Duyurular',
          subtitle: 'Kayıt ve sınav duyuruları burada listelenirdi (örnek).',
          onTap: () => _toast(context, 'Duyurular: örnek alan.'),
        ),
        _sectionCard(
          context,
          icon: Icons.event_note_outlined,
          title: 'Sınav takvimi',
          subtitle: 'Vize / final tarihleri için örnek kart (takvim verisi yok).',
          onTap: () => _toast(context, 'Sınav takvimi: örnek alan.'),
        ),
        _sectionCard(
          context,
          icon: Icons.calendar_month_outlined,
          title: 'Akademik takvim',
          subtitle: 'Dönem başı/sonu ve tatiller (örnek; yerel veri yok).',
          onTap: () => _toast(context, 'Akademik takvim: örnek alan.'),
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
