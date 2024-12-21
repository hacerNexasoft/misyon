import 'package:common/common.dart';
import 'package:misyonbank/feature/components/categories_comp/categories_comp_controller.dart';
import 'package:misyonbank/feature/components/categories_comp/category_card_comp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesComp extends BaseStatelessWidget {
  CategoriesComp({super.key});

  final controller = Get.put(CategoriesCompController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.categories.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: controller.categories[index] != null
              ? CategoryCardComp(
                  category: controller.categories[index],
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
