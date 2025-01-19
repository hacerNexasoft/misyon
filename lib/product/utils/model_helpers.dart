import 'package:common/common.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';

class ModelHelpers {
  static ProjectStatus findStatusByCode(int code) {
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
