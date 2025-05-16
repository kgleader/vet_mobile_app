import 'package:flutter/material.dart';
import 'package:vet_mobile_app/core/custom_button.dart';

class AuthButtons {
  static Widget loginButton({
    required VoidCallback onPressed,
    required bool isLoading,
  }) {
    return CustomButton(
      text: 'Кирүү',
      onPressed: isLoading ? null : onPressed,
      isLoading: isLoading,
    );
  }

  static Widget registerButton({
    required VoidCallback onPressed,
    required bool isLoading,
  }) {
    return CustomButton(
      text: 'Катталуу',
      onPressed: isLoading ? null : onPressed,
      isLoading: isLoading,
    );
  }

  static Widget resetPasswordButton({
    required VoidCallback onPressed,
    required bool isLoading,
  }) {
    return CustomButton(
      text: 'Жөнөтүү',
      onPressed: isLoading ? null : onPressed,
      isLoading: isLoading,
    );
  }

  static Widget confirmButton({
    required VoidCallback onPressed,
    required bool isLoading,
  }) {
    return CustomButton(
      text: 'Ырастоо',
      onPressed: isLoading ? null : onPressed,
      isLoading: isLoading,
    );
  }
}