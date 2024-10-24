import 'package:flutter/material.dart';

class TextValidator {
  TextEditingController? controller;
  final key = GlobalKey<FormState>();
  final String? title;
  FormFieldValidator<String>? errorMessage;
  final String? hintText;
  final bool isReadOnly;
  final bool isRequired;
  final bool autoOpenKeyboard;
  TextInputType? inputType;
  TextInputAction? inputAction;
  dynamic value;

  TextValidator({
    this.controller,
    this.title,
    this.errorMessage,
    this.hintText,
    this.isReadOnly = false,
    this.isRequired = false,
    this.autoOpenKeyboard = false,
    this.inputType,
    this.inputAction,
    this.value,
  }) {
    controller ??= TextEditingController();
    inputType ??= TextInputType.text;
  }

  bool get isValid => key.currentState?.validate() ?? true;

  TextValidator copyWith({
    TextEditingController? controller,
    String? title,
    FormFieldValidator<String>? errorMessage,
    String? hintText,
    bool? isReadOnly,
    bool? isRequired,
    TextInputType? inputType,
    TextInputAction? inputAction,
  }) {
    return TextValidator(
      controller: controller ?? this.controller,
      title: title ?? this.title,
      errorMessage: errorMessage ?? this.errorMessage,
      hintText: hintText ?? this.hintText,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      isRequired: isRequired ?? this.isRequired,
      inputType: inputType ?? this.inputType,
      inputAction: inputAction ?? this.inputAction,
    );
  }
}
