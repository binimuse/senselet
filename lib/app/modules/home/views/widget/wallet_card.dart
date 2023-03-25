import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senselet/app/constants/const.dart';
import 'package:senselet/app/modules/home/controllers/home_controller.dart';
import 'package:sizer/sizer.dart';

import 'package:get/get.dart';

import '../../../../theme/custom_sizes.dart';

class WalletCard extends GetView<HomeController> {
  const WalletCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 15.h,
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.circular(CustomSizes.radius_7),
        ),
        child: GestureDetector(
          onTap: (() {
            // controller.gwtwalletammount();
            // controller.update();
          }),
          child: Row(
            children: [
              ///SCHEDULE DATE
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Wallet Balance",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: themeColorgray,
                            ),
                      ),
                      Text(
                        "${23} ETB",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    ],
                  ),
                ),
              ),

              ///MIDDLE DIVIDER
              Column(
                children: [
                  SizedBox(
                    height: CustomSizes.icon_size_6 / 2,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        FontAwesomeIcons.circleHalfStroke,
                        size: CustomSizes.icon_size_6,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: CustomSizes.mp_w_4,
                    ),
                  ),
                  SizedBox(
                    height: CustomSizes.icon_size_6 / 2,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        FontAwesomeIcons.circleHalfStroke,
                        size: CustomSizes.icon_size_6,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              ///BIO TICKET NUMBER
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                        elevation: 2,
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(CustomSizes.radius_4),
                        child: SizedBox()),
                    SizedBox(
                      width: CustomSizes.mp_w_6,
                    ),
                    Material(
                        elevation: 2,
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(CustomSizes.radius_4),
                        child: SizedBox()),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
