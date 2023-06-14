// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:senselet/app/constants/const.dart';

import 'package:sizer/sizer.dart';

import '../../theme/custom_sizes.dart';
import 'custom_normal_button.dart';

class WarningDialog extends StatelessWidget {
  const WarningDialog(
      {Key? key,
      required this.title,
      required this.description,
      required this.onLeftButtonTap,
      required this.onRightButtonTap,
      required this.leftButtonText,
      required this.rightButtonText})
      : super(key: key);

  ///ADDITIONAL PARAMETERS
  final String title;
  final String description;
  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback onLeftButtonTap;
  final VoidCallback onRightButtonTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Wrap(
          children: [
            Container(
              width: 85.w,
              padding: EdgeInsets.symmetric(
                horizontal: CustomSizes.mp_w_4,
                vertical: CustomSizes.mp_v_2,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  CustomSizes.radius_6,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: CustomSizes.mp_v_1,
                  ),

                  ///HEADER TEXTS
                  buildDialogHeader(context),

                  SizedBox(
                    height: CustomSizes.mp_v_4,
                  ),

                  ///DIALOG CONFORMATION BUTTONS
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: CustomSizes.mp_w_2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///LEFT NEGATIVE BUTTON
                        buildLeftButton(context),

                        ///RIGHT POSITIVE BUTTON
                        buildRightButton(context),
                      ],
                    ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: CustomSizes.mp_v_2,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: CustomSizes.font_10,
                color: Colors.grey,
              ),
        ),
      ],
    );
  }

  buildLeftButton(context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: onLeftButtonTap,
        child: Text(
          leftButtonText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: themeColor,
              ),
        ),
      ),
    );
  }

  buildRightButton(context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: CustomNormalButton(
        textcolor: Colors.white,
        text: rightButtonText,
        buttoncolor: themeColor,
        padding: EdgeInsets.symmetric(
          vertical: CustomSizes.mp_v_1,
          horizontal: CustomSizes.mp_w_4,
        ),
        onPressed: onRightButtonTap,
      ),
    );
  }
}
