// ignore_for_file: file_names

class UpdateProfileQueryMutation {
  static const String updateusers = r''' 
    mutation update_credentials($id: uuid!, $birthdate: date!, $email: String!, $father_name: String!, $first_name: String!, $phone_number: String!, $gender: String,){
      update_credentials(where: {id: {_eq: $id}}, _set: {
        birthdate: $birthdate, 
        email: $email, 
        father_name: $father_name, 
        first_name: $first_name, 
        phone_number: $phone_number, 
        gender:  $gender
        }) {
      returning {
      id
    }
    }
    }
    ''';
}
