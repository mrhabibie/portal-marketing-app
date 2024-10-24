import 'package:flutter/material.dart';

class DropdownValidator {
  TextEditingController? controller;
  final key = GlobalKey<FormState>();
  final String? title;
  FormFieldValidator<dynamic>? errorMessage;
  final String? hintText;
  final bool isReadOnly;
  final bool isRequired;
  dynamic value;
  final bool autoOpenKeyboard;
  TextInputType? inputType;

  DropdownValidator(
      {this.controller,
      this.title,
      this.errorMessage,
      this.hintText,
      this.isReadOnly = false,
      this.isRequired = false,
      this.value,
      this.autoOpenKeyboard = false,
      this.inputType}) {
    controller ??= TextEditingController();
    inputType ??= TextInputType.text;
  }

  bool get isValid => key.currentState?.validate() ?? true;

  DropdownValidator copyWith({
    TextEditingController? controller,
    String? title,
    FormFieldValidator<dynamic>? errorMessage,
    String? hintText,
    bool? isReadOnly,
    bool? isRequired,
    dynamic value,
    TextInputType? inputType,
  }) {
    return DropdownValidator(
      controller: controller ?? this.controller,
      title: title ?? this.title,
      errorMessage: errorMessage ?? this.errorMessage,
      hintText: hintText ?? this.hintText,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      isRequired: isRequired ?? this.isRequired,
      value: value ?? this.value,
      inputType: inputType ?? this.inputType,
    );
  }
}
