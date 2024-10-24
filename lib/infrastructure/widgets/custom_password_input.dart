import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../theme/theme.dart';
import 'text_validator.dart';

class CustomPasswordInput extends StatefulWidget {
  const CustomPasswordInput({
    super.key,
    this.validator,
    required this.onChanged,
    this.hint = '',
    this.title = '',
    this.isRequired = false,
    this.isNeedForgotPasswordButton = false,
    this.hideCaption = false,
  });

  final Function(String value) onChanged;
  final bool isNeedForgotPasswordButton;
  final TextValidator? validator;
  final String hint;
  final String title;
  final bool isRequired;
  final bool hideCaption;

  @override
  State<CustomPasswordInput> createState() => _CustomPasswordInputState();
}

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  bool hidePassword = true;
  TextValidator? validator;

  @override
  void initState() {
    validator = widget.validator ?? TextValidator();
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
            controller: validator?.controller,
            obscureText: hidePassword,
            validator: validator?.errorMessage,
            onChanged: (value) {
              validator?.key.currentState?.validate();
              widget.onChanged(value);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, top: 14),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                icon: Icon(
                  hidePassword ? Iconsax.eye4 : Iconsax.eye_slash5,
                  color: Pallet.neutral700,
                ),
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
                  color: Pallet.purple,
                  width: 1,
                ),
              ),
              labelText: validator?.hintText ?? widget.hint,
              labelStyle: TextStyles.regularNormalRegular
                  .copyWith(color: Pallet.neutral500),
              floatingLabelBehavior: widget.hideCaption
                  ? FloatingLabelBehavior.never
                  : FloatingLabelBehavior.always,
              hintText: validator?.hintText,
              hintStyle: TextStyles.regularNormalRegular
                  .copyWith(color: Pallet.neutral500),
            ),
            style: TextStyles.regularNormalRegular,
          ),
          SizedBox(height: AppDimension.height4),
          Row(
            children: <Widget>[
              const Expanded(child: SizedBox()),
              widget.isNeedForgotPasswordButton
                  ? GestureDetector(
                      child: Text(
                        'forgot-password-text'.tr,
                        style: TextStyles.smallNormalRegular
                            .copyWith(color: Pallet.purple),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ],
      ),
    );
  }
}
