// ignore_for_file: depend_on_referenced_packages, constant_identifier_names

import 'package:flutter/services.dart';

class Constants {
  ///APP NATIVE COMMUNICATION CHANNEL NAME
  static const MethodChannel appChannel =
      MethodChannel('com.lmis.jobs/lmis_jobs_channel');

  ///FACE RECOGNITION API
  static const String faceRecognitionApi =
      "https://gateway.lmis.gov.et:9005/face/identify";

  ///FACE RECOGNITION API
  static const String fileBaseUrl = "https://gateway.lmis.gov.et:9001";
  static const String imageBaseURL = "https://storage-download.lmis.gov.et/";

  ///HIVE KEYS
  static const String loggedInUserKey = 'LOGGED_IN_USER';
  static const String stagingURl =
      'https://staging-gateway.lmis.gov.et/v1/graphql';
  static const String produactionURl = 'https://gateway.lmis.gov.et/v1/graphql';
  //static const String userAccessTokenKey = 'USER_ACCESS_TOKEN';
  static const String userAccessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const int laborsPageSize = 10;

  ///HIVE BOXES
  static const String userBox = 'USER_BOX_KEY';



  ///EncryptionKey
  static const String encryptionKey = "dezCaKidRO0pk7GQWP7q";


  ///
  static const String selectedLanguage = "SELECTED_LANGUAGE";
  static const String lanAm = "am";
  static const String lanEn = "en";



  static const String REFRESHER_STATE = "REFRESHER_STATE";

  static String languageDataBox = "language_BaseData_Box";

}
