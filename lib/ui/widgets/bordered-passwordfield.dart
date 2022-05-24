import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:viking_game/utilities/constants.dart';
import 'package:viking_game/utilities/helpers.dart';

class BorderedPasswordField extends StatefulWidget {
  final IconData? prefixIcon;
  final String labelText;
  final String hintText;
  final TextEditingController textEditingController;
  final VoidCallback? onSubmitted;
  final bool showText;
  final String? customError;

  final String? requiredError;
  final Function? matchValFunc;
  final bool isRequired;
  final Function toggleText;
  final bool? checkLength;
  final String? requiredErrorMessage;
  final TextInputAction textInputAction;

  const BorderedPasswordField({Key? key,
    this.prefixIcon,
    required this.hintText,
    required this.labelText,
    required this.textEditingController,
    required this.toggleText,
    this.onSubmitted,
    this.showText = false,
    this.customError,
    this.requiredError,
    this.requiredErrorMessage,
    this.matchValFunc,
    this.isRequired = false,
    this.textInputAction = TextInputAction.done,
    this.checkLength})
      : super(key: key);

  @override
  State<BorderedPasswordField> createState() => _BorderedPasswordFieldState();
}

class _BorderedPasswordFieldState extends State<BorderedPasswordField> {
  double height = 56;
  bool hasError = false;

  double getTextFieldHeight() {
    return hasError ? 70 : height;
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) =>
          SizedBox(
            height: getTextFieldHeight(),
            child: TextFormField(
              controller: widget.textEditingController,
              obscureText: !widget.showText,
              textInputAction: widget.textInputAction,
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
                prefixIcon: widget.prefixIcon != null
                    ? Icon(
                  widget.prefixIcon,
                  color: kPrimaryColor,
                  size: 19.sp,
                )
                    : null,
                suffixIcon: IconButton(
                  icon: Icon(
                    widget.showText
                        ? Icons.visibility_off
                        : Icons.remove_red_eye,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                  onPressed: () => widget.toggleText(),
                ),
              ),
              onFieldSubmitted: (val) {
                if (widget.onSubmitted != null) widget.onSubmitted!();
              },
              validator: (value) {
                if (value!.isEmpty && widget.isRequired) {
                  setState(() {
                    hasError = true;
                  });
                  return widget.requiredErrorMessage;
                }
                if (widget.matchValFunc != null &&
                    !widget.matchValFunc!(value)) {
                  setState(() {
                    hasError = true;
                  });
                  return "The Passwords Don't Match";
                }
                if (widget.matchValFunc == null &&
                    widget.checkLength == true &&
                    !validatePasswordRegex(value)) {
                  setState(() {
                    hasError = true;
                  });
                  return "Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character";
                }

                setState(() {
                  hasError = false;
                });

                return null;
              },
            ),
          )),);
  }
}
