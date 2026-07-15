/// Cache the months array as static const
const _thaiMonths = [
  '',
  'ม.ค.',
  'ก.พ.',
  'มี.ค.',
  'เม.ย.',
  'พ.ค.',
  'มิ.ย.',
  'ก.ค.',
  'ส.ค.',
  'ก.ย.',
  'ต.ค.',
  'พ.ย.',
  'ธ.ค.',
];

const _thaiMonthsFullName = [
  '',
  'มกราคม',
  'กุมภาพันธ์',
  'มีนาคม',
  'เมษายน',
  'พฤษภาคม',
  'มิถุนายน',
  'กรกฎาคม',
  'สิงหาคม',
  'กันยายน',
  'ตุลาคม',
  'พฤศจิกายน',
  'ธันวาคม',
];

/// Formatted date object with convenient getters
class FormattedDate {
  const FormattedDate({
    required this.hours,
    required this.minutes,
    required this.day,
    required this.month,
    required this.year,
    required this.fullYear,
  });

  final String hours;
  final String minutes;
  final String day;
  final String month;
  final String year;
  final String fullYear;

  /// Returns formatted date as "DD MMM YY"
  String get short => '$day $month $year';

  /// Returns formatted date as "DD MMM YYYY"
  String get full => '$day $month $fullYear';

  /// Returns only day and month "DD MMM"
  String get dayMonth => '$day $month';

  /// Returns full date with time "HH.mm - DD MMM YYYY"
  String get hhmmDDMMYYY => '$hours.$minutes น. - $day $month $fullYear';

  // Returns full date with time "DD MMM YYYY HH.mm"
  String get ddMMYYYhhmm => '$day $month $fullYear $hours.$minutes';
}

/// Extension for DateTime to make formatting more convenient
extension DateTimeFormatterExtension on DateTime {
  /// Format this DateTime with Buddhist calendar (default)
  FormattedDate format({
    bool useBuddhistCalendar = true,
    bool showFullMonth = false,
  }) {
    if (useBuddhistCalendar) {
      final buddhistYear = year + 543;
      final shortYear = (buddhistYear % 100).toString().padLeft(2, '0');

      return FormattedDate(
        hours: hour.toString().padLeft(2, '0'),
        minutes: minute.toString().padLeft(2, '0'),
        day: day.toString().padLeft(2, '0'),
        month: showFullMonth ? _thaiMonthsFullName[month] : _thaiMonths[month],
        year: shortYear,
        fullYear: buddhistYear.toString(),
      );
    } else {
      return FormattedDate(
        hours: hour.toString().padLeft(2, '0'),
        minutes: minute.toString().padLeft(2, '0'),
        day: day.toString().padLeft(2, '0'),
        month: month.toString().padLeft(2, '0'),
        year: year.toString(),
        fullYear: year.toString(),
      );
    }
  }

  /// Format date as string with optional prefix
  String formatDateString({
    bool showPrefix = false,
    bool useBuddhistCalendar = true,
    String prefix = 'วันที่ ',
    bool showFullYear = false,
  }) {
    final formatted = format(useBuddhistCalendar: useBuddhistCalendar);
    final dateStr =
        '${formatted.day} ${formatted.month} ${showFullYear ? formatted.fullYear : formatted.year}';
    return showPrefix ? '$prefix$dateStr' : dateStr;
  }

  /// Format time range from this DateTime to another
  String formatTimeRange(DateTime end) {
    final startTime =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    final endTime =
        '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';

    // If start and end are the same, return only one time
    if (startTime == endTime) {
      return startTime;
    }
    return '$startTime - $endTime';
  }

  /// Format time with dot separator (e.g., "14.30")
  String formatTimeWithDot() {
    return '${hour.toString().padLeft(2, '0')}.${minute.toString().padLeft(2, '0')}';
  }

  /// Format time range with dot separator (e.g., "14.30 - 16.00")
  String formatTimeRangeWithDot(DateTime end) {
    final startTime = formatTimeWithDot();
    final endTime = end.formatTimeWithDot();

    // If start and end are the same, return only one time
    if (startTime == endTime) {
      return startTime;
    }
    return '$startTime - $endTime';
  }

  /// Format full date with Buddhist calendar (e.g., "20 ม.ค. 2568")
  String formatFullDate({bool useBuddhistCalendar = true}) {
    final formatted = format(useBuddhistCalendar: useBuddhistCalendar);
    return '${formatted.day} ${formatted.month} ${formatted.fullYear}';
  }

  /// Format date range from this DateTime to another
  /// Returns formatted date range like "20 ม.ค. 68 - 30 ม.ค. 68"
  /// If showFullFormat is true, returns "03 มีนาคม 2568 - 05 มีนาคม 2568"
  String formatDateRange(
    DateTime endDate, {
    bool useBuddhistCalendar = true,
    bool showFullFormat = false,
  }) {
    final start = format(
      useBuddhistCalendar: useBuddhistCalendar,
      showFullMonth: showFullFormat,
    );
    final end = endDate.format(
      useBuddhistCalendar: useBuddhistCalendar,
      showFullMonth: showFullFormat,
    );

    // If same date, return only one date
    if (year == endDate.year && month == endDate.month && day == endDate.day) {
      return showFullFormat ? start.full : start.short;
    }

    if (year == endDate.year && month == endDate.month) {
      // Same month and year
      if (showFullFormat) {
        return '${start.day} ${start.month} ${start.fullYear} - ${end.day} ${end.month} ${end.fullYear}';
      }
      return '${start.day} ${start.month} ${start.year} - ${end.day} ${end.month} ${end.year}';
    }

    // If same year, show: "20 ม.ค. - 30 ก.พ. 68" or "20 มกราคม - 30 กุมภาพันธ์ 2568"
    if (year == endDate.year) {
      if (showFullFormat) {
        return '${start.day} ${start.month} - ${end.day} ${end.month} ${end.fullYear}';
      }
      return '${start.day} ${start.month} - ${end.day} ${end.month} ${end.year}';
    }

    // Different years, show full dates: "20 ม.ค. 68 - 30 ม.ค. 69" or "20 มกราคม 2568 - 30 มกราคม 2569"
    if (showFullFormat) {
      return '${start.full} - ${end.full}';
    }
    return '${start.short} - ${end.short}';
  }

  /// Check if this date is in the future
  bool get isFuture => isAfter(DateTime.now());

  /// Check if this date is in the past
  bool get isPast => isBefore(DateTime.now());
}

/// Extension for String dates
extension StringDateFormatterExtension on String {
  /// Parse this date string to DateTime
  ///
  /// [useLocalTime] - If true, converts UTC time to device's local timezone (default: true)
  DateTime? parseDateTime({bool useLocalTime = true}) {
    try {
      var date = DateTime.parse(this);
      if (useLocalTime) {
        date = date.toLocal();
      }
      return date;
    } catch (e) {
      return null;
    }
  }

  /// Parse and format this date string
  ///
  /// [useLocalTime] - If true, converts UTC time to device's local timezone (default: true)
  /// [useBuddhistCalendar] - If true, uses Buddhist calendar for year calculation
  FormattedDate? formatDate({
    bool useBuddhistCalendar = true,
    bool useLocalTime = true,
  }) {
    try {
      var date = DateTime.parse(this);
      if (useLocalTime) {
        date = date.toLocal();
      }
      return date.format(useBuddhistCalendar: useBuddhistCalendar);
    } catch (e) {
      return null;
    }
  }

  /// Format date as string with optional prefix
  ///
  /// [useLocalTime] - If true, converts UTC time to device's local timezone (default: true)
  /// [showPrefix] - If true, adds a prefix before the date
  /// [useBuddhistCalendar] - If true, uses Buddhist calendar for year calculation
  /// [prefix] - The prefix text to add (default: 'วันที่ ')
  /// [showFullYear] - If true, shows full year instead of short year
  String formatDateString({
    bool showPrefix = false,
    bool useBuddhistCalendar = true,
    String prefix = 'วันที่ ',
    bool showFullYear = false,
    bool useLocalTime = true,
  }) {
    try {
      var date = DateTime.parse(this);
      if (useLocalTime) {
        date = date.toLocal();
      }
      return date.formatDateString(
        showPrefix: showPrefix,
        useBuddhistCalendar: useBuddhistCalendar,
        prefix: prefix,
        showFullYear: showFullYear,
      );
    } catch (e) {
      return '';
    }
  }

  /// Format time range from two date strings
  ///
  /// [useLocalTime] - If true, converts UTC time to device's local timezone (default: true)
  String? formatTimeRange(String endDate, {bool useLocalTime = true}) {
    try {
      var start = DateTime.parse(this);
      var end = DateTime.parse(endDate);
      if (useLocalTime) {
        start = start.toLocal();
        end = end.toLocal();
      }
      return start.formatTimeRange(end);
    } catch (e) {
      return null;
    }
  }

  /// Format date range from two date strings
  ///
  /// [useLocalTime] - If true, converts UTC time to device's local timezone (default: true)
  /// [useBuddhistCalendar] - If true, uses Buddhist calendar for year calculation
  String? formatDateRange(
    String endDate, {
    bool useBuddhistCalendar = true,
    bool useLocalTime = true,
  }) {
    try {
      var start = DateTime.parse(this);
      var end = DateTime.parse(endDate);
      if (useLocalTime) {
        start = start.toLocal();
        end = end.toLocal();
      }
      return start.formatDateRange(
        end,
        useBuddhistCalendar: useBuddhistCalendar,
      );
    } catch (e) {
      return null;
    }
  }
}
