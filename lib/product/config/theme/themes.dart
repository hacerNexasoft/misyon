import 'package:common/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppColors.backgroundColor,
  iconTheme: const IconThemeData(color: AppColors.primaryColor),
  primaryColor: AppColors.primaryColor,
  appBarTheme: const AppBarTheme(
    color: AppColors.primaryColor,
    iconTheme: IconThemeData(
      color: AppColors.backgroundColor,
    ),
  ),
  primaryTextTheme: TextTheme(
    displayLarge: GoogleFonts.publicSans(
      fontSize: 34,
      color: AppColors.black,
    ),
    displayMedium: GoogleFonts.publicSans(
      fontSize: 25,
      color: AppColors.black,
    ),
    displaySmall: GoogleFonts.publicSans(
      fontSize: 18.5,
      color: AppColors.black,
    ),
    headlineMedium: GoogleFonts.publicSans(
      fontSize: 21.5,
      color: AppColors.black,
    ),
    headlineSmall: GoogleFonts.publicSans(
      fontSize: 18,
      color: AppColors.black,
    ),
    titleLarge: GoogleFonts.publicSans(
      fontSize: 26,
      color: AppColors.black,
    ),
    titleMedium: GoogleFonts.publicSans(
      fontSize: 24,
      color: AppColors.black,
    ),
    titleSmall: GoogleFonts.publicSans(
      fontSize: 20,
      color: AppColors.black,
    ),
    bodyLarge: GoogleFonts.publicSans(
      fontSize: 16,
      color: AppColors.black,
    ),
    bodyMedium: GoogleFonts.publicSans(
      fontSize: 12,
      color: AppColors.black,
    ),
    bodySmall: GoogleFonts.publicSans(
      fontSize: 10,
      color: AppColors.black,
    ),
    labelLarge: GoogleFonts.publicSans(
      fontSize: 9,
      color: AppColors.black,
    ),
    labelMedium: GoogleFonts.publicSans(
      fontSize: 8,
      color: AppColors.black,
    ),
    labelSmall: GoogleFonts.publicSans(
      fontSize: 7,
      color: AppColors.black,
    ),
  ),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.grey1000Color,
  brightness: Brightness.dark,
  cardColor: AppColors.cardColor,
  indicatorColor: AppColors.primaryColor,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  dividerColor: AppColors.dividerColor,
  iconTheme: IconThemeData(
    size: 20.sp,
    color: AppColors.primaryColor,
  ),
  primaryIconTheme: IconThemeData(
    size: 20.0.sp,
    color: AppColors.primaryColor,
  ),
  cardTheme: CardTheme(
    color: AppColors.cardColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Get.width * 0.03),
    ),
    margin: EdgeInsets.zero,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.primaryColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.grey1000Color,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.grey600Color,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: AppColors.grey1000Color,
    elevation: 4,
  ),
  primaryTextTheme: TextTheme(
    displayLarge: GoogleFonts.publicSans(
      fontSize: 34,
      color: AppColors.white,
    ),
    displayMedium: GoogleFonts.publicSans(
      fontSize: 25,
      color: AppColors.white,
    ),
    displaySmall: GoogleFonts.publicSans(
      fontSize: 18,
      color: AppColors.white,
    ),
    headlineMedium: GoogleFonts.publicSans(
      fontSize: 21.5,
      color: AppColors.white,
    ),
    headlineSmall: GoogleFonts.publicSans(
      fontSize: 18,
      color: AppColors.white,
    ),
    titleLarge: GoogleFonts.publicSans(
      fontSize: 18,
      color: AppColors.white,
    ),
    titleMedium: GoogleFonts.publicSans(
      fontSize: 16,
      color: AppColors.white,
    ),
    titleSmall: GoogleFonts.publicSans(
      fontSize: 14,
      color: AppColors.white,
    ),
    bodyLarge: GoogleFonts.publicSans(
      fontSize: 14,
      color: AppColors.white,
    ),
    bodyMedium: GoogleFonts.publicSans(
      fontSize: 12,
      color: AppColors.white,
    ),
    bodySmall: GoogleFonts.publicSans(
      fontSize: 10,
      color: AppColors.white,
    ),
    labelLarge: GoogleFonts.publicSans(
      fontSize: 9,
      color: AppColors.white,
    ),
    labelMedium: GoogleFonts.publicSans(
      fontSize: 8,
      color: AppColors.white,
    ),
    labelSmall: GoogleFonts.publicSans(
      fontSize: 7,
      color: AppColors.white,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.grey800Color,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    brightness: Brightness.dark,
    surface: AppColors.backgroundColor,
  ),
);
