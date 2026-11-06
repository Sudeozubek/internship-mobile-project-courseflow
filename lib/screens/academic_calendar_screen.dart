import 'package:flutter/material.dart';

import '../models/portal_content.dart';
import '../services/portal_data_service.dart';

class AcademicCalendarScreen extends StatefulWidget {
  const AcademicCalendarScreen({super.key});

  @override
  State<AcademicCalendarScreen> createState() => _AcademicCalendarScreenState();
}

class _AcademicCalendarScreenState extends State<AcademicCalendarScreen> {
  final PortalDataService _service = PortalDataService();

  List<AcademicPeriod> _items = <AcademicPeriod>[];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final List<AcademicPeriod> list =
          await _service.loadAcademicCalendar();
      if (!mounted) {
        return;
      }
      setState(() {
        _items = list;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  String _dateRange(AcademicPeriod p) {
    if (p.startDate == p.endDate) {
      return p.startDate;
    }
    return '${p.startDate} – ${p.endDate}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akademik takvim'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(_error!, textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _load,
                          child: const Text('Yeniden dene'),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (BuildContext context, int i) {
                    final AcademicPeriod p = _items[i];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            p.type.isEmpty ? '·' : p.type.substring(0, 1),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        title: Text(p.title),
                        subtitle: Text(
                          '${_dateRange(p)} · ${p.type}',
                        ),
                        isThreeLine: false,
                      ),
                    );
                  },
                ),
    );
  }
}
