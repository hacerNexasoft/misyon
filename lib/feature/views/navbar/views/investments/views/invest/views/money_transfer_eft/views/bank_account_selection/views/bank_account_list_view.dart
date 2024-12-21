part of '../../../../../invest_view.dart';

class _BankAccountListView extends BaseGetView<BankAccountSelectionViewController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Obx(() => ListView.separated(
        shrinkWrap: true,
        itemCount: controller.accounts[controller.selectedTabIndex.value].length,
        itemBuilder: (context, index) => _BankAccountListItemWidget(
          bankAccount: controller.accounts[controller.selectedTabIndex.value][index],
          onTap: () => controller.changeSelectedBankAccount(
              controller.accounts[controller.selectedTabIndex.value][index]),
        ),
        separatorBuilder: (context, index) => Divider(
          height: 1,
          indent: 40.w,
          endIndent: 40.w,
          color: AppColors.dividerColor,
        ),
      )),
      onLoading: const LoadingWidget(),
      onEmpty: EmptyWidget(
        image: AssetConstants.emptyItemIcon,
        text: LocalizationKeys.emptySearchTextKey.tr,
        size: 75.h,
      ),
      onError: (error) => CustomErrorWidget(
        text: LocalizationKeys.tryAgainTextKey.tr,
        onRetry: controller.init,
      ),
    );
  }
}
