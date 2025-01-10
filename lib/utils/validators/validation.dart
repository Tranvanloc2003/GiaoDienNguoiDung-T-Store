class TValidator {
  // Biến văn bản trống
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName là bắt buộc.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email là bắt buộc.';
    }

    // Biểu thức chính quy để kiểm tra email
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Địa chỉ email không hợp lệ.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu là bắt buộc.';
    }

    // Kiểm tra độ dài tối thiểu của mật khẩu
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự.';
    }

    // Kiểm tra chữ hoa
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Mật khẩu phải chứa ít nhất một chữ hoa.';
    }

    // Kiểm tra số
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Mật khẩu phải chứa ít nhất một số.';
    }

    // Kiểm tra ký tự đặc biệt
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Mật khẩu phải chứa ít nhất một ký tự đặc biệt.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số điện thoại là bắt buộc.';
    }

    // Biểu thức chính quy để kiểm tra số điện thoại (giả sử định dạng số điện thoại 10 chữ số của Mỹ)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Định dạng số điện thoại không hợp lệ (yêu cầu 10 chữ số).';
    }

    return null;
  }

// Thêm các phương thức kiểm tra tùy chỉnh khác theo yêu cầu cụ thể của bạn.
}
