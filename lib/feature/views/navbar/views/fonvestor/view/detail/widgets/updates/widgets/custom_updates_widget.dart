import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/models/project/project_update_model.dart';
import 'package:widgets/components.dart';

class CustomUpdatesWidget extends BaseStatelessWidget {
  final ProjectUpdateModel projectUpdateModel;

  const CustomUpdatesWidget({super.key, required this.projectUpdateModel});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateformatter1 = DateFormat('dd MMM');
    final DateFormat dateformatter2 = DateFormat('yyyy');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: ScaleFactorAutoSizeText(
                textAlign: TextAlign.start,
                text: dateformatter1.format(
                    DateTime.fromMillisecondsSinceEpoch(projectUpdateModel.updateDate * 1000)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: ScaleFactorAutoSizeText(
                textAlign: TextAlign.start,
                text: dateformatter2.format(
                    DateTime.fromMillisecondsSinceEpoch(projectUpdateModel.updateDate * 1000)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 10.w),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.fillColor, borderRadius: BorderRadius.circular(Get.width * 0.02)),
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 6.w),
                  child: ScaleFactorAutoSizeText(
                    text: projectUpdateModel.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.primaryTextTheme.bodyMedium!.semibold.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
                // if (description != null && description!.isNotEmpty)
                ScaleFactorAutoSizeText(
                  text: projectUpdateModel.description,
                  style: theme.primaryTextTheme.bodySmall?.copyWith(
                    color: AppColors.grey500Color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
