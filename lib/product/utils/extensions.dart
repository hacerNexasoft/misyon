import 'package:common/common.dart';
import 'package:flutter_svg/svg.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/bank_account_model.dart';
import 'package:misyonbank/product/utils/formatter.dart';

extension TimeRanges on TimeRange {
  String get timeRangeString {
    switch (this) {
      case TimeRange.Day1:
        return '1G';
      case TimeRange.Day3:
        return '3G';
      case TimeRange.Week1:
        return '1H';
      case TimeRange.Month1:
        return '1A';
      case TimeRange.Month6:
        return '6A';
      case TimeRange.Year1:
        return '1Y';
    }
  }
}

extension InvestmentProcessExtension on MyInvestmentsProcess {
  String get investmentProcessString {
    switch (this) {
      case MyInvestmentsProcess.openInvestment:
        return LocalizationKeys.openInvestmentTextKey.tr;
      case MyInvestmentsProcess.returnPeriod:
        return LocalizationKeys.returnPeriodTextKey.tr;
      case MyInvestmentsProcess.atTermination:
        return LocalizationKeys.atTerminationTextKey.tr;
    }
  }

  Color get investmentProcessColor {
    switch (this) {
      case MyInvestmentsProcess.openInvestment:
        return AppColors.darkGreyColor;
      case MyInvestmentsProcess.returnPeriod:
        return AppColors.primaryColor;
      case MyInvestmentsProcess.atTermination:
        return AppColors.darkGreyColor;
    }
  }
}

extension InvestmentStatusExtension on InvestmentStatus {
  String get description {
    switch (this) {
      case InvestmentStatus.all:
        return LocalizationKeys.allTextslowerKey.tr;
      case InvestmentStatus.upcoming:
        return LocalizationKeys.soonTextKey.tr;
      case InvestmentStatus.preRequest:
        return LocalizationKeys.preDemandStatusTextKey.tr;
      case InvestmentStatus.reachedTarget:
        return LocalizationKeys.completedProjectsTextKey.tr;
      case InvestmentStatus.openInvestments:
        return LocalizationKeys.openInvestmentsKey.tr;
      case InvestmentStatus.failureToReachTarget:
        return LocalizationKeys.failureToReachTargetKey.tr;
      case InvestmentStatus.favorites:
        return LocalizationKeys.favoritesTextKey.tr;
    }
  }

  String toShortString() {
    return toString().split('.').last;
  }

  static InvestmentStatus fromDescription(String description) {
    return InvestmentStatus.values.firstWhere(
      (status) => status.description == description,
      orElse: () => InvestmentStatus.all,
    );
  }

  static InvestmentStatus fromString(String status) {
    return InvestmentStatus.values.firstWhere(
      (e) => e.toShortString() == status,
      orElse: () => InvestmentStatus.all,
    );
  }
}

extension ProjectStatusExtension on ProjectStatus? {
  static ProjectStatus? fromString(String? status) {
    switch (status) {
      case 'preDemand':
        return ProjectStatus.preDemand;
      case 'upcoming':
        return ProjectStatus.upcoming;
      case 'open':
        return ProjectStatus.open;
      case 'completed':
        return ProjectStatus.completed;
      default:
        return null;
    }
  }

  String? toStringValue() {
    switch (this) {
      case ProjectStatus.preDemand:
        return 'preDemand';
      case ProjectStatus.upcoming:
        return 'upcoming';
      case ProjectStatus.open:
        return 'open';
      case ProjectStatus.completed:
        return 'completed';
      default:
        return null;
    }
  }

  String statusText(String infoText) {
    switch (this) {
      case ProjectStatus.preDemand:
        return LocalizationKeys.preDemandStatusTextKey.tr;
      case ProjectStatus.upcoming:
        return LocalizationKeys.soonTextKey.tr;
      case ProjectStatus.open:
        return infoText;
      case ProjectStatus.completed:
        return LocalizationKeys.completionStatusTextKey.tr;
      default:
        return infoText;
    }
  }

  Color getBackgroundColor(int? maturity) {
    switch (this) {
      case ProjectStatus.completed:
        return AppColors.primaryGreenColor;
      case ProjectStatus.terminated:
        return AppColors.borderRedColor;
      case ProjectStatus.preDemand:
      case ProjectStatus.open:
      case ProjectStatus.upcoming:
        return AppColors.black.withOpacity(0.5);
      default:
        if (maturity == null) {
          return AppColors.primaryGreenColor;
        }

        if (maturity > 0 && maturity <= 5) {
          return AppColors.borderRedColor;
        } else {
          return AppColors.black.withOpacity(0.5);
        }
    }
  }
}

extension BankAccountTypeExtension on BankAccountType {
  String get getStringFromEnum {
    switch (this) {
      case BankAccountType.current:
        return 'Vadesiz';
      case BankAccountType.futures:
        return 'Vadeli';
    }
  }

  static BankAccountType? fromString(String? type) {
    switch (type) {
      case 'Vadesiz':
        return BankAccountType.current;
      case 'Vadeli':
        return BankAccountType.futures;
      default:
        return null;
    }
  }
}

extension ExploreInvestmentExtension on ExploreInvestment {
  String get getStringExploreInvestment {
    switch (this) {
      case ExploreInvestment.firstInvestment:
        return 'İlk Yatırım';
      case ExploreInvestment.highestInvestment:
        return 'En Yüksek Yatırım';
      case ExploreInvestment.lastInvestment:
        return 'Son Yatırım';
      case ExploreInvestment.empty:
        return '';
    }
  }

  Color get getColorTextExploreInvestment {
    switch (this) {
      case ExploreInvestment.firstInvestment:
        return AppColors.investmenttextfirstColor;
      case ExploreInvestment.highestInvestment:
        return AppColors.investmenttexthigColor;
      case ExploreInvestment.lastInvestment:
        return AppColors.investmenttextlastColor;
      case ExploreInvestment.empty:
        return Colors.transparent;
    }
  }

  Color get getColorExploreInvestment {
    switch (this) {
      case ExploreInvestment.firstInvestment:
        return AppColors.investmentfirstColor;
      case ExploreInvestment.highestInvestment:
        return AppColors.investmenthigColor;
      case ExploreInvestment.lastInvestment:
        return AppColors.investmentlastColor;
      case ExploreInvestment.empty:
        return Colors.transparent;
    }
  }
}

extension BankAccountModelExtensions on BankAccountModel {
  String? getHeaderTitle(bool isSelectedBankAccount) {
    switch (category) {
      case BankAccountCategory.mission:
        return '${LocalizationKeys.availableTextKey.tr}: ${Formatter.formatMoney(availableBalance.toString())}';
      case BankAccountCategory.otherAccounts:
        return !isSelectedBankAccount
            ? iban
            : '${LocalizationKeys.availableTextKey.tr}: ${Formatter.formatMoney(availableBalance.toString())}';
      case BankAccountCategory.bankInstitution:
        return '';
      default:
        return '${accountType?.getStringFromEnum} $currency';
    }
  }
}

extension BankAccountCategoryExtension on BankAccountCategory {
  String get getStringFromEnum {
    switch (this) {
      case BankAccountCategory.mission:
        return LocalizationKeys.missionTextKey.tr;

      case BankAccountCategory.otherAccounts:
        return LocalizationKeys.myOtherAccountsTextKey.tr;

      case BankAccountCategory.bankInstitution:
        return LocalizationKeys.bankInstitutionTextKey.tr;
    }
  }

  static BankAccountCategory? fromString(String? category) {
    switch (category) {
      case 'mission':
        return BankAccountCategory.mission;
      case 'otherAccounts':
        return BankAccountCategory.otherAccounts;
      case 'bankInstitution':
        return BankAccountCategory.bankInstitution;
      default:
        return null;
    }
  }

  String get customText {
    switch (this) {
      case BankAccountCategory.mission:
        return "Tutarın Çekileceği Hesap";
      case BankAccountCategory.otherAccounts:
      case BankAccountCategory.bankInstitution:
        return "Gönderen Hesap";
    }
  }
}

extension PaymentMethodExtension on PaymentMethod {
  static PaymentMethod fromString(String value) {
    switch (value) {
      case 'sendMoney':
        return PaymentMethod.sendMoney;
      case 'takeMoney':
        return PaymentMethod.takeMoney;
      default:
        throw Exception('Invalid payment method: $value');
    }
  }

  StatelessWidget get icon {
    switch (this) {
      case PaymentMethod.sendMoney:
        return SvgPicture.asset(AssetConstants.arrowDownLeftIcon);
      case PaymentMethod.takeMoney:
        return SvgPicture.asset(AssetConstants.arrowUpRightIcon);
    }
  }

  String toStringValue() {
    switch (this) {
      case PaymentMethod.sendMoney:
        return 'sendMoney';
      case PaymentMethod.takeMoney:
        return 'takeMoney';
    }
  }
}

extension RiskTypeExtension on RiskType {
  Color get color {
    switch (this) {
      case RiskType.risky:
        return AppColors.primaryRedColor;
      case RiskType.neutral:
        return AppColors.riskColorYellow;
      case RiskType.profitable:
        return AppColors.primaryGreenColor;
    }
  }
}
