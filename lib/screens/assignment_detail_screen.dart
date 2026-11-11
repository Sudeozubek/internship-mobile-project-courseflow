import 'package:flutter/material.dart';

import '../models/portal_content.dart';
import '../services/assignment_submission_service.dart';

class AssignmentDetailScreen extends StatefulWidget {
  const AssignmentDetailScreen({super.key, required this.assignment});

  final AssignmentItem assignment;

  @override
  State<AssignmentDetailScreen> createState() => _AssignmentDetailScreenState();
}

class _AssignmentDetailScreenState extends State<AssignmentDetailScreen> {
  final AssignmentSubmissionService _submission = AssignmentSubmissionService();
  final TextEditingController _fileController = TextEditingController();
  late AssignmentItem _assignment;
  bool _submitting = false;
  bool _markedComplete = false;

  @override
  void initState() {
    super.initState();
    _assignment = widget.assignment;
    _fileController.text = 'odev_${_assignment.id}.pdf';
    _markedComplete =
        _assignment.status == 'Teslim edildi' ||
        _assignment.status == 'Tamamlandı';
  }

  @override
  void dispose() {
    _fileController.dispose();
    super.dispose();
  }

  Future<void> _uploadAndSubmit() async {
    final String fileName = _fileController.text.trim();
    if (fileName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dosya adı girin.')),
      );
      return;
    }
    setState(() => _submitting = true);
    try {
      await _submission.submit(_assignment, fileName: fileName);
      if (!mounted) {
        return;
      }
      setState(() {
        _submitting = false;
        _markedComplete = true;
        _assignment = _assignment.copyWith(status: 'Teslim edildi');
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ödev sunucuya iletildi (eğitim POST yanıtı alındı).'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Teslim başarısız: $e')),
      );
    }
  }

  void _markCompletedLocally() {
    setState(() {
      _markedComplete = true;
      _assignment = _assignment.copyWith(status: 'Tamamlandı');
    });
  }

  void _popWithResult() {
    Navigator.pop<AssignmentItem>(context, _assignment);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop) {
          _popWithResult();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ödev detayı'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _popWithResult,
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Başlık'),
                    subtitle: Text(_assignment.title),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Ders'),
                    subtitle:
                        Text('${_assignment.courseCode} · ${_assignment.courseName}'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Son teslim'),
                    subtitle: Text(_assignment.dueDate),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Durum'),
                    subtitle: Text(
                      _assignment.status,
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _fileController,
              decoration: const InputDecoration(
                labelText: 'Teslim dosyası adı',
                helperText: 'Teslim isteğinde dosya adı JSON gövdesine yazılır.',
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _submitting || !_assignment.canSubmit
                  ? null
                  : _uploadAndSubmit,
              icon: _submitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.cloud_upload_outlined),
              label: Text(
                _submitting ? 'Gönderiliyor…' : 'Ödevi yükle (HTTP POST)',
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: _markedComplete ? null : _markCompletedLocally,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Tamamlandı olarak işaretle'),
            ),
            if (_markedComplete) ...<Widget>[
              const SizedBox(height: 16),
              Text(
                '✓ Bu ödev tamamlandı / teslim edildi.',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
