import 'package:common/common.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:misyonbank/feature/views/navbar/navbar_view_controller.dart';
import 'package:misyonbank/feature/views/navbar/widgets/navbar_app_bar_widget/asset_volume_chart_widget.dart';
import 'package:misyonbank/product/config/routes/app_views.dart';
import 'package:misyonbank/product/config/theme/theme_extensions.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:widgets/components.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'widgets/navbar_app_bar_widget/navbar_app_bar_widget.dart';
part 'widgets/navbar_app_bar_widget/navbar_app_bar_info_widget.dart';

class NavbarView extends BaseGetView<NavbarViewController> {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavbarViewController>(
      builder: (controller) => Scaffold(
        appBar: controller.navBarViews[controller.selectedIndex.value]
                    ['appbarTitle'] !=
                null
            ? _buildAppBar(
                title: controller.navBarViews[controller.selectedIndex.value]
                    ['appbarTitle'],
              )
            : null,
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBody() {
    final selectedRoute =
        controller.navBarViews[controller.selectedIndex.value]['route'];
    final isCustomScrollViewRequired = selectedRoute == AppRoutes.fonvestor ||
        selectedRoute == AppRoutes.investments;

    return isCustomScrollViewRequired
        ? _buildCustomScrollViewBody()
        : _buildNavigatorBody();
  }

  Widget _buildCustomScrollViewBody() {
    return CustomScrollView(
      slivers: [
        _NavbarAppBarWidget(),
        SliverToBoxAdapter(
          child: _buildNavigatorBody(),
        ),
      ],
    );
  }

  Widget _buildNavigatorBody() {
    return Navigator(
      key: Get.nestedKey(1),
      onGenerateRoute: controller.onGenerateRoute,
      initialRoute: controller.routes[controller.selectedIndex.value],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        backgroundColor: AppColors.backgroundColor,
        currentIndex: controller.selectedIndex.value,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: _bottomNavLabelStyle(AppColors.primaryColor),
        unselectedLabelStyle: _bottomNavLabelStyle(AppColors.primaryGreyColor),
        onTap: controller.changeView,
        items: controller.bottomNavigationBarItems,
      ),
    );
  }

  TextStyle _bottomNavLabelStyle(Color color) {
    return TextStyle(
      color: color,
      fontSize: 13.h,
      fontWeight: FontWeight.w500,
    );
  }

  AppBar _buildAppBar({
    required String title,
    bool? centerTitle,
  }) =>
      AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: centerTitle ?? false,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: AppColors.black,
            )),
        title: ScaleFactorAutoSizeText(
          text: title,
          style: theme.primaryTextTheme.headlineMedium?.semibold,
        ),
      );
}
