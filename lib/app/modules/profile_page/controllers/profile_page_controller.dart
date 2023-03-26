// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Services/graphql_conf.dart';
import '../../../common/widgets/custom_snack_bars.dart';
import '../../../constants/reusable/reusable.dart';
import '../../../constants/reusable/shimmer_loading.dart';
import '../data/model/faq_model.dart';
import '../data/muataion/add_feedback_mutattion.dart';
import '../data/muataion/profile_query_mutation.dart';

class ProfilePageController extends GetxController {
  //FOR Contact and privacy policy
  var facebook = "".obs;
  var telegram = "".obs;
  var instagram = "".obs;
  var contact_email = "".obs;
  var contact_phone = "".obs;
  var privacy_policy = "".obs;
  var terms_and_conditions = "".obs;
  var valid_prescription = "".obs;
  var file_upload_token = "".obs;
  var loadfeedbacksubmited = false.obs;
//for about us
  final String version = '0.0.1';
  var editpro = false.obs;
  final reusableWidget = ReusableWidget();
// for setting
  bool isActive = true;

  final List locale = [
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Amharic/አማርኛ', 'locale': const Locale('am', 'IN')},
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

//for profile edit

  final GlobalKey<FormState> editprofilekey2 = GlobalKey<FormState>();

  late TextEditingController first_name, last_name, phonenumber, email, dob;

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  List<String> gender = ['Male', 'Female'];
  var selectedGender = "Male".obs;
  var loadinguser = false.obs;
  var loadingcms = false.obs;
  var loadingfaq = false.obs;
  var loadingappdata = false.obs;
  var updatepro = false.obs;
  var loadrfeedbacksubmited = false.obs;
  var shimmerLoading = ShimmerLoading();

  var username = ''.obs;

  var profilepic = ''.obs;

  var genders = "".obs;

  // var appDatas = <AppDataModel>[].obs;
  // var appDatas2 = <AppDataModel2>[].obs;
  // var appDatas3 = <AppDataModel3>[].obs;

  var selectedImagePath = ''.obs;
  var images = <File>[].obs;
  var subscriptionDocument;

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Please provide fullname";
    }
    return null;
  }

  String? validatePhone(String value) {
    if (value.isEmpty) {
      return "Please provide Phonenumber";
    }
    return null;
  }

  void editProfile() {}

  // void getImage(ImageSource imageSource, context) async {
  //   final pickedFile = await ImagePicker().pickImage(source: imageSource);
  //   if (pickedFile != null) {
  //     selectedImagePath.value = pickedFile.path;
  //     images.add(File(selectedImagePath.value));
  //   } else {
  //     ShowCommonSnackBar.awesomeSnackbarfailure(
  //         "Error", 'No Image Selected', context);
  //   }
  // }

  updateProfile(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    updatepro(true);

    GraphQLClient _client = graphQLConfiguration.clientToQuery();

    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(UpdateProfileQueryMutation.updateusers),
        variables: <String, dynamic>{
          'id': int.parse(id!),
          'first_name': first_name.text,
          'last_name': last_name.text,
          'dob': dob.text,
          'email': email.text,
          'phone': phonenumber.text,
          'gender': selectedGender.value,
        },
      ),
    );

    if (!result.hasException) {
      updatepro(false);

      ShowCommonSnackBar.awesomeSnackbarSucess(
          "Success", "Successfully updated", context);

      update();
      // fetchProfileData();
    } else {
      print(result.exception);
      updatepro(false);
      ShowCommonSnackBar.awesomeSnackbarfailure(
          "Error", "Not updated please try again", context);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
    fetchProfilSubscription();
    fetchcmsdatabypk();
    fetchFaq();
    first_name = TextEditingController();
    last_name = TextEditingController();
    phonenumber = TextEditingController();
    email = TextEditingController();
    dob = TextEditingController();
    feedback = TextEditingController();
  }

  //for   "Feedback",
  late TextEditingController feedback;
  void addFeedback(BuildContext context) async {
    loadrfeedbacksubmited(true);
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');

    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.mutate(
      MutationOptions(
        document: gql(AddfeedbackMutation.addfeedback),
        variables: <String, dynamic>{
          'user_id': id,
          'feedback': feedback.text,
        },
      ),
    );
    if (!result.hasException) {
      ShowCommonSnackBar.awesomeSnackbarSucess(
          "Success", "Feedback sent ", context);
      feedback.clear();
      loadrfeedbacksubmited(false);
    } else {
      print(result.exception);
      loadrfeedbacksubmited(false);
      ShowCommonSnackBar.awesomeSnackbarfailure(
          "Error", "failed, try again ", context);
    }

    // print(result.exception);
  }

//For    "Frequently asked question",
  RxList<FaqModel> faqModel = List<FaqModel>.of([]).obs;
  fetchFaq() async {
    GetFaqData getFaqData = GetFaqData();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getFaqData.getFaqData()),
      ),
    );

    if (!result.hasException) {
      faqModel.clear();
      loadingfaq(true);
      for (var i = 0; i < result.data!["faq"].length; i++) {
        faqModel.add(FaqModel(
            question: result.data!["faq"][i]["question"],
            id: result.data!["faq"][i]["id"],
            answer: result.data!["faq"][i]["answer"]));
      }
    } else {
      print(result.exception);

      loadingfaq(false);
    }
  }

  fetchcmsdatabypk() async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    GraphQLClient _client = graphQLConfiguration.clientToQuery();

    if (id != null) {
      QueryResult result = await _client.query(
        QueryOptions(
          document: gql(getcmsData.getcmsdatabypk(int.parse(id))),
        ),
      );

      if (!result.hasException) {
        loadingcms(true);
        print(result.data);
        facebook.value = result.data!["cms_data_by_pk"]["data"]["facebook"];
        telegram.value = result.data!["cms_data_by_pk"]["data"]["telegram"];
        instagram.value = result.data!["cms_data_by_pk"]["data"]["instagram"];
        contact_email.value =
            result.data!["cms_data_by_pk"]["data"]["contact_email"];
        contact_phone.value =
            result.data!["cms_data_by_pk"]["data"]["contact_phone"];
        privacy_policy.value =
            result.data!["cms_data_by_pk"]["data"]["privacy_policy"];

        terms_and_conditions.value =
            result.data!["cms_data_by_pk"]["data"]["terms_and_conditions"];
        valid_prescription.value =
            result.data!["cms_data_by_pk"]["data"]["valid_prescription"];
        file_upload_token.value =
            result.data!["cms_data_by_pk"]["data"]["file_upload_token"];

        print("valid  ${valid_prescription.value}");
      } else {
        print("object");
        print(result.exception);

        loadingcms(false);
      }
    }
  }

  GetuserProfile getuserProfile = GetuserProfile();
  void fetchProfilSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    loadinguser(true);
    if (id != null) {
      subscriptionDocument = gql(getuserProfile.getuserSub(int.parse(id)));
    }
  }

  GetcmsData getcmsData = GetcmsData();
  fetchProfileData() async {
    GraphQLClient _client = graphQLConfiguration.clientToQuery();

    QueryResult result = await _client.query(
      QueryOptions(
        document: gql(getuserProfile.getuser()),
      ),
    );

    if (!result.hasException) {
      loadinguser(true);

      email.text = result.data!["auth"]["email"];
      profilepic.value = result.data!["auth"]["avatar"];
      phonenumber.text = result.data!["auth"]["phone"];
      first_name.text = result.data!["auth"]["first_name"];
      last_name.text = result.data!["auth"]["last_name"];
      selectedGender.value = result.data!["auth"]["gender"];
      dob.text = result.data!["auth"]["dob"];
    } else {
      print("object");
      print(result.exception);

      loadinguser(false);
    }
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
}
