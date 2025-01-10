import 'package:intl/intl.dart';

class TFormatter {
  /// Định dạng ngày tháng theo mẫu dd-MMM-yyyy
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date); // Có thể tùy chỉnh định dạng ngày tháng theo nhu cầu
  }

  /// Định dạng số tiền theo định dạng tiền tệ
  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(amount); // Có thể tùy chỉnh locale và ký hiệu tiền tệ theo nhu cầu
  }

  /// Định dạng số điện thoại theo mẫu chuẩn
  static String formatPhoneNumber(String phoneNumber) {
    // Giả sử định dạng số điện thoại Việt Nam: 0123 456 789
    if (phoneNumber.length == 10) {
      return '${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    } else if (phoneNumber.length == 11) {
      return '${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
    // Có thể thêm logic định dạng số điện thoại khác nếu cần
    return phoneNumber;
  }

  /// Định dạng số điện thoại quốc tế (chưa test đầy đủ)
  static String internationalFormatPhoneNumber(String phoneNumber) {
    // Loại bỏ các ký tự không phải số từ số điện thoại
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Trích xuất mã quốc gia từ chuỗi số
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    // Thêm các số còn lại với định dạng phù hợp
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode) ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+84') { // Thay đổi +1 thành +84 cho Việt Nam
        groupLength = 3;
      }

      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }

    return formattedNumber.toString();
  }
}


/*
*
*
* */
