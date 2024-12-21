import 'package:common/common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misyonbank/feature/components/search/search_comp_controller.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class SearchComp extends BaseStatelessWidget {
  final TextEditingController? textEditingController;
  final String? hintText;
  final Function(String)? onChanged;
  SearchComp(
      {super.key, this.textEditingController, this.hintText, this.onChanged});

  final controller = Get.put(SearchCompController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: ListView(
        padding: EdgeInsets.zero.w,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _searchBar,
        ],
      ),
    );
  }

  Widget get _searchBar => CustomTextField(
        textEditingController: textEditingController,
        hintText: hintText,
        hintStyle: theme.primaryTextTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.darkGreyColor,
        ),
        filled: true,
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SvgPicture.asset(
            AssetConstants.searchIcon,
            colorFilter: const ColorFilter.mode(
                AppColors.darkGreyColor, BlendMode.srcIn),
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40.w,
          minHeight: 40.h,
        ),
        contentVerticalPadding: 10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        fillColor: AppColors.textFieldFillColor,
        style: theme.primaryTextTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.darkGreyColor,
        ),
        onChanged: onChanged,
        keyboardType: TextInputType.text,
      );
}
