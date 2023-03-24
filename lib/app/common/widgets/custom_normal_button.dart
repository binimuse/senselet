// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

import '../../theme/custom_sizes.dart';

class CustomNormalButton extends StatelessWidget {
  const CustomNormalButton({
    Key? key,
    required this.text,
    required this.padding,
    this.rightIcon,
    this.leftIcon,
    required this.onPressed,
    this.textStyle,
    this.bgColor,
  }) : super(key: key);

  ///ADDITIONAL INFO
  final String text;
  final EdgeInsets padding;
  final VoidCallback onPressed;
  final Widget? rightIcon;
  final Widget? leftIcon;
  final Color? bgColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
        ),
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leftIcon != null
                  ? Padding(
                      padding: EdgeInsets.only(right: CustomSizes.mp_w_4 * 0.8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: leftIcon!,
                      ),
                    )
                  : const SizedBox(),
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              rightIcon != null
                  ? Padding(
                      padding: EdgeInsets.only(left: CustomSizes.mp_w_4 * 0.8),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: rightIcon!,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
