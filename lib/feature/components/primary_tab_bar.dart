import 'package:common/common.dart';

class PrimaryTabBar extends BaseStatelessWidget {
  final List<String> tabs;
  final TabController tabController;
  final Function(int) onTabSelected;
  final Color? dividerColor;

  const PrimaryTabBar(
      {super.key,
      required this.tabs,
      required this.tabController,
      required this.onTabSelected,
      this.dividerColor});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: List.generate(tabs.length, (index) => Tab(text: tabs[index])),
      controller: tabController,
      onTap: onTabSelected,
      dividerColor: dividerColor ?? Colors.transparent,
      indicatorSize: TabBarIndicatorSize.label,
      padding: EdgeInsets.zero,
      tabAlignment: TabAlignment.start,
      splashFactory: NoSplash.splashFactory,
      isScrollable: true,
      labelStyle: theme.primaryTextTheme.bodyMedium?.copyWith(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: theme.primaryTextTheme.bodyMedium
          ?.copyWith(color: AppColors.primaryGreyColor),
    );
  }
}
