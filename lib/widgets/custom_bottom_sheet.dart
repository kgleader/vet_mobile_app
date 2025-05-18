import 'package:flutter/material.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_colors.dart';

void showCustomBottomSheet(BuildContext context, {required String title, required Widget content}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.borderRadius)),
    ),
    isScrollControlled: true, // Added for potentially taller content
    builder: (BuildContext bc) {
      return Padding( // Added Padding around the Container for better modal behavior
        padding: MediaQuery.of(context).viewInsets, // Handles keyboard overlap
        child: Container(
          padding: const EdgeInsets.all(Sizes.paddingL),
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: Sizes.spacingM), // Adjusted spacing
                child: Text(
                  title, // MODIFIED: Use the passed title
                  style: Theme.of(context).textTheme.titleLarge?.copyWith( // Using theme for consistency
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
              ),
              content, // MODIFIED: Use the passed content widget
              const SizedBox(height: Sizes.paddingM), // Adjusted spacing
            ],
          ),
        ),
      );
    },
  );
}
