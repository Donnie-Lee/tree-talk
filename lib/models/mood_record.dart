import 'package:flutter/material.dart';

class MoodRecord {
  final DateTime date;
  final String mood;
  final String? content;
  final Color color;
  final IconData icon;
  final DateTime createdAt;

  MoodRecord({
    required this.date,
    required this.mood,
    this.content,
    required this.color,
    required this.icon,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  MoodRecord copyWith({
    DateTime? date,
    String? mood,
    String? content,
    Color? color,
    IconData? icon,
    DateTime? createdAt,
  }) {
    return MoodRecord(
      date: date ?? this.date,
      mood: mood ?? this.mood,
      content: content ?? this.content,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'mood': mood,
      'content': content,
      'color': color.toARGB32(),
      'icon': icon.codePoint,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory MoodRecord.fromMap(Map<String, dynamic> map) {
    return MoodRecord(
      date: DateTime.parse(map['date']),
      mood: map['mood'],
      content: map['content'],
      color: Color(map['color']),
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}