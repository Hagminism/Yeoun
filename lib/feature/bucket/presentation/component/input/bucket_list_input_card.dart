import 'package:flutter/material.dart';

import '../../../../../ui/app_assets.dart';
import '../../../../../ui/app_colors.dart';
import '../../../../../ui/app_text_styles.dart';
import '../../../../../ui/presentation/component/app_card_surface.dart';
import '../../../../../ui/presentation/component/app_asset_icon.dart';

class BucketListInputCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;
  final void Function(String) onChanged;
  final void Function() onAdd;

  const BucketListInputCard({
    super.key,
    required this.formKey,
    required this.focusNode,
    required this.onChanged,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardSurface(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const SizedBox(width: 2),
          const AppAssetIcon(AppAssets.list),
          const SizedBox(width: 8),
          Expanded(
            child: Form(
              key: formKey,
              child: TextFormField(
                focusNode: focusNode,
                onChanged: onChanged,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (String value) {
                  onAdd();
                },
                style: AppTextStyles.cardBody,
                decoration: const InputDecoration(
                  hintText: '함께 이루고 싶은 버킷을 적어보세요!',
                  hintStyle: TextStyle(color: AppColors.disabledText),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 9),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: AppColors.coralDeep,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.ink),
            ),
            child: InkWell(
              onTap: onAdd,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add, color: Colors.white, size: 16),
                    const SizedBox(width: 2),
                    Text(
                      '추가',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
