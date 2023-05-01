class OtpMutation {
  static const String otp = r'''
mutation verifyOTP($code: String!,$email: String!){
 verifyOTP(
    code: $code,
    email: $email,

  ) {
    
user_id
  }
}
 ''';
}

class ResendOtpMutation {
  static const String otp = r'''
mutation verifyOTP($email: String!){
 resendSignUpOtp(
   
    email: $email,

  ) {
    message

  }
}
 ''';
}
