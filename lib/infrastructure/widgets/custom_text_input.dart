import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../theme/theme.dart';
import 'text_validator.dart';

class CustomTextInput extends StatefulWidget {
  const CustomTextInput({
    super.key,
    this.validator,
    required this.onChanged,
    this.onTap,
    this.onSearchTap,
    this.onFieldSubmitted,
    this.inputStyle,
    this.hintStyle,
    this.isReadOnly = false,
    this.hideCaption = false,
    this.hint = '',
    this.isRequired = false,
    this.isNeedClear = true,
    this.isNeedSearch = false,
    this.isNeedDropdown = false,
    this.isExpanded = false,
    this.filledColor = false,
    this.title = '',
  });

  final TextValidator? validator;
  final Function(String value) onChanged;
  final Function? onTap;
  final void Function()? onSearchTap;
  final void Function(String value)? onFieldSubmitted;
  final TextStyle? inputStyle;
  final TextStyle? hintStyle;
  final bool isReadOnly;
  final bool isNeedClear;
  final bool isNeedSearch;
  final bool isNeedDropdown;
  final bool isRequired;
  final bool isExpanded;
  final bool hideCaption;
  final bool filledColor;
  final String hint;
  final String title;

  @override
  State<CustomTextInput> createState() => _CustomTextInput();
}

class _CustomTextInput extends State<CustomTextInput> {
  bool isFilled = false;
  final FocusNode _focusNode = FocusNode();
  TextValidator? validator;

  @override
  void initState() {
    validator = widget.validator ?? TextValidator();
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
          TextFormField(
            readOnly: widget.isReadOnly,
            focusNode: _focusNode,
            controller: validator?.controller,
            validator: validator?.errorMessage,
            keyboardType: widget.isExpanded
                ? TextInputType.multiline
                : validator?.inputType ?? TextInputType.text,
            textInputAction: widget.isExpanded
                ? TextInputAction.newline
                : validator?.inputAction ?? TextInputAction.done,
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            onChanged: (value) {
              widget.onChanged(value);
              setState(() {
                if (value.isNotEmpty) {
                  isFilled = true;
                } else {
                  isFilled = false;
                }
              });
            },
            onFieldSubmitted: widget.onFieldSubmitted,
            decoration: InputDecoration(
              filled: widget.filledColor,
              contentPadding: EdgeInsets.only(
                left: AppDimension.width14,
                top: AppDimension.height14,
              ),
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
                  color: widget.filledColor ? Pallet.neutral400 : Pallet.purple,
                  width: 1,
                ),
              ),
              suffixIcon: widget.isNeedClear
                  ? (isFilled
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              validator?.controller?.clear();
                              isFilled = false;
                              widget.onChanged("");
                            });
                          },
                          icon: const Icon(
                            Iconsax.close_circle5,
                            color: Pallet.neutral700,
                          ),
                        )
                      : (widget.isNeedSearch
                          ? IconButton(
                              onPressed: widget.onSearchTap,
                              icon: const Icon(
                                Iconsax.search_normal_1,
                                color: Pallet.neutral700,
                              ),
                            )
                          : const SizedBox()))
                  : (widget.isNeedSearch
                      ? IconButton(
                          onPressed: widget.onSearchTap,
                          icon: const Icon(
                            Iconsax.search_normal_1,
                            color: Pallet.neutral700,
                          ),
                        )
                      : (widget.isNeedDropdown
                          ? const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Iconsax.arrow_down_1,
                                color: Pallet.neutral700,
                              ),
                            )
                          : const SizedBox())),
              labelText: widget.hint,
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
            maxLines: widget.isExpanded ? 5 : null,
          ),
        ],
      ),
    );
  }
}
