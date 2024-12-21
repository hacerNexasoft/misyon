part of '../../navbar_view.dart';

class _NavbarAppBarWidget extends BaseGetView<NavbarViewController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => SliverAppBar(
          pinned: true,
          expandedHeight: controller.isAppBarExpanded.value ? 170.h : kToolbarHeight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.w),
              bottomRight: Radius.circular(16.w),
            ),
          ),
          leading: _buildIcon(
            assetPath: AssetConstants.menuIcon,
            onTap: () {},
          ),
          actions: [
            _buildIcon(
              assetPath: AssetConstants.notificationsIcon,
              onTap: () {},
            ),
          ],
          flexibleSpace: controller.isAppBarExpanded.value
              ? FlexibleSpaceBar(
                  background: controller.isAppBarExpanded.value
                      ? _NavbarAppBarInfoWidget()
                      : const SizedBox(),
                )
              : null,
        ));
  }

  Widget _buildIcon({required String assetPath, required Function() onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: GestureDetector(
        onTap: onTap,
        child: SvgPicture.asset(
          assetPath,
          width: 24.w,
        ),
      ),
    );
  }
}
