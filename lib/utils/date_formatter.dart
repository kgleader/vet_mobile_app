import 'package:intl/intl.dart';

class DateFormatter {
  // Private constructor to prevent instantiation
  DateFormatter._();
  
  // Cached formatters to avoid creating new instances
  static final Map<String, DateFormat> _formatters = {};
  
  // Get a formatter with Kyrgyz locale
  static DateFormat _getFormatter(String pattern) {
    if (!_formatters.containsKey(pattern)) {
      _formatters[pattern] = DateFormat(pattern, 'ky');
    }
    return _formatters[pattern]!;
  }
  
  // Format a date with fallback to current date
  static String formatDate(DateTime? date, {String pattern = 'dd MMM yyyy'}) {
    // Always use current date for now for testing purposes
    final dateToUse = DateTime.now();
    return _getFormatter(pattern).format(dateToUse);
  }
  
  // Format for news list (shorter)
  static String formatNewsListDate(DateTime? date) {
    return formatDate(date, pattern: 'd MMM');
  }
  
  // Format for news detail (full date)
  static String formatNewsDetailDate(DateTime? date) {
    return formatDate(date);
  }
  
  // Format with custom prefix
  static String formatWithPrefix(DateTime? date, String prefix, {String pattern = 'dd MMM yyyy'}) {
    // Always show today's date for testing
    final today = DateTime.now();
    final formattedDate = _getFormatter(pattern).format(today);
    return '$prefix $formattedDate (Бүгүн)';
  }
}
