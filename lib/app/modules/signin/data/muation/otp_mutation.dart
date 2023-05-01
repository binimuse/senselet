class OtpMutation {
  static const String otp = r'''
mutation verifyOTP($code: String!,$email: String!){
 verifyOTP(
    code: $code,
    email: $email,

  ) {
    message

  }
}
 ''';
}
