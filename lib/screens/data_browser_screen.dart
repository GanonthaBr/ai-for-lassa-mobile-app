import 'package:flutter/material.dart';
import '../models/statistics_data.dart';
import '../services/api_service.dart';

class DataBrowserScreen extends StatefulWidget {
  const DataBrowserScreen({Key? key}) : super(key: key);

  @override
  State<DataBrowserScreen> createState() => _DataBrowserScreenState();
}

class _DataBrowserScreenState extends State<DataBrowserScreen> {
  final List<String> _states = ['Lagos', 'Abuja', 'Kano', 'Rivers'];
  final List<String> _intervals = ['month', 'week'];

  String? _selectedState;
  String? _selectedInterval = 'month';
  DateTime? _startDate;
  DateTime? _endDate;

  bool _loading = false;
  String? _error;
  List<StatisticsData> _results = [];

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final initial = isStart ? (_startDate ?? now) : (_endDate ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _search() async {
    setState(() {
      _loading = true;
      _error = null;
      _results = [];
    });
    try {
      final results = await ApiService.fetchStatisticsData(
        state: _selectedState,
        startDate: _startDate != null
            ? _startDate!.toIso8601String().split('T').first
            : null,
        endDate: _endDate != null
            ? _endDate!.toIso8601String().split('T').first
            : null,
        interval: _selectedInterval,
      );
      setState(() {
        _results = results;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Browse Statistics')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedState,
                    hint: const Text('Select State'),
                    items: _states
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedState = val),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedInterval,
                    hint: const Text('Interval'),
                    items: _intervals
                        .map((i) => DropdownMenuItem(value: i, child: Text(i)))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedInterval = val),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickDate(isStart: true),
                    child: Text(
                      _startDate == null
                          ? 'Start Date'
                          : _startDate!.toLocal().toString().split(' ')[0],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickDate(isStart: false),
                    child: Text(
                      _endDate == null
                          ? 'End Date'
                          : _endDate!.toLocal().toString().split(' ')[0],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _search,
                child: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Search'),
              ),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            if (!_loading && _results.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemCount: _results.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, idx) {
                    final stat = _results[idx];
                    return ListTile(
                      title: Text('${stat.state} - ${stat.month}'),
                      subtitle: Text(
                        'Cases: ${stat.cases}, Deaths: ${stat.deaths}, Recoveries: ${stat.recoveries}',
                      ),
                    );
                  },
                ),
              ),
            if (!_loading && _results.isEmpty && _error == null)
              const Text('No data to display.'),
          ],
        ),
      ),
    );
  }
}
