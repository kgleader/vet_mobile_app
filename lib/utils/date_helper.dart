import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateHelper {
  /// Initialize date formatting for all supported locales
  static Future<void> initialize() async {
    // Initialize for Kyrgyz
    await initializeDateFormatting('ky');
    
    // Initialize for Russian
    await initializeDateFormatting('ru');
    
    // Initialize for English (fallback)
    await initializeDateFormatting('en');
  }
  
  /// Get the current formatted date
  static String getCurrentDate({String locale = 'ky', String pattern = 'dd MMM yyyy'}) {
    return DateFormat(pattern, locale).format(DateTime.now());
  }
}
