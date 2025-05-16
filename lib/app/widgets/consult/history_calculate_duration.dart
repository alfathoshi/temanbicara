import 'package:flutter/material.dart';

String calculateDuration(String? start, String? end) {
  if (start == null || end == null) return '-';

  try {
    final s = TimeOfDay(
      hour: int.parse(start.split(':')[0]),
      minute: int.parse(start.split(':')[1]),
    );
    final e = TimeOfDay(
      hour: int.parse(end.split(':')[0]),
      minute: int.parse(end.split(':')[1]),
    );

    final duration = (e.hour * 60 + e.minute) - (s.hour * 60 + s.minute);
    return "$duration menit";
  } catch (_) {
    return '-';
  }
}
