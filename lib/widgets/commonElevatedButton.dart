import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereatsresturants/utils/colors.dart';

class CommonElevatedButton extends StatelessWidget {
  const CommonElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
  });
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: blue,
          minimumSize: Size(
            90.w,
            6.h,
          ),
        ),
        child: child);
  }
}
