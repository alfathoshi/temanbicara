import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:temanbicara/app/themes/colors.dart';
import 'package:temanbicara/app/themes/fonts.dart';

class PasswordValidationView extends StatelessWidget {
  const PasswordValidationView({
    super.key,
    required this.rules,
    required this.value,
  });

  final Set<ValidationRule> rules;
  final String value;

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: rules.map((rule) {
        final isValid = rule.validate(value);
        return Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            children: [
              Icon(
                isValid ? Icons.check : Icons.close,
                size: 18,
                color: isValid ? primaryColor : error,
              ),
              const SizedBox(width: 8),
              Text(
                rule.name,
                style: h6Regular.copyWith(
                  color: isValid ? primaryColor : error,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
