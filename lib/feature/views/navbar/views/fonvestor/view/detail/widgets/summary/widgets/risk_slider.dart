import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RiskWidget extends BaseStatelessWidget {
  final int? currentRisk;
  final ValueChanged<int>? onRiskChanged;

  const RiskWidget({
    super.key,
    this.currentRisk,
    this.onRiskChanged,
  });

  @override
  Widget build(BuildContext context) {
    final riskValue = (currentRisk ?? 1).clamp(1, 7);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -30.h, // Damlanın yukarıda olması için
              left: (340.w / 6) * (riskValue - 1) -
                  13.w, // Seçili değere göre damlanın konumunu hesapla
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.secondaryGreyColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '$riskValue',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            // Gradyanlı çizgi
            Container(
              width: 340.w,
              height: 10.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF24A148), // Başlangıç yeşil
                    Color(0xFF81A124),
                    Color(0xFFFFD335),
                    Color(0xFFFFBA35),
                    Color(0xFFFE5000),
                    Color(0xFFC32828), // Son kırmızı
                  ],
                  stops: [
                    0.0,
                    0.2,
                    0.4,
                    0.6,
                    0.8,
                    1.0,
                  ],
                ),
              ),
            ),

            SliderTheme(
              data: SliderThemeData(
                thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 0), // Yuvarlak indikatörü gizle
                overlayShape: SliderComponentShape
                    .noOverlay, // Üzerine tıklayınca çıkan overlay'i kaldır
                activeTrackColor: Colors.transparent,
                activeTickMarkColor: Colors.white,
                inactiveTickMarkColor: Colors.white,
                inactiveTrackColor: Colors.transparent,
                trackHeight: 12.h,
                tickMarkShape: const RoundSliderTickMarkShape(),
              ),
              child: Slider(
                value: riskValue.toDouble(),
                min: 1,
                max: 7,
                divisions: 6, // 1 ile 7 arasında 6 bölme
                onChanged: (value) {
                  if (onRiskChanged != null) {
                    onRiskChanged!(value.round());
                  }
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            // Seçili risk değerini göstermek için index numarasını gizliyoruz
            return Column(
              children: [
                Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.normal,
                    color: riskValue == index + 1
                        ? Colors.transparent
                        : Colors.grey,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
