/// Custom exception class to handle various Firebase-related errors.
class TFirebaseException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code.
  TFirebaseException(this.code);

  /// Get the corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'unknown':
        return 'Đã xảy ra lỗi Firebase không xác định. Vui lòng thử lại.';
      case 'invalid-custom-token':
        return 'Định dạng token tùy chỉnh không chính xác. Vui lòng kiểm tra token.';
      case 'custom-token-mismatch':
        return 'Token tùy chỉnh không khớp với đối tượng sử dụng.';
      case 'user-disabled':
        return 'Tài khoản người dùng đã bị vô hiệu hóa.';
      case 'user-not-found':
        return 'Không tìm thấy người dùng với email hoặc UID đã cung cấp.';
      case 'invalid-email':
        return 'Địa chỉ email không hợp lệ. Vui lòng nhập email hợp lệ.';
      case 'email-already-in-use':
        return 'Địa chỉ email đã được đăng ký. Vui lòng sử dụng email khác.';
      case 'wrong-password':
        return 'Sai mật khẩu. Vui lòng kiểm tra và thử lại.';
      case 'weak-password':
        return 'Mật khẩu quá yếu. Vui lòng chọn mật khẩu mạnh hơn.';
      case 'provider-already-linked':
        return 'Tài khoản đã được liên kết với một nhà cung cấp khác.';
      case 'operation-not-allowed':
        return 'Thao tác này không được phép. Vui lòng liên hệ hỗ trợ.';
      case 'invalid-credential':
        return 'Thông tin xác thực không hợp lệ hoặc đã hết hạn.';
      case 'invalid-verification-code':
        return 'Mã xác thực không hợp lệ. Vui lòng nhập mã hợp lệ.';
      case 'invalid-verification-id':
        return 'ID xác thực không hợp lệ. Vui lòng yêu cầu mã xác thực mới.';
      case 'captcha-check-failed':
        return 'Xác thực reCAPTCHA không hợp lệ. Vui lòng thử lại.';
      case 'app-not-authorized':
        return 'Ứng dụng không được phép sử dụng Firebase Authentication với API key này.';
      case 'keychain-error':
        return 'Đã xảy ra lỗi keychain. Vui lòng kiểm tra và thử lại.';
      case 'internal-error':
        return 'Đã xảy ra lỗi xác thực nội bộ. Vui lòng thử lại sau.';
      case 'invalid-app-credential':
        return 'Thông tin xác thực ứng dụng không hợp lệ. Vui lòng kiểm tra lại.';
      case 'user-mismatch':
        return 'Thông tin xác thực không khớp với người dùng đã đăng nhập trước đó.';
      case 'requires-recent-login':
        return 'Thao tác này yêu cầu xác thực gần đây. Vui lòng đăng nhập lại.';
      case 'quota-exceeded':
        return 'Đã vượt quá giới hạn. Vui lòng thử lại sau.';
      case 'account-exists-with-different-credential':
        return 'Đã tồn tại tài khoản với cùng email nhưng khác phương thức đăng nhập.';
      case 'missing-iframe-start':
        return 'Thiếu thẻ iframe bắt đầu trong mẫu email.';
      case 'missing-iframe-end':
        return 'Thiếu thẻ iframe kết thúc trong mẫu email.';
      case 'missing-iframe-src':
        return 'Thiếu thuộc tính src của iframe trong mẫu email.';
      case 'auth-domain-config-required':
        return 'Cần cấu hình authDomain cho liên kết xác thực mã thao tác.';
      case 'missing-app-credential':
        return 'Thiếu thông tin xác thực ứng dụng. Vui lòng cung cấp thông tin hợp lệ.';
      case 'session-cookie-expired':
        return 'Phiên đăng nhập Firebase đã hết hạn. Vui lòng đăng nhập lại.';
      case 'uid-already-exists':
        return 'ID người dùng đã được sử dụng bởi người dùng khác.';
      case 'web-storage-unsupported':
        return 'Web storage không được hỗ trợ hoặc đã bị vô hiệu hóa.';
      case 'app-deleted':
        return 'Phiên bản FirebaseApp này đã bị xóa.';
      case 'user-token-mismatch':
        return 'Mã thông báo người dùng không khớp với ID người dùng đã xác thực.';
      case 'invalid-message-payload':
        return 'Nội dung tin nhắn xác thực email không hợp lệ.';
      case 'invalid-sender':
        return 'Địa chỉ email người gửi không hợp lệ. Vui lòng kiểm tra lại.';
      case 'invalid-recipient-email':
        return 'Địa chỉ email người nhận không hợp lệ. Vui lòng kiểm tra lại.';
      case 'missing-action-code':
        return 'Thiếu mã thao tác. Vui lòng cung cấp mã hợp lệ.';
      case 'user-token-expired':
        return 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Thông tin đăng nhập không hợp lệ.';
      case 'expired-action-code':
        return 'Mã thao tác đã hết hạn. Vui lòng yêu cầu mã mới.';
      case 'invalid-action-code':
        return 'Mã thao tác không hợp lệ. Vui lòng kiểm tra và thử lại.';
      case 'credential-already-in-use':
        return 'Thông tin đăng nhập này đã được liên kết với một tài khoản khác.';
      default:
        return 'Đã xảy ra lỗi Firebase không mong muốn. Vui lòng thử lại.';
    }
  }
}
