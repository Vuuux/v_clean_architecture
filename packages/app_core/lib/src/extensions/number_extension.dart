import 'package:intl/intl.dart';

extension NumberExtension on num {
  String toCurrencyString() {
    return '\$${toStringAsFixed(2)}';
  }

  String formattedWithCommas() {
    final formatter = NumberFormat('#,###');
    return formatter.format(this);
  }
}
