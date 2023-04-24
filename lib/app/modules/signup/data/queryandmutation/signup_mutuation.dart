class SignupQueryMutation {
  static const String register = r'''
mutation signup($first_name: String!,$father_name: String!,$roles: String!, $gender: String!,$email: String!, $phone_number: String!,  $birthdate: date!, $password: String!,$password_confirmation: String!){
signup(
    first_name: $first_name, 
    father_name: $father_name, 
    email: $email, 
    password: $password,
    gender: $gender,
    password_confirmation: $password_confirmation,
    phone_number: $phone_number,  
    roles: $roles, 
    birthdate: $birthdate, 
 
  ) {
    exp
    token
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
