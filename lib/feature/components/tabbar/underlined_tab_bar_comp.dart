import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/gestures.dart';
import 'dart:math' as math;

class UnderlinedTabBarComp extends BaseStatelessWidget
    implements PreferredSizeWidget {
  final List<String> tabTitles;
  final TabController tabController;
  final EdgeInsetsGeometry? tabPadding;
  final Function(int)? changeTab;
  final ScrollPhysics? physics;
  final Color? backgroundColor;

  UnderlinedTabBarComp({
    super.key,
    required this.tabTitles,
    required this.tabController,
    this.tabPadding,
    this.physics,
    this.changeTab,
    this.backgroundColor,
  }) {
    tabs = tabTitles
        .map(
          (tabTitle) => Tab(
            text: tabTitle.tr,
            iconMargin: EdgeInsets.zero,
          ),
        )
        .toList();
  }
  late final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      child: Stack(
        children: [
          const Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: TabBar(
              tabAlignment: TabAlignment.center,
              controller: tabController,
              dragStartBehavior: DragStartBehavior.start,
              labelPadding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ).w,
              labelStyle: theme.primaryTextTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              unselectedLabelStyle: theme.primaryTextTheme.bodyMedium,
              unselectedLabelColor: AppColors.hintColor,
              labelColor: AppColors.black,
              padding: tabPadding ??
                  EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
              indicatorSize: TabBarIndicatorSize.label,
              indicator: UnderlineTabIndicator(
                borderSide:
                    BorderSide(color: AppColors.primaryColor, width: 3.h),
              ),
              isScrollable: true,
              physics: physics ?? const NeverScrollableScrollPhysics(),
              tabs: tabs,
              onTap: changeTab,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    var maxHeight = 46.0;
    for (final item in tabs) {
      if (item is PreferredSizeWidget) {
        final itemHeight = item.preferredSize.height;
        maxHeight = math.max(itemHeight, maxHeight);
      }
    }
    return Size.fromHeight(maxHeight + 2.0);
  }
}
