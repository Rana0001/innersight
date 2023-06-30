import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/fake_models/product_review_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_gaps.dart';
import '../utils/images.dart';
import 'core.dart';

/// Review widget
class ReviewDetailsWidget extends StatelessWidget {
  const ReviewDetailsWidget({
    Key? key,
    required this.review,
  }) : super(key: key);

  final ProductReview review;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: review.reviewerProfileImage,
          radius: 24,
        ),
        AppGaps.wGap16,
        Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.reviewerName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            AppGaps.hGap5,
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    height: 20,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => AppGaps.wGap2,
                      itemCount: 5,
                      itemBuilder: (context, index) => SvgPicture.asset(
                        AppAssetImages.starSVGLogoSolid,
                        color: review.rating >= (index + 1)
                            ? AppColors.secondaryColor
                            : AppColors.secondaryColor.withOpacity(0.5),
                      ),
                    )),
                Text(
                  review.reviewDateText,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.bodyTextColor),
                ),
              ],
            ),
            AppGaps.hGap11,
            Text(
              review.reviewText,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.bodyTextColor),
            )
          ],
        ))
      ],
    );
  }
}

/// Product size widget
class ProductSizeWidget extends StatelessWidget {
  final String availableSizeText;
  final bool isSelected;
  final void Function()? onTap;
  const ProductSizeWidget(
      {Key? key,
      required this.availableSizeText,
      required this.isSelected,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Stack(
        alignment: Alignment.center,
        children: [
          CustomIconButtonWidget(
              backgroundColor: AppColors.shadeColor1,
              borderRadiusRadiusValue: const Radius.circular(12),
              onTap: onTap,
              child: Text(
                availableSizeText,
                style: const TextStyle(
                    color: AppColors.bodyTextColor,
                    fontWeight: FontWeight.w500),
              )),
          Positioned(
            top: 1,
            right: 0,
            child: SvgPicture.asset(
              AppAssetImages.tickRoundedSVGLogoSolid,
              height: 12,
              width: 12,
              color: AppColors.successColor,
            ),
          )
        ],
      );
    }
    return CustomIconButtonWidget(
        backgroundColor: AppColors.shadeColor1,
        borderRadiusRadiusValue: const Radius.circular(12),
        onTap: onTap,
        child: Text(
          availableSizeText,
          style: const TextStyle(
              color: AppColors.bodyTextColor, fontWeight: FontWeight.w500),
        ));
  }
}
