class OtpMutation {
  static const String otp = r'''
mutation verifyEmail($code: String!){
 verifyEmail(
    code: $code,

  ) {
    token {
      access_token
      refresh_token
    }
    user_id
  }
}
 ''';
}
