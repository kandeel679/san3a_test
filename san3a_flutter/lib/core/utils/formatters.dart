import 'package:intl/intl.dart';

class Formatters {
  static String formatCurrency(double amount) {
    final NumberFormat currencyFormatter = NumberFormat.currency(symbol: 'EGP ', decimalDigits: 2);
    return currencyFormatter.format(amount);
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }
}
