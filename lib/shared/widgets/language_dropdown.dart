// lib/shared/widgets/language_dropdown.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:switch_config/core/themes/app_colors.dart';

/// Modèle d’option langue
class LangOption {
  final String label;
  final Locale locale;
  final Widget? icon;
  const LangOption({required this.label, required this.locale, this.icon});
}
class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  List<LangOption> _options(BuildContext context) => [
    LangOption(
      label: 'Français', // Add tr() here
      locale: const Locale('fr'),
      icon: const Text('🇫🇷'),
    ),
    LangOption(
      label: 'English', // Add tr() here
      locale: const Locale('en'),
      icon: const Text('🇬🇧'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final current = context.locale;
    final options = _options(context);

    return DropdownButtonHideUnderline(
      child: DropdownButton<LangOption>(
        value: options.firstWhere((o) => o.locale == current),
        style: Theme.of(context).textTheme.bodyMedium,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        dropdownColor: AppColors.primary,
        onChanged: (opt) async {

          if (opt == null) return;
          await context.setLocale(opt.locale);
          Get.updateLocale(opt.locale); // Sync with GetX

        },
        items: options.map((opt) => DropdownMenuItem<LangOption>(
          value: opt,
          child: Row(
            children: [
              if (opt.icon != null) opt.icon!,
              const SizedBox(width: 6),
              Text(opt.label, style: TextStyle(color: Colors.white)),
            ],
          ),
        )).toList(),
      ),
    );
  }
}
