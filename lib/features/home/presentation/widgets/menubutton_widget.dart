
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/themes/app_colors.dart';

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  const MenuButton(
      {required this.icon, required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => Get.toNamed(route),
      contentPadding: const EdgeInsets.all(10),
    );
  }
}
