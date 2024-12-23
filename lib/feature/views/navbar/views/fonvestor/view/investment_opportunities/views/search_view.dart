import 'package:common/common.dart';
import 'package:misyonbank/feature/components/search_row_comp.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/investment_opportunities_controller.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/investment_opportunities/views/widgets/popular_sectors_widget.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';

class SearchView extends BaseGetView<InvestmentOpportunitiesController> {
  const SearchView({super.key});

  @override
  Widget build(Object context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() =>
      GetBuilder<InvestmentOpportunitiesController>(builder: (_) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: const SearchRowComp(
                    giveUp: true,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                PopularSectors(
                  title: LocalizationKeys.popularSectorsKey.tr,
                  iconPath: AssetConstants.popularIcon,
                  items: controller.sectors.toList(),
                )
              ],
            ),
          ),
        );
      });
}
