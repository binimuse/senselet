class SigninQueryMutation {
  static const String signin = r'''
mutation SignIn($email: String!, $password: String!){
 login(
    email: $email,
    password: $password,
  ) {
    
    authorization {
      token
    }
    user {
      id
      email
      
      avatar
    }
  }
}
 ''';
}
