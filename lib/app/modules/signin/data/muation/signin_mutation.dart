class SigninQueryMutation {
  static const String signin = r'''
mutation SignIn($username: String!, $password: String!){
 signin(
    username: $username,
    password: $password,
  ) {
    email_verified
    
    tokens
    {
      access_token
      refresh_token
    }
    user_id
    roles
  }
}
 ''';
}
