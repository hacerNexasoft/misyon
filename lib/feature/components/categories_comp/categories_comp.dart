import 'package:common/common.dart';
import 'package:misyonbank/feature/components/categories_comp/category_card_comp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/fonvestor_view_controller.dart';

class CategoriesComp extends BaseGetView<FonvestorViewController> {
  const CategoriesComp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.categoryList.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: CategoryCardComp(
            category: controller.categoryList[index],
            index: index,
          ),
        ),
      ),
    );
  }
}
