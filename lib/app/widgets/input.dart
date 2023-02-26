import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fields/app/utils/theme.dart';

class FieldsInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? initialValue;
  final void Function(String)? onChanged;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool justNumbers;

  const FieldsInput({
    Key? key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.maxLength,
    this.keyboardType,
    this.initialValue,
    this.justNumbers = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 0.0,
      ),
    );

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: AppColors.gray,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 22.0,
        ),
        border: border,
        focusedBorder: border,
        disabledBorder: border,
        enabledBorder: border,
        errorBorder: border,
        focusedErrorBorder: border,
        hintStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      ),
      inputFormatters: [
        if (justNumbers) ...[
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        LengthLimitingTextInputFormatter(maxLength),
      ],
      onChanged: onChanged,
    );
  }
}
