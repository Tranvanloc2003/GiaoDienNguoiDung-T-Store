/// Exception class for handling various errors.
class TExceptions implements Exception {
  /// The associated error message.
  final String message;

  /// Default constructor with a generic error message.
  const TExceptions([this.message = 'Đã xảy ra lỗi không mong muốn. Vui lòng thử lại.']);

  /// Create an authentication exception from a Firebase authentication exception code.
  factory TExceptions.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const TExceptions('Địa chỉ email đã được đăng ký. Vui lòng sử dụng email khác.');
      case 'invalid-email':
        return const TExceptions('Địa chỉ email không hợp lệ. Vui lòng nhập email hợp lệ.');
      case 'weak-password':
        return const TExceptions('Mật khẩu quá yếu. Vui lòng chọn mật khẩu mạnh hơn.');
      case 'user-disabled':
        return const TExceptions('Tài khoản này đã bị vô hiệu hóa. Vui lòng liên hệ hỗ trợ.');
      case 'user-not-found':
        return const TExceptions('Thông tin đăng nhập không hợp lệ. Không tìm thấy người dùng.');
      case 'wrong-password':
        return const TExceptions('Sai mật khẩu. Vui lòng kiểm tra và thử lại.');
      case 'INVALID_LOGIN_CREDENTIALS':
        return const TExceptions('Thông tin đăng nhập không hợp lệ. Vui lòng kiểm tra lại.');
      case 'too-many-requests':
        return const TExceptions('Quá nhiều yêu cầu. Vui lòng thử lại sau.');
      case 'invalid-argument':
        return const TExceptions('Tham số xác thực không hợp lệ.');
      case 'invalid-password':
        return const TExceptions('Sai mật khẩu. Vui lòng thử lại.');
      case 'invalid-phone-number':
        return const TExceptions('Số điện thoại không hợp lệ.');
      case 'operation-not-allowed':
        return const TExceptions('Phương thức đăng nhập này đã bị vô hiệu hóa cho dự án Firebase của bạn.');
      case 'session-cookie-expired':
        return const TExceptions('Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.');
      case 'uid-already-exists':
        return const TExceptions('ID người dùng này đã được sử dụng bởi người dùng khác.');
      case 'sign_in_failed':
        return const TExceptions('Đăng nhập thất bại. Vui lòng thử lại.');
      case 'network-request-failed':
        return const TExceptions('Lỗi kết nối mạng. Vui lòng kiểm tra kết nối internet.');
      case 'internal-error':
        return const TExceptions('Lỗi hệ thống. Vui lòng thử lại sau.');
      case 'invalid-verification-code':
        return const TExceptions('Mã xác thực không hợp lệ. Vui lòng nhập mã hợp lệ.');
      case 'invalid-verification-id':
        return const TExceptions('ID xác thực không hợp lệ. Vui lòng yêu cầu mã xác thực mới.');
      case 'quota-exceeded':
        return const TExceptions('Đã vượt quá giới hạn. Vui lòng thử lại sau.');
      default:
        return const TExceptions();
    }
  }
}
