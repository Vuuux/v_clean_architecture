/// Error message model
class ErrorMessage {
  const ErrorMessage({required this.title, required this.message});

  final String title;
  final String message;
}

/// Error codes returned from API
class ErrorCodes {
  ErrorCodes._();

  // Authentication & Authorization
  static const String unauthorizedError = 'err_unauthorized';
  static const String unauthorizedToken = 'err_unauthorized_token';
  static const String unauthorized = 'unauthorized';

  // OTP Related
  static const String authBlockResendOtp = 'err_block_resend_otp';
  static const String authInvalidOtp = 'err_invalid_otp';
  static const String authExpiredOtp = 'err_expired_otp';
  static const String authMaxExceededOtp = 'err_exceed_max_attempt';
  static const String authMaxResendOtp = 'err_reach_max_resend_attempt';

  // User Related
  static const String userNidUnique = 'err_national_id_unique';
  static const String usernameExisted = 'err_username_existed';
  static const String userAlreadyExisted = 'err_user_already_existed';
  static const String userEmailAlreadyExisted = 'err_email_already_existed';
  static const String userEmailIsInvalid = 'err_invalid_email';
  static const String usernameAlreadyExisted = 'err_username_already_existed';
  static const String usernamePasswordInvalid =
      'err_incorrect_username_or_password';
  static const String usernameLoginBlocked = 'err_login_locked';
  static const String nidAlreadyExists = 'err_nid_already_exists';
  static const String userPasswordNotMatch = 'err_password_not_match';
  static const String userNotAllowChangePassword =
      'err_user_type_not_allow_change_password';
  static const String userCannotGetUserPassword =
      'err_cannot_get_user_password';

  // Network & Upload
  static const String networkError = 'network_error';
  static const String uploadExceededSizeError = 'err_file_size_exceeded';

  /// Set of error codes that require force logout
  static const Set<String> unauthorizedCodes = {
    unauthorizedError,
    unauthorizedToken,
    unauthorized,
  };
}

/// Map of error codes to error messages
class ErrorMessagesMap {
  ErrorMessagesMap._();

  static const Map<String, ErrorMessage> messages = {
    // Authentication & Authorization
    ErrorCodes.unauthorizedError: ErrorMessage(
      title: 'Session หมดอายุแล้ว!',
      message: 'กรุณาเข้าสู่ระบบใหม่อีกครั้ง',
    ),
    ErrorCodes.unauthorizedToken: ErrorMessage(
      title: 'Session หมดอายุแล้ว!',
      message: 'กรุณาเข้าสู่ระบบใหม่อีกครั้ง',
    ),
    ErrorCodes.unauthorized: ErrorMessage(
      title: 'Session หมดอายุแล้ว!',
      message: 'กรุณาเข้าสู่ระบบใหม่อีกครั้ง',
    ),

    // OTP Related
    ErrorCodes.authBlockResendOtp: ErrorMessage(
      title: 'การส่ง OTP ถูกบล็อค!',
      message: 'ระบบไม่สามารถส่ง OTP ได้ กรุณารอ 5 นาทีและลองใหม่อีกครั้ง',
    ),
    ErrorCodes.authInvalidOtp: ErrorMessage(
      title: 'รหัส OTP ไม่ถูกต้อง!',
      message: 'รหัส OTP ไม่ถูกต้อง กรุณาตรวจสอบอีกครั้ง',
    ),
    ErrorCodes.authExpiredOtp: ErrorMessage(
      title: 'รหัส OTP หมดอายุ!',
      message: 'รหัส OTP หมดอายุแล้ว กรุณาขอรหัสใหม่',
    ),
    ErrorCodes.authMaxExceededOtp: ErrorMessage(
      title: 'เกินจำนวนการขอ OTP!',
      message:
          'คุณได้พยายามใส่รหัส OTP ผิดเกินจำนวนครั้งที่กำหนด กรุณาส่งคำขอ OTP ใหม่อีกครั้ง',
    ),
    ErrorCodes.authMaxResendOtp: ErrorMessage(
      title: 'เกินจำนวนการส่ง OTP!',
      message:
          'คุณได้ทำการขอรหัส OTP เกินจำนวนครั้งที่อนุญาต กรุณาลองใหม่ในภายหลัง',
    ),

    // User Related
    ErrorCodes.userNidUnique: ErrorMessage(
      title: 'เลขบัตรประชาชนซ้ำ!',
      message: 'โอะ..เลขบัตรประชาชนซ้ำ ลองกรอกใหม่น้า',
    ),
    ErrorCodes.usernameExisted: ErrorMessage(
      title: 'ชื่อผู้ใช้ซ้ำ!',
      message: 'ชื่อผู้ใช้นี้ถูกใช้งานแล้ว กรุณาเลือกชื่อใหม่',
    ),
    ErrorCodes.userAlreadyExisted: ErrorMessage(
      title: 'อีเมลซ้ำ!',
      message: 'อีเมลนี้ถูกใช้งานแล้ว กรุณาใช้อีเมลอื่น',
    ),
    ErrorCodes.usernameAlreadyExisted: ErrorMessage(
      title: 'ชื่อผู้ใช้ซ้ำ!',
      message: 'ชื่อผู้ใช้นี้ถูกใช้งานแล้ว กรุณาเลือกชื่อใหม่',
    ),
    ErrorCodes.userEmailAlreadyExisted: ErrorMessage(
      title: 'อีเมลซ้ำ!',
      message: 'อีเมลนี้ถูกใช้งานแล้ว กรุณาใช้อีเมลอื่น',
    ),
    ErrorCodes.userEmailIsInvalid: ErrorMessage(
      title: 'อีเมลซ้ำ!',
      message: 'โอะ.. อีเมลนี้ไม่สามารถใช้ได้ ลองใช้อีเมลอื่นดูน้า',
    ),
    ErrorCodes.usernamePasswordInvalid: ErrorMessage(
      title: 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง!',
      message: 'อีเมล/ชื่อผู้ใช้ หรือรหัสผ่าน ไม่ถูกต้อง',
    ),
    ErrorCodes.usernameLoginBlocked: ErrorMessage(
      title: 'บัญชีถูกล็อก!',
      message:
          'บัญชีของคุณถูกล็อค เนื่องจากลงชื่อเข้าใช้งานไม่ถูกต้อง 5 ครั้ง กรุณาติดต่อผู้ดูแลระบบทางอีเมล info@pohpunpanyafoundation.org',
    ),
    ErrorCodes.nidAlreadyExists: ErrorMessage(
      title: 'เลขบัตรประชาชนซ้ำ!',
      message: 'เลขบัตรประชาชนนี้ถูกใช้งานแล้ว',
    ),
    ErrorCodes.userPasswordNotMatch: ErrorMessage(
      title: 'รหัสผ่านไม่ตรงกัน!',
      message: 'รหัสผ่านเดิมไม่ถูกต้อง กรุณาตรวจสอบอีกครั้ง',
    ),
    ErrorCodes.userNotAllowChangePassword: ErrorMessage(
      title: 'ไม่สามารถเปลี่ยนรหัสผ่านได้!',
      message: 'บัญชีของคุณไม่มีสิทธิ์ในการรีเซ็ตรหัสผ่าน',
    ),
    ErrorCodes.userCannotGetUserPassword: ErrorMessage(
      title: 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง!',
      message: 'อีเมล/ชื่อผู้ใช้ หรือรหัสผ่าน ไม่ถูกต้อง',
    ),

    // Network & Upload
    ErrorCodes.networkError: ErrorMessage(
      title: 'ปัญหาการเชื่อมต่อ!',
      message: 'กรุณาตรวจสอบการเชื่อมต่อเครือข่ายของคุณ',
    ),
    ErrorCodes.uploadExceededSizeError: ErrorMessage(
      title: 'ไฟล์มีขนาดเกินที่กำหนด!',
      message: 'เกินขนาดที่กำหนดไว้สำหรับการอัปโหลด ขนาดที่อนุญาตคือ 5MB',
    ),
  };

  // Default error messages based on request type
  static const ErrorMessage defaultError = ErrorMessage(
    title: 'เกิดข้อผิดพลาด!',
    message: 'กรุณาลองใหม่อีกครั้ง',
  );

  static const ErrorMessage defaultUploadError = ErrorMessage(
    title: 'เกิดข้อผิดพลาด!',
    message: 'ไม่สามารถอัปโหลดได้ กรุณาลองอีกครั้ง',
  );

  static const ErrorMessage defaultGetError = ErrorMessage(
    title: 'เกิดข้อผิดพลาด!',
    message: 'ไม่สามารถแสดงข้อมูลได้ กรุณาลองอีกครั้ง',
  );

  static const ErrorMessage defaultPostError = ErrorMessage(
    title: 'เกิดข้อผิดพลาด!',
    message: 'ไม่สามารถทำรายการได้ในตอนนี้ รอสักพักแล้วกลับมาลองใหม่อีกครั้งนะ',
  );

  /// Get error message by code
  static ErrorMessage getErrorMessage(String? code) {
    if (code == null) return defaultError;
    return messages[code] ?? defaultError;
  }

  /// Get default error message based on request type
  static ErrorMessage getDefaultErrorByRequestType({
    String? method,
    bool isUpload = false,
  }) {
    if (isUpload) return defaultUploadError;

    switch (method?.toUpperCase()) {
      case 'GET':
        return defaultGetError;
      case 'POST':
        return defaultPostError;
      default:
        return defaultError;
    }
  }
}
