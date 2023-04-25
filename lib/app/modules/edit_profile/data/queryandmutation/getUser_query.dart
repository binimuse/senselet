class GetcredentialsQuery {
  static dynamic getcredentials(String registrationid) {
    return '''
query{
  credentials(where: {id: {_eq: "$registrationid"}}) {
    verified_at
    username
    roles
    phone_number
    is_active
    gender
    first_name
    id
    father_name
    email_verified
    email
    created_at
    birthdate
  }
}

 ''';
  }
}
