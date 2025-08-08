import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;

  const CustomTextField({
    Key? key,
    required this.hint,
    this.controller,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: const BorderSide(width: 1),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide(
        color: Theme.of(context).textTheme.bodyMedium!.color!,
        width: 1.5,
        style: BorderStyle.solid,
      ),
    );

    return TextFormField(
      controller: controller,
      onSaved: onSaved,
      cursorColor: Theme.of(context).primaryColor,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      validator: (value) =>
          (value == null || value.isEmpty) ? 'لا يمكن أن يكون فارغاً' : null,
      decoration: InputDecoration(
        border: border,
        focusedBorder: focusedBorder,
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        hintText: hint,
        hintStyle: TextStyle(
          color: Theme.of(context).dividerColor,
          fontSize: 14.sp,
        ),
        contentPadding: EdgeInsets.all(16.r),
      ),
    );
  }
}
