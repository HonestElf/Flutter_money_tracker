String formatDate(DateTime date) {
  return '${date.year}-${_parseDatePart(date.month)}-${_parseDatePart(date.day)}';
}

String _parseDatePart(int part) {
  return part <= 9 ? '0$part' : '$part';
}
