/// Exception class for handling various platform-related errors.
class TPlatformException implements Exception {
  final String code;

  TPlatformException(this.code);

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Thông tin đăng nhập không hợp lệ. Vui lòng kiểm tra lại.';
      case 'too-many-requests':
        return 'Quá nhiều yêu cầu. Vui lòng thử lại sau.';
      case 'invalid-argument':
        return 'Tham số xác thực không hợp lệ.';
      case 'invalid-password':
        return 'Sai mật khẩu. Vui lòng thử lại.';
      case 'invalid-phone-number':
        return 'Số điện thoại không hợp lệ.';
      case 'operation-not-allowed':
        return 'Phương thức đăng nhập này đã bị vô hiệu hóa cho dự án Firebase của bạn.';
      case 'session-cookie-expired':
        return 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.';
      case 'uid-already-exists':
        return 'ID người dùng đã được sử dụng bởi người dùng khác.';
      case 'sign_in_failed':
        return 'Đăng nhập thất bại. Vui lòng thử lại.';
      case 'network-request-failed':
        return 'Lỗi kết nối mạng. Vui lòng kiểm tra kết nối internet.';
      case 'internal-error':
        return 'Lỗi hệ thống. Vui lòng thử lại sau.';
      case 'invalid-verification-code':
        return 'Mã xác thực không hợp lệ. Vui lòng nhập mã hợp lệ.';
      case 'invalid-verification-id':
        return 'ID xác thực không hợp lệ. Vui lòng yêu cầu mã xác thực mới.';
      case 'quota-exceeded':
        return 'Đã vượt quá giới hạn. Vui lòng thử lại sau.';
      default:
        return 'Đã xảy ra lỗi không mong muốn. Vui lòng thử lại.';
    }
  }
}
