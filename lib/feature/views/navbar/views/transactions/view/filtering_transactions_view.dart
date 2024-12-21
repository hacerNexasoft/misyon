import 'package:common/common.dart';
import 'package:flutter_svg/svg.dart';

import 'package:misyonbank/feature/views/navbar/views/transactions/transactions_view_controller.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/view/widgets/filter_button_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/view/widgets/labels_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/view/widgets/period_widget.dart';
import 'package:misyonbank/feature/views/navbar/views/transactions/view/widgets/transaction_direction_widget.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widgets/components.dart';

class FilteringTransactionsView
    extends BaseGetView<TransactionsViewController> {
  const FilteringTransactionsView({super.key});

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      iconTheme: const IconThemeData(color: AppColors.black),
      title: ScaleFactorAutoSizeText(
          text: LocalizationKeys.filterTextKey.tr,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          )),
      actions: [
        GestureDetector(
          onTap: () {
            controller.resetAllSelected();
          },
          child: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: SvgPicture.asset(AssetConstants.trashIcon),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() => GetBuilder<TransactionsViewController>(builder: (_) {
        return SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const PeriodWidget(),
                    const TransactionDirectionWidget(),
                    const LabelsWidget(),
                    SizedBox(
                      height: 50.sp,
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: FilterButtonWidget(),
              ),
            ],
          ),
        );
      });
}
