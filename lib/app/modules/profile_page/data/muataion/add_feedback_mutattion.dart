class AddfeedbackMutation {
  static const String addfeedback = r'''
    mutation  insert_public_feedback( $user_id:Int!,  $feedback: String! ){
      action: insert_public_feedback(objects: { 
        feedback: $feedback, 
      user_id: $user_id 
 
   
       
       
        }){
        returning {
      id
    }
      }
    }
 ''';
}
