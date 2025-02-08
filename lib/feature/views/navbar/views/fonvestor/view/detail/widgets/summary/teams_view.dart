import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/detail_view_controller.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/summary/widgets/custom_team_image_card.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/summary/widgets/teams_details_widget.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:widgets/components.dart';

class TeamsView extends BaseStatelessWidget {
  final controller = Get.find<DetailViewController>();
  TeamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      iconTheme: const IconThemeData(color: AppColors.black),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: InkWell(
            child: const Icon(
              Icons.close,
              color: AppColors.darkTextColor,
            ),
            onTap: () {
              Get.back();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle,
          SizedBox(
            height: 10.h,
          ),
          _buildsubTitle,
          _buildTeamsImage,
          _buildortsubTitle,
          _buildortTeamsImage
        ],
      ),
    );
  }

  Widget get _buildTitle => Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: ScaleFactorAutoSizeText(
          text: LocalizationKeys.teamsTitleTextKey.tr,
          style: Get.theme.primaryTextTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      );
  Widget get _buildsubTitle => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScaleFactorAutoSizeText(
                  text: LocalizationKeys.teamssubTitleTextKey.tr,
                  style: Get.theme.primaryTextTheme.bodySmall!.copyWith(
                    color: AppColors.toolTipGreyColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            height: 1.h,
            color: AppColors.fillColor,
          )
        ],
      );
  Widget get _buildTeamsImage => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Wrap(
            spacing: 10.w, // Aradaki mesafe
            runSpacing: 10.h, // Satırlar arasındaki mesafe
            children: List.generate(controller.selectedProjectTeam!.teamMembers.length, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.w),
                child: CustomTeamImageCard(
                  onTap: () {
                    Get.dropdownBottomSheet(
                      child: TeamsDetailsWidget(
                        color: ColorProvider.getColor(index),
                        imageUrl: controller.selectedProjectTeam!.teamMembers[index].imageurl ?? '',
                        name: controller.selectedProjectTeam!.teamMembers[index].name,
                        role: controller.selectedProjectTeam!.teamMembers[index].title,
                      ),
                    );
                  },
                  color: ColorProvider.getColor(index),
                  imageUrl: controller.selectedProjectTeam!.teamMembers[index].imageurl ?? '',
                  name: controller.selectedProjectTeam!.teamMembers[index].name,
                  role: controller.selectedProjectTeam!.teamMembers[index].title,
                ),
              );
            }),
          ),
        ),
      );

  Widget get _buildortsubTitle => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScaleFactorAutoSizeText(
                  text: LocalizationKeys.teamsortsubTitleTextKey.tr,
                  style: Get.theme.primaryTextTheme.bodySmall!.copyWith(
                    color: AppColors.toolTipGreyColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            height: 1.h,
            color: AppColors.fillColor,
          )
        ],
      );
  Widget get _buildortTeamsImage => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 10.w, // Aradaki mesafe
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children:
                List.generate(controller.selectedProjectTeam!.participantMembers.length, (index) {
              if (index >= 4) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.w),
                  child: CustomTeamImageCard(
                    onTap: () {
                      Get.dropdownBottomSheet(
                        child: TeamsDetailsWidget(
                          color: ColorProvider.getColor(index),
                          imageUrl:
                              controller.selectedProjectTeam!.participantMembers[index].imageurl ??
                                  '',
                          name: controller.selectedProjectTeam!.participantMembers[index].name,
                          role: controller.selectedProjectTeam!.participantMembers[index].title,
                        ),
                      );
                    },
                    color: ColorProvider.getColor(index),
                    imageUrl:
                        controller.selectedProjectTeam!.participantMembers[index].imageurl ?? '',
                    name: controller.selectedProjectTeam!.participantMembers[index].name,
                    role: controller.selectedProjectTeam!.participantMembers[index].title,
                  ),
                );
              }
              return const SizedBox(); // Burada boş bir widget döndürülür
            }),
          ),
        ),
      );
}
