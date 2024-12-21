import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:common/common.dart';

class CupertinoTabBarComp extends BaseStatelessWidget {
  final Function(int)? changeTab;
  final TabController tabController;
  final List<String> tabs;

  const CupertinoTabBarComp({
    super.key,
    this.changeTab,
    required this.tabController,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.fillColor,
      ),
      child: TabBar(
        onTap: changeTab,
        dividerColor: Colors.transparent,
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.black,
        unselectedLabelColor: AppColors.darkGreyColor,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.backgroundColor,
        ),
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      ),
    );
  }
}
