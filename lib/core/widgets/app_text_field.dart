import 'package:flutter/material.dart';
import 'package:veylo/core/theme/theme.dart';
import 'package:veylo/core/widgets/app_text.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.obscureText = false,
    this.onToggleObscure,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.onChanged,
    this.prefixText,
    this.hasError = false,
    this.suffix,
    this.labelGap = AppSpacing.labelFieldGap,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final String? prefixText;
  final bool hasError;
  final Widget? suffix;
  /// Label ↔ input gap. Login/Register: 15 (default). Create profile: 4.
  final double labelGap;

  @override
  Widget build(BuildContext context) {
    final showToggle = onToggleObscure != null;
    final borderRadius = BorderRadius.circular(AppBorders.inputRadius);
    final errorBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: const BorderSide(color: AppColors.error, width: 1),
    );
    final plainBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide.none,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, style: AppTextStyles.fieldLabel),
        SizedBox(height: labelGap),
        SizedBox(
          height: AppSizes.inputHeight,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            autofillHints: autofillHints,
            onChanged: onChanged,
            style: AppTextStyles.fieldInput,
            cursorColor: AppColors.brandPurple,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.fieldPlaceholder,
              filled: true,
              fillColor: AppColors.inputFill,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 0,
              ),
              prefixText: prefixText,
              prefixStyle: AppTextStyles.fieldInput,
              border: hasError ? errorBorder : plainBorder,
              enabledBorder: hasError ? errorBorder : plainBorder,
              focusedBorder: hasError ? errorBorder : plainBorder,
              suffixIcon: _buildSuffix(showToggle),
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffix(bool showToggle) {
    if (suffix != null) return suffix;
    if (!showToggle) return null;
    return IconButton(
      onPressed: onToggleObscure,
      splashRadius: 20,
      icon: Icon(
        obscureText
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
        size: AppSizes.passwordIcon,
        color: AppColors.black,
      ),
    );
  }
}
