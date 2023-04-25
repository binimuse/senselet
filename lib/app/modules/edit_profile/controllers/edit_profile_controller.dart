// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../Services/graphql_conf.dart';
import '../../../common/graphql_common_api.dart';
import '../../../common/widgets/custom_snack_bars.dart';
import '../../../utils/constants.dart';
import '../../../utils/pages_util.dart';
import '../../../utils/sahred_prefrence.dart';

import '../data/model/usermodel.dart';
import '../data/queryandmutation/getUser_query.dart';
import '../data/queryandmutation/updateuser_mutation.dart';

class EditProfileController extends GetxController {
  final GlobalKey<FormState> editprofilekey2 = GlobalKey<FormState>();
//getuser
  var startloadingUser = false.obs;
  var hasuserFeched = false.obs;

  //updateuser
  var startupdaeingUser = false.obs;
  var hasuserupdated = false.obs;
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  List<String> gender = ['male', 'female'];
  var selectedGender = "".obs;
  late TextEditingController first_name, last_name, phonenumber, email, dob;
  String? validateName(String value) {
    if (value.isEmpty) {
      return "Please provide fullname";
    }
    return null;
  }

  String? validatephone(String value) {
    if (!PagesUtil.isPhoneValidEthiopian(value)) {
      return "Please Provide valid Phone Number!";
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    first_name = TextEditingController();
    last_name = TextEditingController();
    phonenumber = TextEditingController();
    email = TextEditingController();
    dob = TextEditingController();
    fetchProfileData();
  }

  @override
  void onClose() {
    super.onClose();
    first_name.dispose();
    last_name.dispose();
    phonenumber.dispose();
    email.dispose();
    dob.dispose();
  }

  GraphQLCommonApi graphQLCommonApi = GraphQLCommonApi();

  RxList<UserModel> getUserModel = List<UserModel>.of([]).obs;

  fetchProfileData() async {
    startloadingUser(true);

    try {
      final result = await graphQLCommonApi.mutation(
          GetcredentialsQuery.getcredentials(
              PreferenceUtils.getString(Constants.userId)),
          {});
      startloadingUser(false);

      if (result!["credentials"]!.isNotEmpty) {
        print("34dfe ${result["credentials"]}");
        getUserModel.value = (result["credentials"] as List)
            .map((e) => UserModel.fromJson(e))
            .toList();

        hasuserFeched(true);
//seting data to the current controller
        email.text = getUserModel.first.email;
        phonenumber.text = getUserModel.first.phoneNumber;
        first_name.text = getUserModel.first.firstName;
        last_name.text = getUserModel.first.fatherName;
        selectedGender.value = getUserModel.first.gender;
        dob.text = getUserModel.first.birthdate;
      }
    } on Exception catch (e) {
      print(e);
      hasuserFeched(false);
      startloadingUser(false);
    }
  }

  updateProfile(BuildContext context) async {
    startupdaeingUser(true);

    GraphQLClient _client = graphQLConfiguration.clientToQuery();

    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(UpdateProfileQueryMutation.updateusers),
        variables: <String, dynamic>{
          'id': PreferenceUtils.getString(Constants.userId),
          'first_name': first_name.text,
          'father_name': last_name.text,
          'birthdate': dob.text,
          'email': email.text,
          'phone_number': phonenumber.text,
          'gender': selectedGender.value,
        },
      ),
    );

    if (!result.hasException) {
      hasuserupdated(true);
      startupdaeingUser(false);
      ShowCommonSnackBar.awesomeSnackbarSucess(
          "Success", "Successfully updated", context);

      update();
      // fetchProfileData();
    } else {
      hasuserupdated(false);
      startupdaeingUser(false);
      print(result.exception);
      ShowCommonSnackBar.awesomeSnackbarfailure(
          "Error", "Not updated please try again", context);
    }
  }

  bool checkReg() {
    final isValid = editprofilekey2.currentState!.validate();
    if (!isValid) {
      return false;
    }
    return true;
  }
}
