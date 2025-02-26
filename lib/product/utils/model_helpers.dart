import 'package:common/common.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';

class ModelHelpers {
  static ProjectStatus findProjectStatusByCode(int code) {
    switch (code) {
      case 1:
        return ProjectStatus.upcomingPrerelease;
      case 103520000:
        return ProjectStatus.activeFunding;
      case 103520013:
        return ProjectStatus.activeFundingStopped;
      case 103520002:
        return ProjectStatus.successful;
      case 103520009:
        return ProjectStatus.upcomingDetailedPrerelease;
      case 103520004:
        return ProjectStatus.upcomingPreview;
      default:
        return ProjectStatus.unknown;
    }
  }

  static InvestmentStatus findInvestmentStatusByCode(int code) {
    switch (code) {
      case 1:
        return InvestmentStatus.waitingPayment;
      case 103520000:
        return InvestmentStatus.paymentReceived;
      case 103520001:
        return InvestmentStatus.paymentFinalized;
      case 103520002:
        return InvestmentStatus.partiallyRefunded;
      case 103520003:
        return InvestmentStatus.waitingCancel;
      case 103520004:
        return InvestmentStatus.waitingRefund;
      case 103520012:
        return InvestmentStatus.shareDistributed;
      case 103520013:
        return InvestmentStatus.waitingRemainingPayment;
      case 2:
        return InvestmentStatus.canceled;
      case 103520005:
        return InvestmentStatus.refunded;
      case 103520006:
        return InvestmentStatus.noPaymentMade;
      case 103520007:
        return InvestmentStatus.paymentFailed;
      case 103520009:
        return InvestmentStatus.notSentToTakasbank;
      case 103520010:
        return InvestmentStatus.underPayment;
      case 103520011:
        return InvestmentStatus.takasbankBadRequest;
      case 103520017:
        return InvestmentStatus.waitingExcessFundRefund;
      default:
        return InvestmentStatus.unknown;
    }
  }

  static InvestmentType findInvestmentTypeByCode(int code) {
    switch (code) {
      case 100:
        return InvestmentType.CreditCard;
      case 200:
        return InvestmentType.Eft;
      default:
        return InvestmentType.unknown;
    }
  }

  static FinancialType findFinancialTypeByCode(int code) {
    switch (code) {
      case 10:
        return FinancialType.income;
      case 20:
        return FinancialType.balance;
      default:
        return FinancialType.unknown;
    }
  }

  static CollateralStructure findCollateralStructureByCode(int code) {
    switch (code) {
      case 100:
        return CollateralStructure.RealEstate;
      default:
        return CollateralStructure.unknown;
    }
  }

  static String localizedCollateralStructure(CollateralStructure data) {
    String text = "";
    switch (data) {
      case CollateralStructure.RealEstate:
        text = LocalizationKeys.collateralStructureRealEstateTextKey.tr;
        break;
      default:
    }
    return text;
  }

  static Period findPeriodByCode(int code) {
    switch (code) {
      case 100:
        return Period.Annual;
      case 200:
        return Period.Monthly;
      default:
        return Period.unknown;
    }
  }

  static String localizedPeriod(Period? data) {
    String text = "";
    switch (data) {
      case Period.Annual:
        text = LocalizationKeys.periodAnnualyTextKey.tr;
        break;
      case Period.Monthly:
        text = LocalizationKeys.periodMonthlyTextKey.tr;
        break;

      default:
    }
    return text;
  }

  static RiskType findRiskType(double value) {
    if (value < 33.3) {
      return RiskType.risky;
    } else if (value < 66.6) {
      return RiskType.neutral;
    } else {
      return RiskType.profitable;
    }
  }
}
