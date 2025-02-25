class MasterDataModel {
  final List<Country> countries;
  final List<Industry> industries;
  final List<Profession> professions;
  final List<EducationLevel> educationLevels;
  final List<MemberType> memberTypes;
  final List<AddressType> addressTypes;
  final List<Gender> genders;
  final List<BusinessModel> businessModel;
  final List<Category> categories;
  final List<StaticContent> staticContents;
  final List<SocialMedia> socialMedias;
  final List<TermCode> termCodes;
  final List<PeriodCode> periodCodes;
  final List<CollateralStructureType> collateralStructureType;
  final Region region;
  final PlatformInformation platformInformation;
  final bool showPartners;
  final bool showServices;

  MasterDataModel({
    required this.countries,
    required this.industries,
    required this.professions,
    required this.educationLevels,
    required this.memberTypes,
    required this.addressTypes,
    required this.genders,
    required this.businessModel,
    required this.categories,
    required this.staticContents,
    required this.socialMedias,
    required this.termCodes,
    required this.periodCodes,
    required this.collateralStructureType,
    required this.region,
    required this.platformInformation,
    required this.showPartners,
    required this.showServices,
  });

  factory MasterDataModel.fromJson(Map<String, dynamic> json) {
    return MasterDataModel(
      countries: List<Country>.from(json['countries'].map((x) => Country.fromJson(x))),
      industries: List<Industry>.from(json['industries'].map((x) => Industry.fromJson(x))),
      professions: List<Profession>.from(json['professions'].map((x) => Profession.fromJson(x))),
      educationLevels:
          List<EducationLevel>.from(json['educationLevels'].map((x) => EducationLevel.fromJson(x))),
      memberTypes: List<MemberType>.from(json['memberTypes'].map((x) => MemberType.fromJson(x))),
      addressTypes:
          List<AddressType>.from(json['addressTypes'].map((x) => AddressType.fromJson(x))),
      genders: List<Gender>.from(json['genders'].map((x) => Gender.fromJson(x))),
      businessModel:
          List<BusinessModel>.from(json['businessModel'].map((x) => BusinessModel.fromJson(x))),
      categories: List<Category>.from(json['categories'].map((x) => Category.fromJson(x))),
      staticContents:
          List<StaticContent>.from(json['staticContents'].map((x) => StaticContent.fromJson(x))),
      socialMedias:
          List<SocialMedia>.from(json['socialMedias'].map((x) => SocialMedia.fromJson(x))),
      termCodes: List<TermCode>.from(json['termCodes'].map((x) => TermCode.fromJson(x))),
      periodCodes: List<PeriodCode>.from(json['periodCodes'].map((x) => PeriodCode.fromJson(x))),
      collateralStructureType: List<CollateralStructureType>.from(
          json['collateralStructureType'].map((x) => CollateralStructureType.fromJson(x))),
      region: Region.fromJson(json['region']),
      platformInformation: PlatformInformation.fromJson(json['platformInformation']),
      showPartners: json['showPartners'],
      showServices: json['showServices'],
    );
  }
}

class AddressType {
  final String key;
  final String value;

  AddressType({
    required this.key,
    required this.value,
  });

  factory AddressType.fromJson(Map<String, dynamic> json) => AddressType(
        key: json["key"],
        value: json["value"],
      );
}

class BusinessModel {
  final String key;
  final String value;

  BusinessModel({
    required this.key,
    required this.value,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) => BusinessModel(
        key: json["key"],
        value: json["value"],
      );
}

class Category {
  final String key;
  final String value;

  Category({
    required this.key,
    required this.value,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        key: json["key"],
        value: json["value"],
      );
}

class CollateralStructureType {
  final String key;
  final String value;

  CollateralStructureType({
    required this.key,
    required this.value,
  });

  factory CollateralStructureType.fromJson(Map<String, dynamic> json) => CollateralStructureType(
        key: json["key"],
        value: json["value"],
      );
}

class Country {
  final String key;
  final String value;

  Country({
    required this.key,
    required this.value,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        key: json["key"],
        value: json["value"],
      );
}

class EducationLevel {
  final String key;
  final String value;

  EducationLevel({
    required this.key,
    required this.value,
  });

  factory EducationLevel.fromJson(Map<String, dynamic> json) => EducationLevel(
        key: json["key"],
        value: json["value"],
      );
}

class Gender {
  final String key;
  final String value;

  Gender({
    required this.key,
    required this.value,
  });

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        key: json["key"],
        value: json["value"],
      );
}

class Industry {
  final String key;
  final String value;

  Industry({
    required this.key,
    required this.value,
  });

  factory Industry.fromJson(Map<String, dynamic> json) => Industry(
        key: json["key"],
        value: json["value"],
      );
}

class MemberType {
  final String key;
  final String value;

  MemberType({
    required this.key,
    required this.value,
  });

  factory MemberType.fromJson(Map<String, dynamic> json) => MemberType(
        key: json["key"],
        value: json["value"],
      );
}

class PeriodCode {
  final String key;
  final String value;

  PeriodCode({
    required this.key,
    required this.value,
  });

  factory PeriodCode.fromJson(Map<String, dynamic> json) => PeriodCode(
        key: json["key"],
        value: json["value"],
      );
}

class PlatformInformation {
  final String platformName;
  final String platformSlogan;
  final String platformBrowserTitle;
  final String platformLogoUrl;
  final String faviconUrl;
  final String platformParentOrganizationLogoUrl;
  final dynamic platformParentOrganizationUrl;
  final String investmentInformationDescription;
  final String investmentLimitDescription;
  final int videoMaxSize;
  final int navBarType;
  final String playStoreUrl;
  final String appStoreUrl;
  final String mersisNo;
  final String tradeRegistryNumber;
  final bool isIncomeStatementRequired;
  final bool collateralStructureShow;
  final bool investorMkkRegistirationNoShow;
  final bool projectLogoShow;

  PlatformInformation({
    required this.platformName,
    required this.platformSlogan,
    required this.platformBrowserTitle,
    required this.platformLogoUrl,
    required this.faviconUrl,
    required this.platformParentOrganizationLogoUrl,
    required this.platformParentOrganizationUrl,
    required this.investmentInformationDescription,
    required this.investmentLimitDescription,
    required this.videoMaxSize,
    required this.navBarType,
    required this.playStoreUrl,
    required this.appStoreUrl,
    required this.mersisNo,
    required this.tradeRegistryNumber,
    required this.isIncomeStatementRequired,
    required this.collateralStructureShow,
    required this.investorMkkRegistirationNoShow,
    required this.projectLogoShow,
  });

  factory PlatformInformation.fromJson(Map<String, dynamic> json) => PlatformInformation(
        platformName: json["platformName"],
        platformSlogan: json["platformSlogan"],
        platformBrowserTitle: json["platformBrowserTitle"],
        platformLogoUrl: json["platformLogoUrl"],
        faviconUrl: json["faviconUrl"],
        platformParentOrganizationLogoUrl: json["platformParentOrganizationLogoUrl"],
        platformParentOrganizationUrl: json["platformParentOrganizationUrl"],
        investmentInformationDescription: json["investmentInformationDescription"],
        investmentLimitDescription: json["investmentLimitDescription"],
        videoMaxSize: json["videoMaxSize"],
        navBarType: json["navBarType"],
        playStoreUrl: json["playStoreUrl"],
        appStoreUrl: json["appStoreUrl"],
        mersisNo: json["mersisNo"],
        tradeRegistryNumber: json["tradeRegistryNumber"],
        isIncomeStatementRequired: json["isIncomeStatementRequired"],
        collateralStructureShow: json["collateralStructureShow"],
        investorMkkRegistirationNoShow: json["investorMkkRegistirationNoShow"],
        projectLogoShow: json["projectLogoShow"],
      );
}

class Profession {
  final String key;
  final String value;

  Profession({
    required this.key,
    required this.value,
  });

  factory Profession.fromJson(Map<String, dynamic> json) => Profession(
        key: json["key"],
        value: json["value"],
      );
}

class Region {
  final String name;
  final String dialCode;
  final int offset;
  final String dateFormat;
  final String timeFormat;

  Region({
    required this.name,
    required this.dialCode,
    required this.offset,
    required this.dateFormat,
    required this.timeFormat,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        name: json["name"],
        dialCode: json["dialCode"],
        offset: json["offset"],
        dateFormat: json["dateFormat"],
        timeFormat: json["timeFormat"],
      );
}

class SocialMedia {
  final String key;
  final String value;

  SocialMedia({
    required this.key,
    required this.value,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
        key: json["key"],
        value: json["value"],
      );
}

class StaticContent {
  final String id;
  final dynamic otherContentType;
  final String seoName;
  final String title;
  final String contentType;

  StaticContent({
    required this.id,
    required this.otherContentType,
    required this.seoName,
    required this.title,
    required this.contentType,
  });

  factory StaticContent.fromJson(Map<String, dynamic> json) => StaticContent(
        id: json["id"],
        otherContentType: json["otherContentType"],
        seoName: json["seoName"],
        title: json["title"],
        contentType: json["contentType"],
      );
}

class TermCode {
  final String key;
  final String value;

  TermCode({
    required this.key,
    required this.value,
  });

  factory TermCode.fromJson(Map<String, dynamic> json) => TermCode(
        key: json["key"],
        value: json["value"],
      );
}
