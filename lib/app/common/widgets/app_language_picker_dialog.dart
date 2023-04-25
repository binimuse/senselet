import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:senselet/app/constants/const.dart';

import 'package:sizer/sizer.dart';

import '../../theme/custom_sizes.dart';
import '../../utils/constants.dart';
import '../../utils/lang_util.dart';
import '../controller/language_controller.dart';
import 'custom_normal_button.dart';

class AppLanguagePickerDialog extends StatefulWidget {
  const AppLanguagePickerDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AppLanguagePickerDialog> createState() =>
      _AppLanguagePickerDialogState();
}

class _AppLanguagePickerDialogState extends State<AppLanguagePickerDialog> {
  ///

  LanguagehController languagehController = Get.put(LanguagehController());
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Wrap(
          children: [
            Container(
              width: 80.w,
              padding: EdgeInsets.symmetric(
                vertical: CustomSizes.mp_v_1,
                horizontal: CustomSizes.mp_w_2 / 2,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  CustomSizes.radius_6,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: CustomSizes.mp_v_1,
                  ),

                  ///HEADER TEXTS
                  buildDialogHeader(context),

                  SizedBox(
                    height: CustomSizes.mp_v_2,
                  ),

                  const DottedLine(
                    dashColor: Colors.grey,
                  ),

                  SizedBox(
                    height: CustomSizes.mp_v_6,
                  ),

                  ///BUILD LANGUAGE LIST
                  buildLanguageList(context),

                  SizedBox(
                    height: CustomSizes.mp_v_6,
                  ),

                  ///ADD BUTTON
                  buildAddButton(context),

                  SizedBox(
                    height: CustomSizes.mp_v_2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildDialogHeader(context) {
    return Padding(
      padding: EdgeInsets.only(
        left: CustomSizes.mp_w_4,
        right: CustomSizes.mp_w_2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Languages",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              IconButton(
                onPressed: () {
                  ///CLOSE DIALOG
                  Get.back();
                },
                icon: Icon(
                  FontAwesomeIcons.language,
                  size: CustomSizes.icon_size_6,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              right: CustomSizes.mp_w_4,
            ),
            child: Text(
              "Select your preferred language",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: CustomSizes.font_10,
                    color: Colors.grey,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  buildAddButton(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: CustomSizes.mp_w_4,
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: IntrinsicWidth(
          child: CustomNormalButton(
            text: 'Set Language',
            textStyle: const TextStyle(color: Colors.white),
            leftIcon: Icon(
              FontAwesomeIcons.language,
              size: CustomSizes.icon_size_4,
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(
              vertical: CustomSizes.mp_v_2 * 0.9,
              horizontal: CustomSizes.mp_w_4 * 0.7,
            ),
            onPressed: () {
              ///CLOSE DIALOG
              Get.back();
            },
            buttoncolor: themeColor,
            textcolor: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildLanguageList(context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: CustomSizes.mp_w_4),
        child: Row(
          children: [
            Expanded(
              child: CustomNormalButton2(
                leftIcon: const Icon(FontAwesomeIcons.circleDot),
                onPressed: () {
                  ///ON AMHARIC SELECTED
                  LanUtil.saveLanguage(
                    Constants.lanAm,
                  );
                  languagehController.changeLang(Constants.lanAm);

                  ///REBUILD
                  setState(() => {});
                },
                textcolor: Colors.white,
                buttoncolor: LanUtil.getSelecctedLanguage() == Constants.lanAm
                    ? Colors.green
                    : Colors.grey,
                padding: EdgeInsets.symmetric(vertical: CustomSizes.mp_v_2),
                text: "Amharic",
              ),
            ),
            SizedBox(
              width: CustomSizes.mp_w_4,
            ),
            Expanded(
              child: CustomNormalButton2(
                leftIcon: const Icon(FontAwesomeIcons.circleDot),
                onPressed: () {
                  ///ON ENGLISH SELECTED
                  LanUtil.saveLanguage(
                    Constants.lanEn,
                  );
                  languagehController.changeLang(Constants.lanEn);

                  ///REBUILD
                  setState(() => {});
                },
                textcolor: Colors.white,
                buttoncolor: LanUtil.getSelecctedLanguage() == Constants.lanEn
                    ? themeColor
                    : Colors.grey,
                padding: EdgeInsets.symmetric(vertical: CustomSizes.mp_v_2),
                text: "English",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
