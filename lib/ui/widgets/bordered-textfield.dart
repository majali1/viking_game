import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:viking_game/utilities/constants.dart';

class BorderedTextField extends StatefulWidget {
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String labelText;
  final String hintText;
  final TextEditingController textEditingController;
  final VoidCallback? onSubmitted;
  final String? customError;
  final bool showCustomError;
  final bool isRequired;
  final String? requiredError;
  final TextInputAction textInputAction;
  final TextInputType textInputType;

  const BorderedTextField({Key? key,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    required this.labelText,
    required this.textEditingController,
    this.onSubmitted,
    this.customError,
    this.requiredError,
    this.isRequired = true,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    required this.showCustomError})
      : super(key: key);

  @override
  State<BorderedTextField> createState() => _BorderedTextFieldState();
}

class _BorderedTextFieldState extends State<BorderedTextField> {
  double height = 56;
  bool hasError = false;

  double getTextFieldHeight() {
    return hasError || widget.showCustomError ? 70 : height;
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) =>
          SizedBox(
            height: getTextFieldHeight(),
            child: TextFormField(
              controller: widget.textEditingController,
              style: TextStyle(
                  fontFamily: FontFamily.BaiJamjureeMedium,
                  fontSize: 16.sp,
                  color: Colors.black),
              decoration: InputDecoration(
                  labelText: widget.labelText,
                  hintText: widget.hintText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide:
                      BorderSide(color: Color(0x1F000000), width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: kPrimaryColor, width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(color: Colors.red, width: 1)),
                  errorMaxLines: 2,
                  errorText: widget.showCustomError == true
                      ? widget.customError
                      : null,
                  prefixIcon: widget.prefixIcon != null
                      ? Icon(
                    widget.prefixIcon,
                    color: kPrimaryColor,
                    size: 19.sp,
                  )
                      : null,
                  suffixIcon: widget.suffixIcon != null
                      ? Icon(
                    widget.suffixIcon,
                    color: kPrimaryColor,
                    size: 19.sp,
                  )
                      : null),
              textInputAction: widget.textInputAction,
              keyboardType: widget.textInputType,
              validator: (value) {
                if (value!.isEmpty && widget.isRequired) {
                  return widget.requiredError;
                }

                return null;
              },
            ),
          )),
    );
  }
}
