import 'package:flutter/material.dart';
import 'package:payment_app/component/colors.dart';

class AppLargeButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final Function()? onTap;
  final bool? insBorder;
  final String text;
  const AppLargeButton(
      {Key? key,
      required this.text,
      this.backgroundColor = AppColor.mainColor,
      this.textColor,
      this.onTap,
      this.insBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 30),
        height: 60,
        width: MediaQuery.of(context).size.width - 60,
        decoration: BoxDecoration(
          color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: AppColor.mainColor)),
            child: Center(child: Text(text,style: TextStyle(fontSize: 35, color: textColor, fontWeight: FontWeight.bold),)),
      ),
    );
  }
}
