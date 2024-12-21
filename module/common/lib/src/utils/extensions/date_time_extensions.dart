extension DateTimeExtensions on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool isYesterday() {
    final now = DateTime.now().subtract(const Duration(days: 1));
    return year == now.year && month == now.month && day == now.day;
  }

  bool isTomorrow() {
    final now = DateTime.now().add(const Duration(days: 1));
    return year == now.year && month == now.month && day == now.day;
  }
}