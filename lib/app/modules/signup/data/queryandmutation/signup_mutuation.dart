class SignupQueryMutation {
  static const String register = r'''
mutation SignUp($first_name: String!,$last_name: String!, $email: String!, $phone: String!, $gender: String!,  $dob: String!, $password: String!){
 action: register(
    first_name: $first_name, 
    last_name: $last_name, 
    email: $email, 
    password: $password,
    phone: $phone, 
    gender: $gender, 
    dob: $dob, 
 
  ) {
    status
    authorization {
      token
      
    }
  }
}
 ''';
}
