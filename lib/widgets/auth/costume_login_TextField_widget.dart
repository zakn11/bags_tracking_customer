import 'package:flutter/material.dart';
import 'package:tracking_system_app/style/app_var.dart';
import 'package:tracking_system_app/style/values_manager.dart';

class CustomeLoginTextFormField extends StatefulWidget {
  const CustomeLoginTextFormField({
    super.key,
    required this.hintText,
    required this.inputType,
    required this.title,
    required this.controller,
    required this.validator,
    this.prefixIcon,
    this.isFilledTextFild,
    this.filledTextFildData,
  });

  final String hintText;
  final String title;
  final TextInputType inputType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final bool? isFilledTextFild;
  final String? filledTextFildData;

  @override
  State<CustomeLoginTextFormField> createState() =>
      _CustomeLoginTextFormFieldState();
}

class _CustomeLoginTextFormFieldState extends State<CustomeLoginTextFormField> {
  bool _isPasswordVisible = false;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    if (widget.isFilledTextFild != null) {
      widget.controller.text = "${widget.filledTextFildData}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final textFieldFontSize = AppSizeSp.s16;
    final contentPaddingVertical = AppSizeH.s12;

    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      keyboardType: widget.inputType,
      obscureText:
          widget.title == "Password" && !_isPasswordVisible ? true : false,
      cursorColor: AppVar.secondary,
      style: TextStyle(
        // color: AppVar.seconndTextColor,
        fontSize: textFieldFontSize,
      ),
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.title == "Password"
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                child: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: AppVar.primarySoft,
                  size: textFieldFontSize,
                ),
              )
            : null,
        fillColor: _isFocused ? Colors.transparent : Colors.transparent,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
            color: const Color.fromARGB(197, 255, 255, 255),
            fontSize: textFieldFontSize * 0.9),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppVar.secondarySoft, width: 2.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppVar.secondary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizeR.s10),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizeR.s10),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
        ),
        errorStyle: const TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: contentPaddingVertical,
          horizontal: AppSizeW.s8,
        ),
      ),
      validator: widget.validator,
    );
  }
}
