import 'package:flutter/material.dart';
import 'package:viking_game/utilities/constants.dart';

class BorderedDropdown extends StatefulWidget {
  final List<DropdownMenuItem> list;
  final String hint;
  final Function onChanged;
  final bool isRequired;
  final double width;
  dynamic selectedValue;

  BorderedDropdown(
      {Key? key,
      required this.list,
      required this.hint,
      this.selectedValue,
      required this.width,
      this.isRequired = false,
      required this.onChanged})
      : super(key: key);

  @override
  State<BorderedDropdown> createState() => _BorderedDropdownState();
}

class _BorderedDropdownState extends State<BorderedDropdown> {
  FocusNode dropdownFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: inputFieldHeight,
      child: DropdownButtonFormField<dynamic>(
        decoration: InputDecoration(
            label: Text(
              widget.hint,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: FontFamily.BaiJamjureeMedium,
                  fontSize: 16),
            ),
            contentPadding: EdgeInsetsDirectional.only(start: 20, end: 20),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                    color: dropDownBorderColor, width: inputBorderWidth))),
        items: widget.list,
        hint: Text(
          widget.hint,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: FontFamily.BaiJamjureeMedium,
              fontSize: 16),
        ),
        onChanged: (val) {
          // setState(() {
            widget.selectedValue = val;
          // });
          widget.onChanged(val);
        },
        value: widget.selectedValue,
      ),
    );
  }
}
