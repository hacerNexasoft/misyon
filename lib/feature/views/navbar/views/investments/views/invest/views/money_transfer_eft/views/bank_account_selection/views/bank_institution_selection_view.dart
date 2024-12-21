part of '../../../../../invest_view.dart';

class _BankInstitutionSelectionView
    extends BaseGetView<BankAccountSelectionViewController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: Column(
        children: [
          SearchComp(
            hintText: LocalizationKeys.searchTextKey,
            onChanged: controller.filterBanks,
          ),
          _bankList,
        ],
      ),
    );
  }

  Widget get _bankList => controller.obx(
        (_) => Flexible(
          child: Obx(
            () => ListView.builder(
              itemCount: controller.filteredBankList.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) =>
                  controller.filteredBankList[index] != null
                      ? bankListItemWidget(
                          bank: controller.filteredBankList[index]!,
                        )
                      : const SizedBox(),
            ),
          ),
        ),
        onLoading: const LoadingWidget(),
        onEmpty: Expanded(
          child: EmptyWidget(
            image: AssetConstants.emptyItemIcon,
            text: LocalizationKeys.emptySearchTextKey.tr,
            size: 75.h,
          ),
        ),
        onError: (error) => CustomErrorWidget(
          text: LocalizationKeys.tryAgainTextKey.tr,
          onRetry: controller.init,
        ),
      );

  Widget bankListItemWidget({required BankModel bank}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.w),
      child: ListTile(
        onTap: () => controller.changeSelectedBank(bank),
        contentPadding: EdgeInsets.zero,
        leading: ProjectCustomCachedNetworkImageComp(
          imageUrl: bank.imageUrl,
          isCircular: true,
          fit: BoxFit.cover,
          size: 40.w,
        ),
        title: ScaleFactorAutoSizeText(
          text: bank.name,
          style: theme.primaryTextTheme.bodyMedium?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: AppColors.checkboxBorderColor,
          size: 12.w,
        ),
      ),
    );
  }
}
