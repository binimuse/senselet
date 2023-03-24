// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';


import '../../constants/const.dart';
import '../../theme/custom_sizes.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.description,
    required this.buttonText,
  }) : super(key: key);

  ///
  final String title;
  final IconData icon;
  final String description;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        color: Colors.white.withOpacity(0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: CustomSizes.icon_size_14,
              color: themeColor,
            ),
            SizedBox(
              height: CustomSizes.mp_v_2,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: CustomSizes.mp_v_1,
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey),
            ),
            SizedBox(
              height: CustomSizes.mp_v_2,
            ),
          ],
        ),
      ),
    );
  }
}
