import 'package:flutter/material.dart';

import '../../../../../core/utils/app_theme.dart';

/// Shared text field for every auth screen: label, optional
/// password-visibility toggle, and consistent validation styling.
class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.prefixIcon,
    this.autofillHints,
  });

  final String label;
  final String? hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final Iterable<String>? autofillHints;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscured = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscured,
      keyboardType: widget.keyboardType,
      maxLines: widget.keyboardType == TextInputType.multiline ?
      null:1,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      autofillHints: widget.autofillHints,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 15,
        color: AppColors.ink,
      ),

      decoration: InputDecoration(

        labelText: widget.label,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon == null
            ? null
            : Icon(widget.prefixIcon, color: AppColors.inkMuted, size: 20),
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: AppColors.inkMuted,
            size: 20,
          ),
          onPressed: () => setState(() => _obscured = !_obscured),
        )
            : null,
      ),
    );
  }
}