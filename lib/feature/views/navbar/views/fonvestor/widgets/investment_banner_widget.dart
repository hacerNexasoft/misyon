part of '../fonvestor_view.dart';

class _InvestmentBannerWidget extends BaseStatelessWidget {
  final List<String> investmentBanner;
  const _InvestmentBannerWidget({
    required this.investmentBanner,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 126.sp,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: investmentBanner.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: (index == 0 ? 10 : 10).w,
                  right: (index == 1 ? 10 : 10).w,
                ),
                child: Image.asset(
                  width: Get.width * 0.9,
                  investmentBanner[index],
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
