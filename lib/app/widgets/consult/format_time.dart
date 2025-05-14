String formatTime(String? time) {
  if (time == null) return '-';

  try {
    final parts = time.split(':');
    if (parts.length >= 2) {
      return '${parts[0]}:${parts[1]}';
    }
    return '-';
  } catch (_) {
    return '-';
  }
}
