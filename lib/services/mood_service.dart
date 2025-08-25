import 'package:flutter/material.dart';
import '../models/mood_record.dart';

class MoodService extends ChangeNotifier {
  final List<MoodRecord> _records = [];

  List<MoodRecord> get records => _records;

  bool hasRecordForDate(DateTime date) {
    return _records.any((record) => 
      record.date.year == date.year &&
      record.date.month == date.month &&
      record.date.day == date.day
    );
  }

  MoodRecord? getRecordForDate(DateTime date) {
    try {
      return _records.firstWhere((record) => 
        record.date.year == date.year &&
        record.date.month == date.month &&
        record.date.day == date.day
      );
    } catch (e) {
      return null;
    }
  }

  void addRecord(MoodRecord record) {
    // 如果当天已有记录，则更新
    final existingIndex = _records.indexWhere((r) => 
      r.date.year == record.date.year &&
      r.date.month == record.date.month &&
      r.date.day == record.date.day
    );
    
    if (existingIndex != -1) {
      _records[existingIndex] = record;
    } else {
      _records.add(record);
    }
    
    _records.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  List<MoodRecord> getRecordsForLast7Days() {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    
    return _records.where((record) => 
      record.date.isAfter(sevenDaysAgo) && record.date.isBefore(now.add(const Duration(days: 1)))
    ).toList();
  }

  List<MoodRecord> getRecordsForDateRange(DateTime start, DateTime end) {
    return _records.where((record) => 
      record.date.isAfter(start.subtract(const Duration(days: 1))) && 
      record.date.isBefore(end.add(const Duration(days: 1)))
    ).toList();
  }

  Map<String, int> getMoodFrequency() {
    final frequency = <String, int>{};
    for (var record in _records) {
      frequency[record.mood] = (frequency[record.mood] ?? 0) + 1;
    }
    return frequency;
  }
}