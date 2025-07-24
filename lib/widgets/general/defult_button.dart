import 'package:flutter/material.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class DefultButton extends StatelessWidget {
  const DefultButton({
    super.key,
    required this.buttonColor,
    required this.borderColor,
    @required this.textColor,
    required this.title,
    required this.onPressed,
    this.icon,
  });

  final Color buttonColor;
  final Color? textColor;
  final Color borderColor;
  final String title;
  final dynamic icon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppSizeR.s45),
            side: BorderSide(color: borderColor, width: AppSizeW.s2)),
        fixedSize: Size(MediaQuery.of(context).size.width * 0.9, AppSizeH.s50),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ?? const Text(''),
          Text(
            title,
            style: TextStyle(
                color: textColor ??
                    (Theme.of(context).brightness == Brightness.dark
                        ? AppVar.seconndTextColor
                        : AppVar.textColor),
                fontSize: AppVar.littelFontSize),
          ),
        ],
      ),
    );
  }
}
