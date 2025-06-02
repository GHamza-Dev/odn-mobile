import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:switch_config/core/themes/app_colors.dart';
import 'package:switch_config/shared/widgets/uderlined-title.dart';
import '../../domain/entities/attachment.dart';

typedef OnAddPhoto = void Function(String path);
typedef OnDeletePhoto = void Function(int index);

class PhotoGridWidget extends StatelessWidget {
  final List<Attachment> photos;
  final OnAddPhoto onAdd;
  final OnDeletePhoto onDelete;

  const PhotoGridWidget({
    Key? key,
    required this.photos,
    required this.onAdd,
    required this.onDelete,
  }) : super(key: key);

  Future<void> _pickImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file != null) {
      onAdd(file.path);
    }
  }

  void _confirmDelete(BuildContext context, int idx) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('confirm_delete'.tr()),
        content: Text('delete_photo_confirmation'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              onDelete(idx);
              Navigator.of(context).pop();
            },
            child: Text(
              'delete'.tr(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _preview(BuildContext context, String path) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: InteractiveViewer(
            child: Image.file(File(path)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        UnderlinedTitle(title: 'stepper_scan_boitier.step3.photos'.tr(),
        fontSize: 16,
        underlineColor: AppColors.secondary,),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: photos.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, i) {
            if (i == photos.length) {
              return GestureDetector(
                onTap: _pickImage,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: const Icon(Icons.add_a_photo),
                ),
              );
            }

            final path = photos[i].path;
            return Stack(
              fit: StackFit.expand,
              children: [
                GestureDetector(
                  onTap: () => _preview(context, path),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      File(path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _confirmDelete(context, i),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.delete, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}