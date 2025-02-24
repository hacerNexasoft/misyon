part of '../question_and_answer_view.dart';

class ManagerDetailMessageWidget extends BaseStatelessWidget {
  final String? user;
  final String? message;
  final String? imageUrl;
  final String? messageDate;

  const ManagerDetailMessageWidget({
    super.key,
    this.user,
    this.message,
    this.imageUrl,
    this.messageDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMessageHeader,
          SizedBox(height: 8.h),
          ScaleFactorAutoSizeText(
            text: message ?? '',
            style: theme.primaryTextTheme.bodyMedium?.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          const Divider(
            color: AppColors.fillColor,
          ),
        ],
      ),
    );
  }

  String shortNameGenerator(String name) {
    String initials = "";
    List<String> nameParts = name.split(" ");
    for (String part in nameParts) {
      if (part.isNotEmpty) {
        initials += "${part[0].toUpperCase()} ";
      }
    }
    return initials.trim();
  }

  Widget get _buildMessageHeader => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: imageUrl == null
                ? CircleAvatar(child: Text(shortNameGenerator(user ?? "")))
                : CustomCachedNetworkImage(
                    imageUrl: imageUrl ?? '',
                    width: 32.w,
                    height: 32.h,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScaleFactorAutoSizeText(
                  text: user ?? '',
                  style: theme.primaryTextTheme.bodyLarge?.copyWith(
                    color: AppColors.darkGreyColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          ScaleFactorAutoSizeText(
            text: messageDate ?? '',
            style: theme.primaryTextTheme.bodyMedium?.copyWith(
              color: AppColors.darkGreyColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      );
}
