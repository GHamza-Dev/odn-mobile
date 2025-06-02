// lib/features/scan_boitier/presentation/widgets/comment_widget.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../shared/widgets/uderlined-title.dart';

typedef OnCommentChanged = void Function(String text);

class CommentWidget extends StatelessWidget {
  final OnCommentChanged onChanged;
  const CommentWidget({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        UnderlinedTitle(title: 'stepper_scan_boitier.step3.commentaire'.tr(),
          fontSize: 16,
          underlineColor: AppColors.secondary,),

        const SizedBox(height: 8),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            hintText: 'stepper_scan_boitier.step3.observation_hint'.tr(),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
