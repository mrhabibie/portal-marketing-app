import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../theme/theme.dart';
import 'dropdown_validator.dart';

class CustomDropdownInput extends StatefulWidget {
  const CustomDropdownInput({
    super.key,
    this.validator,
    required this.items,
    required this.onChanged,
    this.onTap,
    this.inputStyle,
    this.hintStyle,
    this.isReadOnly = false,
    this.hideCaption = false,
    this.hint = '',
    this.label = '',
    this.isRequired = false,
    this.isNeedClear = true,
    this.isNeedSearch = false,
    this.isExpanded = false,
    this.filledColor = false,
    this.title = '',
  });

  final DropdownValidator? validator;
  final Iterable<DropdownMenuItem<dynamic>> items;
  final Function(Object? value) onChanged;
  final Function? onTap;
  final TextStyle? inputStyle;
  final TextStyle? hintStyle;
  final bool isReadOnly;
  final bool isNeedClear;
  final bool isNeedSearch;
  final bool isRequired;
  final bool isExpanded;
  final bool hideCaption;
  final bool filledColor;
  final String hint;
  final String label;
  final String title;

  @override
  State<CustomDropdownInput> createState() => _CustomTextInput();
}

class _CustomTextInput extends State<CustomDropdownInput> {
  bool isFilled = false;
  final FocusNode _focusNode = FocusNode();
  DropdownValidator? validator;

  @override
  void initState() {
    validator = widget.validator ?? DropdownValidator();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          isFilled = true;
        });
      } else {
        setState(() {
          isFilled = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: validator?.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          !widget.hideCaption
              ? Row(
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: TextStyles.tinyTightRegular
                          .copyWith(color: Pallet.neutral600),
                    ),
                    Text(
                      widget.isRequired ? " *" : "",
                      style: TextStyles.tinyTightRegular
                          .copyWith(color: Pallet.danger700),
                    ),
                  ],
                )
              : const SizedBox(),
          DropdownButtonFormField<dynamic>(
            items: widget.items.toList(),
            focusNode: _focusNode,
            validator: validator?.errorMessage,
            value: validator?.value,
            icon: const Icon(Iconsax.arrow_down_1),
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            onChanged: (value) {
              widget.onChanged(value);
              setState(() {
                if (value != null) {
                  isFilled = true;
                } else {
                  isFilled = false;
                }
              });
            },
            decoration: InputDecoration(
              filled: widget.filledColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Pallet.neutral400,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Pallet.neutral400,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color:
                      widget.filledColor ? Pallet.neutral400 : Pallet.info700,
                  width: 1,
                ),
              ),
              labelText: widget.label,
              labelStyle: widget.hintStyle ??
                  TextStyles.regularNormalRegular
                      .copyWith(color: Pallet.neutral500),
              floatingLabelBehavior: widget.hideCaption
                  ? FloatingLabelBehavior.never
                  : FloatingLabelBehavior.always,
              hintText: widget.hint,
              hintStyle: widget.hintStyle ??
                  TextStyles.regularNormalRegular
                      .copyWith(color: Pallet.neutral500),
            ),
            style: widget.inputStyle ?? TextStyles.regularNormalRegular,
          ),
        ],
      ),
    );
  }
}
