import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:misyonbank/product/constants/asset_constants.dart';
import 'package:misyonbank/product/models/details_message_model.dart';
import 'package:misyonbank/product/models/project_details_model.dart';
import 'package:misyonbank/product/models/investment_model.dart';
import 'package:misyonbank/product/models/project_model.dart';
import 'package:misyonbank/product/models/widget_models/community_item_model.dart';
import 'package:misyonbank/product/models/widget_models/investments_item_model.dart';
import 'package:misyonbank/product/services/fetcher_static_service.dart';
import 'package:misyonbank/product/utils/extensions.dart';

class ProjectService extends BaseGetxService {
  final isAllFetched = false.obs;
  // API'den gelen projeler
  final projectsList = <ProjectModel>[].obs;
  final activeProjects = <ProjectModel>[].obs;
  final upcomingProjects = <ProjectModel>[].obs;

  //Eski değişkenler
  final openInvestmentsOpportunities = <InvestmentModel>[].obs;
  final preOrderCollectors = <InvestmentModel>[].obs;
  final upcomingCollectors = <InvestmentModel>[].obs;
  final completedCollectors = <InvestmentModel?>[].obs;
  final communityList = <CommunityItemModel?>[].obs;
  final buyProjects = <InvestmentModel>[].obs;
  final sellProjects = <InvestmentModel?>[].obs;
  final fetchAllInvestmentsOpportunitiesList = <InvestmentModel?>[].obs;
  final projectDetail = Rx<ProjectDetailModel?>(null);
  final projectDetailitemList = <ProjectDetailModel?>[].obs;
  final detailMessage = Rx<DetailsMessageModel?>(null);
  final detailManagerMessage = Rx<DetailsManegerMessageModel?>(null);
  final realizedTransactionList = <InvestmentModel?>[].obs;
  final pendingTransactionList = <InvestmentModel?>[].obs;
  final canceldTransactionList = <InvestmentModel?>[].obs;
  final investmentsItemList = <InvestmentsItemModel?>[].obs;

  @override
  void onInit() async {
    super.onInit();
    // Projeleri çekme işlemini başlat
    await fetchProjects();

    //Dummy Data Methods
    activeProjectsDummy();
    //Olds
    await fetchOpenInvestmentsOpportunities();
    await fetchBuyProjects();
    await fetchPreOrderCollectors();
    await fetchUpComingCollectors();
    await fetchCompletedCollectors();
    await fetchCommunityInvestment();
    await fetchAllInvestmentsOpportunities();
    await fetchMyInvestments();
    //------------
    isAllFetched.value = true;
  }

  // Projeleri API'den çek
  Future<void> fetchProjects() async {
    try {
      // Örnek bir istek modeli oluştur
      /* ProjectsModel requestModel = ProjectsModel(
        stateFilters: [0], // Örnek filtreler
        categories: ["00000000-0000-0000-0000-000000000000"],
        cities: ["00000000-0000-0000-0000-000000000000"],
        pageInfo: PageInfo(pageNumber: 0, count: 0),
      );*/

      // Servisi çağır ve listeyi güncelle
      projectsList.value = await FetcherStaticService
          .fetchFilteredProjects(); // Listeyi güncelle

      if (kDebugMode) {
        print('Çekilen Projeler: ${projectsList.length}');
      }
      filterProjectsByStatus();
    } catch (e) {
      if (kDebugMode) {
        print('Proje Çekme Hatası: $e');
      }
    }
  }

  void filterProjectsByStatus() {
    if (projectsList.isEmpty) return;

    activeProjects.value = projectsList
        .toList()
        .where(
          (element) =>
              element.status == ProjectStatus.activeFunding ||
              element.status == ProjectStatus.activeFundingStopped,
        )
        .toList();

    upcomingProjects.value = projectsList
        .toList()
        .where(
          (element) =>
              element.status == ProjectStatus.upcomingPreview ||
              element.status == ProjectStatus.upcomingPrerelease ||
              element.status == ProjectStatus.upcomingDetailedPrerelease,
        )
        .toList();
  }

//-----------DUMMY DATA--------------------------

  void activeProjectsDummy() {
    activeProjects.value = [
      ProjectModel(
          id: UniqueKey().toString(),
          category: "Fintek",
          city: "Aksaray",
          coverImage:
              'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
          fundedAmount: 10,
          fundingGoal: 10000.5,
          fundingPercentage: 0.000999,
          logoUrl:
              'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
          numberOfInvestors: 1,
          projectEndDate: (DateTime.now().add(const Duration(days: 5)))
              .millisecondsSinceEpoch,
          projectStartDate: 1722870000,
          shortDescription:
              "FinStream, finansal verilerinizi gerçek zamanlı olarak takip eden ve analiz eden modern bir platformdur. Anlık bilgiler, kişiselleştirilmiş tavsiyeler ve sorunsuz entegrasyon ile finansal yönetiminizi kolaylaştırır. Yatırım kararlarınızı optimize etmek için FinStream'i tercih edin.",
          statusCode: 0,
          status: ProjectStatus.activeFundingStopped,
          timeUntilEnd: -146423,
          timeUntilStart: -233003,
          title: "FinStream",
          externalId: "54",
          seoName: "finnstream",
          isClickable: true,
          isFavorite: false,
          termCode: 36,
          period: Period.Monthly,
          periodCode: 200,
          yearlyReturnRate: 50,
          collateralStructure: CollateralStructure.RealEstate,
          riskForDebit: RiskType.risky),
      ProjectModel(
          id: UniqueKey().toString(),
          category: 'Mionti Enerji',
          city: "Aksaray",
          coverImage:
              'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
          fundedAmount: 10,
          fundingGoal: 10000.5,
          fundingPercentage: 0.000999,
          logoUrl:
              'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSPhPks6T4vFjVTSIVjEPQ__8WAnDE8zUwWdH-0D7C-ym8w9Ql0',
          numberOfInvestors: 1,
          projectEndDate: (DateTime.now().add(const Duration(hours: 3)))
              .millisecondsSinceEpoch,
          projectStartDate: 1722870000,
          shortDescription:
              "FinStream, finansal verilerinizi gerçek zamanlı olarak takip eden ve analiz eden modern bir platformdur. Anlık bilgiler, kişiselleştirilmiş tavsiyeler ve sorunsuz entegrasyon ile finansal yönetiminizi kolaylaştırır. Yatırım kararlarınızı optimize etmek için FinStream'i tercih edin.",
          statusCode: 0,
          status: ProjectStatus.activeFunding,
          timeUntilEnd: -146423,
          timeUntilStart: -233003,
          title: 'Mionti Enerji',
          externalId: "54",
          seoName: 'Mionti Enerji',
          isClickable: true,
          isFavorite: false,
          termCode: 48,
          period: Period.Annual,
          periodCode: 200,
          yearlyReturnRate: 50,
          collateralStructure: CollateralStructure.RealEstate,
          riskForDebit: RiskType.neutral),
    ];
  }

  Future<void> fetchMyInvestments() async {
    try {
      investmentsItemList.value = [
        InvestmentsItemModel(
          id: '1',
          companyId: '1',
          companyName: 'Mionti Enerji',
          imageUrl:
              "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp",
          statusName:
              MyInvestmentsProcess.openInvestment.investmentProcessString,
          totalInvestmentAmount: 10000.0,
          label: "Label",
          labelAmount: 20000.0,
          maturityDate: DateTime(2024, 6, 15),
          rateOfReturn: 55,
          monthlyReturnAmount: 1200.00,
          timeRemainingUntilReturn: 5,
          lastPrice: 5000.0,
          currentEarnings: 6000.00,
          pendingEarnings: 30000.00,
          frequencyOfReturn: 'Yıllık',
          totalPendingEarnings: 36000.00,
        ),
        InvestmentsItemModel(
          id: '2',
          companyId: '2',
          companyName: 'Meta 3D Company',
          imageUrl:
              "https://media.licdn.com/dms/image/v2/C560BAQFbFzE-ZoYcPg/company-logo_100_100/company-logo_100_100/0/1678829913371/meta3d_company_logo?e=2147483647&v=beta&t=oswesD8M2g0TLUUwSrQtrouaLvPkY8ETw7_MMlfd_Zc",
          statusName: MyInvestmentsProcess.returnPeriod.investmentProcessString,
          totalInvestmentAmount: 18600.0,
          rateOfReturnDescription: "3/12",
          label: "Label",
          labelAmount: 3600.0,
          maturityDate: DateTime(2024, 9, 20),
          rateOfReturn: 30,
          frequencyOfReturn: 'Yıllık',
          monthlyReturnAmount: 1200.00,
          timeRemainingUntilReturn: 6,
          lastPrice: 5000.0,
          currentEarnings: 6000.00,
          pendingEarnings: 30000.00,
          totalPendingEarnings: 36000.00,
        ),
        InvestmentsItemModel(
          id: '3',
          companyId: '3',
          companyName: 'melda io',
          imageUrl:
              "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSPhPks6T4vFjVTSIVjEPQ__8WAnDE8zUwWdH-0D7C-ym8w9Ql0",
          statusName: MyInvestmentsProcess.returnPeriod.investmentProcessString,
          rateOfReturnDescription: "2/12",
          totalInvestmentAmount: 25000.0,
          label: "Label",
          labelAmount: 1200.0,
          frequencyOfReturn: 'Yıllık',
          maturityDate: DateTime(2024, 11, 30),
          rateOfReturn: 13,
          monthlyReturnAmount: 1200.00,
          timeRemainingUntilReturn: 7,
          lastPrice: 5000.0,
          currentEarnings: 6000.00,
          pendingEarnings: 30000.00,
          totalPendingEarnings: 36000.00,
        ),
      ];
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> fetchOpenInvestmentsOpportunities() async {
    try {
      openInvestmentsOpportunities.value = [
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Mionti Enerji',
            backimage:
                'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            shortDesc: 'Araç şarj istasyon ağı',
            earningFrequency: 'Aylık',
            term: 6,
            earningRate: 60,
            rate: 46,
            favoriteCount: 46,
            completedTargetRate: 30,
            categories: const ['Enerji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.neutral,
            status: ProjectStatus.activeFunding),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'melda io',
            backimage:
                'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            imageUrl:
                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSPhPks6T4vFjVTSIVjEPQ__8WAnDE8zUwWdH-0D7C-ym8w9Ql0',
            shortDesc: 'Yeni nesil data analizi & LMS platformu',
            earningFrequency: 'Aylık',
            term: 12,
            earningRate: 70,
            rate: 14,
            favoriteCount: 76,
            completedTargetRate: 10,
            categories: const ['Teknoloji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.profitable,
            status: ProjectStatus.activeFunding),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Mionti Enerji',
            backimage:
                'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            shortDesc: 'Araç şarj istasyon ağı',
            earningFrequency: 'Aylık',
            term: 6,
            earningRate: 60,
            rate: 46,
            favoriteCount: 46,
            completedTargetRate: 30,
            categories: const ['Enerji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.risky,
            status: ProjectStatus.activeFunding),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'melda io',
            backimage:
                'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            imageUrl:
                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSPhPks6T4vFjVTSIVjEPQ__8WAnDE8zUwWdH-0D7C-ym8w9Ql0',
            shortDesc: 'Yeni nesil data analizi & LMS platformu',
            earningFrequency: 'Aylık',
            term: 12,
            earningRate: 70,
            rate: 14,
            favoriteCount: 76,
            completedTargetRate: 10,
            categories: const ['Teknoloji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.profitable,
            status: ProjectStatus.activeFunding),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Mionti Enerji',
            backimage:
                'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            shortDesc: 'Araç şarj istasyon ağı',
            earningFrequency: 'Aylık',
            term: 6,
            earningRate: 60,
            rate: 46,
            favoriteCount: 46,
            completedTargetRate: 30,
            categories: const ['Enerji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.risky,
            status: ProjectStatus.activeFunding),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'melda io',
            backimage:
                'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            imageUrl:
                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSPhPks6T4vFjVTSIVjEPQ__8WAnDE8zUwWdH-0D7C-ym8w9Ql0',
            shortDesc: 'Yeni nesil data analizi & LMS platformu',
            earningFrequency: 'Aylık',
            term: 12,
            earningRate: 70,
            rate: 14,
            favoriteCount: 76,
            completedTargetRate: 10,
            categories: const ['Teknoloji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.profitable,
            status: ProjectStatus.activeFunding),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Mionti Enerji',
            backimage:
                'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            shortDesc: 'Araç şarj istasyon ağı',
            earningFrequency: 'Aylık',
            term: 6,
            earningRate: 60,
            rate: 46,
            favoriteCount: 46,
            completedTargetRate: 30,
            categories: const ['Enerji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.risky,
            status: ProjectStatus.activeFunding),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'melda io',
            backimage:
                'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            imageUrl:
                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSPhPks6T4vFjVTSIVjEPQ__8WAnDE8zUwWdH-0D7C-ym8w9Ql0',
            shortDesc: 'Yeni nesil data analizi & LMS platformu',
            earningFrequency: 'Aylık',
            term: 12,
            earningRate: 70,
            rate: 14,
            favoriteCount: 76,
            completedTargetRate: 10,
            categories: const ['Teknoloji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.profitable,
            status: ProjectStatus.activeFunding),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Mionti Enerji',
            backimage:
                'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            shortDesc: 'Araç şarj istasyon ağı',
            earningFrequency: 'Aylık',
            term: 6,
            earningRate: 60,
            rate: 46,
            favoriteCount: 46,
            completedTargetRate: 30,
            categories: const ['Enerji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.risky,
            status: ProjectStatus.activeFunding),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'melda io',
            backimage:
                'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            imageUrl:
                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSPhPks6T4vFjVTSIVjEPQ__8WAnDE8zUwWdH-0D7C-ym8w9Ql0',
            shortDesc: 'Yeni nesil data analizi & LMS platformu',
            earningFrequency: 'Aylık',
            term: 12,
            earningRate: 70,
            rate: 14,
            favoriteCount: 76,
            completedTargetRate: 10,
            categories: const ['Teknoloji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.profitable,
            status: ProjectStatus.activeFunding),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Mionti Enerji',
            backimage:
                'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            shortDesc: 'Araç şarj istasyon ağı',
            earningFrequency: 'Aylık',
            term: 6,
            earningRate: 60,
            rate: 46,
            favoriteCount: 46,
            completedTargetRate: 30,
            categories: const ['Enerji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.risky,
            status: ProjectStatus.activeFunding),
      ];
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> fetchAllInvestmentsOpportunities() async {
    try {
      fetchAllInvestmentsOpportunitiesList.value = [
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Mionti Enerji',
            backimage:
                'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            shortDesc: 'Araç şarj istasyon ağı',
            earningFrequency: 'Aylık',
            term: 12,
            earningRate: 55,
            rate: 46,
            favoriteCount: 46,
            completedTargetRate: 30,
            riskType: RiskType.neutral,
            categories: const ['Teknoloji', 'Yazılım'],
            startDate: '23 Temmuz 2024',
            investmentStatus: InvestmentStatus.openInvestments,
            status: ProjectStatus.successful),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'melda io',
            backimage:
                'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            imageUrl:
                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSPhPks6T4vFjVTSIVjEPQ__8WAnDE8zUwWdH-0D7C-ym8w9Ql0',
            shortDesc: 'Yeni nesil data analizi & LMS platformu',
            earningFrequency: 'Yıllık',
            term: 4,
            earningRate: 12,
            rate: 14,
            favoriteCount: 76,
            categories: const ['Teknoloji', 'Yazılım'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.neutral,
            investmentStatus: InvestmentStatus.preRequest,
            status: ProjectStatus.activeFunding),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Mionti Enerji',
            backimage:
                'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            shortDesc: 'Araç şarj istasyon ağı',
            earningFrequency: 'Aylık',
            earningRate: 55,
            rate: 46,
            favoriteCount: 46,
            completedTargetRate: 30,
            riskType: RiskType.risky,
            categories: const ['Teknoloji', 'Yazılım'],
            startDate: '23 Temmuz 2024',
            investmentStatus: InvestmentStatus.reachedTarget,
            status: ProjectStatus.upcomingPreview),
      ];
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> fetchPreOrderCollectors() async {
    try {
      preOrderCollectors.value = [
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Tunga Soft',
            backimage: AssetConstants.tunga,
            imageUrl:
                'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTWL6JqVuWQDs0_23XEC3r92fgNFsZu9O4MQGxxUfV46PsaWp4p',
            shortDesc: 'Eğitici online mobil platform oyunu',
            earningFrequency: 'Yıllık',
            favoriteCount: 22,
            earningRate: 12,
            rate: 14,
            riskType: RiskType.neutral,
            categories: const ['Teknoloji', 'Gayrimenkul'],
            status: ProjectStatus.activeFunding),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Tunga Soft',
            backimage: AssetConstants.tunga,
            imageUrl:
                'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTWL6JqVuWQDs0_23XEC3r92fgNFsZu9O4MQGxxUfV46PsaWp4p',
            shortDesc: 'Eğitici online mobil platform oyunu',
            earningFrequency: 'Yıllık',
            favoriteCount: 22,
            earningRate: 12,
            rate: 14,
            riskType: RiskType.neutral,
            categories: const ['Teknoloji', 'Gayrimenkul'],
            status: ProjectStatus.activeFunding),
        InvestmentModel(
            id: UniqueKey().toString(),
            backimage: AssetConstants.tunga,
            ownerName: 'Tunga Soft',
            imageUrl:
                'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTWL6JqVuWQDs0_23XEC3r92fgNFsZu9O4MQGxxUfV46PsaWp4p',
            shortDesc: 'Eğitici online mobil platform oyunu',
            earningFrequency: 'Yıllık',
            favoriteCount: 22,
            earningRate: 12,
            rate: 14,
            riskType: RiskType.neutral,
            categories: const ['Teknoloji', 'Gayrimenkul'],
            status: ProjectStatus.activeFunding),
      ];
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> fetchUpComingCollectors() async {
    try {
      upcomingCollectors.value = [
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Meta 3D Company',
            backimage: AssetConstants.meta3D,
            imageUrl:
                "https://media.licdn.com/dms/image/v2/C560BAQFbFzE-ZoYcPg/company-logo_100_100/company-logo_100_100/0/1678829913371/meta3d_company_logo?e=2147483647&v=beta&t=oswesD8M2g0TLUUwSrQtrouaLvPkY8ETw7_MMlfd_Zc",
            shortDesc: '3D baskı teknolojileri',
            earningFrequency: 'Yıllık',
            favoriteCount: 22,
            earningRate: 39,
            startDate: '23 Aralık 2024',
            rate: 14,
            riskType: RiskType.neutral,
            categories: const ['Yapay Zeka', 'Gayrimenkul'],
            status: ProjectStatus.activeFundingStopped),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Meta 3D Company',
            backimage: AssetConstants.meta3D,
            imageUrl:
                "https://media.licdn.com/dms/image/v2/C560BAQFbFzE-ZoYcPg/company-logo_100_100/company-logo_100_100/0/1678829913371/meta3d_company_logo?e=2147483647&v=beta&t=oswesD8M2g0TLUUwSrQtrouaLvPkY8ETw7_MMlfd_Zc",
            shortDesc: '3D baskı teknolojileri',
            earningFrequency: 'Yıllık',
            favoriteCount: 22,
            earningRate: 39,
            startDate: '23 Aralık 2024',
            rate: 14,
            riskType: RiskType.neutral,
            categories: const ['Yapay Zeka', 'Gayrimenkul'],
            status: ProjectStatus.activeFundingStopped),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Meta 3D Company',
            backimage: AssetConstants.meta3D,
            imageUrl:
                "https://media.licdn.com/dms/image/v2/C560BAQFbFzE-ZoYcPg/company-logo_100_100/company-logo_100_100/0/1678829913371/meta3d_company_logo?e=2147483647&v=beta&t=oswesD8M2g0TLUUwSrQtrouaLvPkY8ETw7_MMlfd_Zc",
            shortDesc: '3D baskı teknolojileri',
            earningFrequency: 'Yıllık',
            favoriteCount: 22,
            earningRate: 39,
            startDate: '23 Aralık 2024',
            rate: 14,
            riskType: RiskType.neutral,
            categories: const ['Yapay Zeka', 'Gayrimenkul'],
            status: ProjectStatus.activeFundingStopped),
      ];
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> fetchCompletedCollectors() async {
    try {
      completedCollectors.value = [
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Agro Hub',
            imageUrl:
                'https://startupmarket.co/cache/100x100/upload/images/startup/61aa4c8e3009c245357561.jpg',
            shortDesc: 'Yeniden kullanılabilir solunum cihazı 1',
            completedAmount: '1.6 Milyon TL',
            completedTargetRate: 120,
            status: ProjectStatus.upcomingPreview),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Agro Hub',
            imageUrl:
                'https://startupmarket.co/cache/100x100/upload/images/startup/61aa4c8e3009c245357561.jpg',
            shortDesc: 'Yeniden kullanılabilir solunum cihazı 2',
            completedAmount: '1.6 Milyon TL',
            completedTargetRate: 120,
            status: ProjectStatus.upcomingPreview),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Agro Hub',
            imageUrl:
                'https://startupmarket.co/cache/100x100/upload/images/startup/61aa4c8e3009c245357561.jpg',
            shortDesc: 'Yeniden kullanılabilir solunum cihazı 3',
            completedAmount: '1.6 Milyon TL',
            completedTargetRate: 120,
            status: ProjectStatus.upcomingPreview),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Agro Hub',
            imageUrl:
                'https://startupmarket.co/cache/100x100/upload/images/startup/61aa4c8e3009c245357561.jpg',
            shortDesc: 'Yeniden kullanılabilir solunum cihazı 1',
            completedAmount: '1.6 Milyon TL',
            completedTargetRate: 120,
            status: ProjectStatus.upcomingPreview),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Agro Hub',
            imageUrl:
                'https://startupmarket.co/cache/100x100/upload/images/startup/61aa4c8e3009c245357561.jpg',
            shortDesc: 'Yeniden kullanılabilir solunum cihazı 2',
            completedAmount: '1.6 Milyon TL',
            completedTargetRate: 120,
            status: ProjectStatus.upcomingPreview),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Agro Hub',
            imageUrl:
                'https://startupmarket.co/cache/100x100/upload/images/startup/61aa4c8e3009c245357561.jpg',
            shortDesc: 'Yeniden kullanılabilir solunum cihazı 3',
            completedAmount: '1.6 Milyon TL',
            completedTargetRate: 120,
            status: ProjectStatus.upcomingPreview),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Agro Hub',
            imageUrl:
                'https://startupmarket.co/cache/100x100/upload/images/startup/61aa4c8e3009c245357561.jpg',
            shortDesc: 'Yeniden kullanılabilir solunum cihazı 1',
            completedAmount: '1.6 Milyon TL',
            completedTargetRate: 120,
            status: ProjectStatus.upcomingPreview),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Agro Hub',
            imageUrl:
                'https://startupmarket.co/cache/100x100/upload/images/startup/61aa4c8e3009c245357561.jpg',
            shortDesc: 'Yeniden kullanılabilir solunum cihazı 2',
            completedAmount: '1.6 Milyon TL',
            completedTargetRate: 120,
            status: ProjectStatus.upcomingPreview),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Agro Hub',
            imageUrl:
                'https://startupmarket.co/cache/100x100/upload/images/startup/61aa4c8e3009c245357561.jpg',
            shortDesc: 'Yeniden kullanılabilir solunum cihazı 3',
            completedAmount: '1.6 Milyon TL',
            completedTargetRate: 120,
            status: ProjectStatus.upcomingPreview),
      ];
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> fetchCommunityInvestment() async {
    try {
      communityList.value = [
        CommunityItemModel(
            id: UniqueKey().toString(),
            backimage: const [
              'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
              'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
              'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
              'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
              'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            ],
            projectName: 'melda io',
            imageUrl:
                'https://pbs.twimg.com/profile_images/1115525752533942272/HXbYTLAl_400x400.png',
            ceo: 'Eyşan Öztürk',
            amount: 225000,
            investment: ExploreInvestment.empty,
            minutes: "5dk",
            updates: "Genel Kurul Bilgilendirmesi",
            date: "12.06.2024",
            updatesSubTitle:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
        CommunityItemModel(
            id: UniqueKey().toString(),
            projectName: 'melda io',
            backimage: const [
              'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
              'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
              'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
              'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
              'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            ],
            date: "13.06.2024",
            imageUrl:
                'https://pbs.twimg.com/profile_images/1115525752533942272/HXbYTLAl_400x400.png',
            ceo: 'Eyşan Öztürk',
            amount: 421000,
            investment: ExploreInvestment.firstInvestment,
            minutes: "1s",
            updates: "Ek Getiri İmkanı",
            updatesSubTitle:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
        CommunityItemModel(
            id: UniqueKey().toString(),
            projectName: 'Mionti Enerji',
            backimage: const [
              'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
              'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
              'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
              'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
              'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0'
            ],
            date: "10.06.2024",
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            ceo: 'Eyşan Öztürk',
            amount: 12375000,
            investment: ExploreInvestment.highestInvestment,
            minutes: "2g",
            updates: "Şube Açılışı",
            updatesSubTitle:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
        CommunityItemModel(
            id: UniqueKey().toString(),
            projectName: 'Mionti Enerji',
            date: "12.06.2024",
            backimage: const [
              'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
              'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
              'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
              'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
              'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0'
            ],
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            ceo: 'Eyşan Öztürk',
            amount: 345234567,
            investment: ExploreInvestment.highestInvestment,
            minutes: "1s",
            updates: "Bağımsız Denetim Raporu",
            updatesSubTitle:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
      ];
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> fetchBuyProjects() async {
    try {
      buyProjects.value = [
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Mionti Enerji',
            backimage:
                'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            shortDesc: 'Araç şarj istasyon ağı',
            earningFrequency: 'Aylık',
            term: 12,
            earningRate: 55,
            rate: 46,
            favoriteCount: 46,
            completedTargetRate: 30,
            categories: const ['Enerji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.neutral,
            status: ProjectStatus.successful),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'melda io',
            backimage:
                'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            imageUrl:
                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSPhPks6T4vFjVTSIVjEPQ__8WAnDE8zUwWdH-0D7C-ym8w9Ql0',
            shortDesc: 'Yeni nesil data analizi & LMS platformu',
            earningFrequency: 'Aylık',
            term: 12,
            earningRate: 70,
            rate: 14,
            favoriteCount: 76,
            completedTargetRate: 10,
            categories: const ['Teknoloji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.profitable,
            status: ProjectStatus.successful),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Mionti Enerji',
            backimage:
                'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            shortDesc: 'Araç şarj istasyon ağı',
            earningFrequency: 'Aylık',
            term: 12,
            earningRate: 55,
            rate: 46,
            favoriteCount: 46,
            completedTargetRate: 30,
            categories: const ['Enerji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.neutral,
            status: ProjectStatus.successful),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'melda io',
            backimage:
                'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            imageUrl:
                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSPhPks6T4vFjVTSIVjEPQ__8WAnDE8zUwWdH-0D7C-ym8w9Ql0',
            shortDesc: 'Yeni nesil data analizi & LMS platformu',
            earningFrequency: 'Aylık',
            term: 12,
            earningRate: 70,
            rate: 14,
            favoriteCount: 76,
            completedTargetRate: 10,
            categories: const ['Teknoloji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.profitable,
            status: ProjectStatus.successful),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'Mionti Enerji',
            backimage:
                'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            shortDesc: 'Araç şarj istasyon ağı',
            earningFrequency: 'Aylık',
            term: 12,
            earningRate: 55,
            rate: 46,
            favoriteCount: 46,
            completedTargetRate: 30,
            categories: const ['Enerji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.neutral,
            status: ProjectStatus.successful),
        InvestmentModel(
            id: UniqueKey().toString(),
            ownerName: 'melda io',
            backimage:
                'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            imageUrl:
                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSPhPks6T4vFjVTSIVjEPQ__8WAnDE8zUwWdH-0D7C-ym8w9Ql0',
            shortDesc: 'Yeni nesil data analizi & LMS platformu',
            earningFrequency: 'Aylık',
            term: 12,
            earningRate: 70,
            rate: 14,
            favoriteCount: 76,
            completedTargetRate: 10,
            categories: const ['Teknoloji', 'Gayrimenkul'],
            startDate: '23 Temmuz 2024',
            riskType: RiskType.profitable,
            status: ProjectStatus.successful)
      ];
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> fetchSellProjects() async {
    try {
      sellProjects.value = [
        InvestmentModel(),
      ];
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> fetchProjectDetails() async {
    try {
      projectDetail.value = ProjectDetailModel(
        id: UniqueKey().toString(),
        title: 'Meta 3D Company',
        subtitle: '3D baskı teknolojiler',
        imageUrl: const [
          AssetConstants.meta3D,
          AssetConstants.meta3D,
          AssetConstants.meta3D,
          AssetConstants.meta3D,
          AssetConstants.meta3D
        ],
        risk: 3,
        tags: const ["Teknoloji", "Yazılım", "Enerji"],
        fundRaised: 3507285.00,
        targetFund: 5000000.00,
        remainingDay: '3 Gün',
        investment: '541',
        completed: '%33',
        maturity: '12 Ay',
        rateofReturn: '%55',
        returnFrequency: 'Aylık',
        companyValue: 'Gayrimenkul',
        valuation: 200000.00,
        minimumInvestmentAmount: 100,
        minimumfundingGoal: 25000.00,
        maxfundingGoal: 3000000.00,
        deadLine: "12 Aralık 2024",
        platformDocuments: const [
          "Bilgi Formu",
          "Yatırım Komitesi Raporu",
          "Kredibilite Raporu"
        ],
        startDate: "26.12.2024",
        stopDate: "21.02.2025",
        finishDate: "23.02.2025",
        lot: "8 TL",
        percent: "%6,54",
        additionalAmount: "1.000.000 TL",
        sharePcs: "700.000",
        additionalFundRate: "%20",
        companyValues: "85.600.000 TL",
        collateralStructure: "Gayeimenkul",
        campaignDocuments: const [
          "Fon Kullanımı Raporu",
          "Sunum",
          "Esas Sözleşme",
          "Finansal Projeksiyon",
          "Bilanço",
          "Gelir Tablosu"
        ],
        teamImageUrl: const [
          "https://people2partner.nl/app/uploads/2023/05/p2p-1.png",
          "https://people2partner.nl/app/uploads/2024/01/Mask-Group-23.png",
          "https://people2partner.nl/app/uploads/2024/01/Mask-Group-22.png",
          "https://people2partner.nl/app/uploads/2023/05/Mask-Group-20.png",
          "https://people2partner.nl/app/uploads/2024/01/Mask-Group-29.png",
          "https://people2partner.nl/app/uploads/2023/05/p2p-4.png"
        ],
        teamName: const [
          "Eyşan Öztürk",
          "Aktuğ Gültürk",
          "Alp Şeker",
          "Ecem Baskı",
          "Eyşan Öztürk",
          "Aktuğ Gültürk"
        ],
        teamsInfo: const ["", "", "", "", "", ""],
        teamrole: const [
          "Takım Lideri",
          "Senior Yazılım Uzmanı",
          "Veri Bilimci",
          "Yazılım Geliştirici",
          "Ortaklar",
          "Ortaklar",
        ],
        companyName: "Mionti Enerji",
        foundationYear: "2022",
        chairman: "Aktuğ Gültürk",
        numberofEmployees: "11 - 50",
        companyAddress: "Beşiktaş/İstanbul",
        problem:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        incomePlan:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        market:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        solution:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        competitorAnalysis:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        additionalReward:
            "Yatırım turumuzun başlama tarihi itibariyle yapılan yatırımlarda yatırımcılara aşağıda belirtilen oranlarda ek getiri verilecektir.20.000 TL - 49.999 TL arasında yatırım yapan kişilere %0,5, 50.000 TL - 99.999 TL arasında yatırım yapan kişilere %1, 100.000 TL ve üzerinde yatırım yapan kişilere %2 ek getiri verilecektir.",
        incomeStatementTitle: const [
          "Esas Faaliyet Karı",
          "Esas Faaliyet Zararı",
          "Ciro",
          "Satışların Maaliyeti",
          "Brüt Kar",
          "Yönetim Giderleri",
          "Faaliyet Karı",
          "Ödenecek Net Faiz",
          "Vergi Öncesi Kar",
          "Vergi",
          "Net Kar"
        ],
        incomeStatementData: const [
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00
        ],
        balanceSheetTitle: const [
          "Bilanço",
          "Duran Varlıklar",
          "Dönen Varlıklar",
          "Kısa Vadeli Yükümlülükler",
          "Uzun Vadeli Yükümlülükler",
          "Net Özsermaye"
        ],
        balanceSheetData: const [
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
        ],
        historyofUpdates: const [
          "23 Aralık",
          "23 Aralık",
          "23 Aralık",
          "23 Aralık",
        ],
        yearsofUpdates: const ["2021", "2021", "2021", "2021"],
        updatesTitle: const [
          "İlk Hedefimize Ulaştık!",
          "İlk Nitelikli Yatırımcı",
          "₺1.500 Fon Toplandı",
          "Proje Başlatıldı"
        ],
        updatesDescription: const [
          "Desteğiniz için teşekkürler 100.000 ₺’lik ilk hedefe ulaştık.\n\nSırada ikincisi var. 150.000 ₺’lik hedefe ulaşmamıza yardımcı olun.Lütfen daha sonra ne görmek istediğinizle ilgili yorumlarınızı ve fikirlerinizi bırakın. Bunu gerçekleştirmeye ve burada güncellemeye çalışacağız.",
          "",
          "",
          ""
        ],
      );
      ProjectDetailModel(
        id: UniqueKey().toString(),
        title: 'melda io',
        subtitle: 'Yeni nesil data analizi & LMS platform',
        imageUrl: const [
          'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
          'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
          'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
          'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
          'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
        ],
        risk: 3,
        tags: const ["Teknoloji", "Yazılım", "Enerji"],
        fundRaised: 3507285.00,
        targetFund: 5000000.00,
        remainingDay: '3 Gün',
        investment: '541',
        completed: '%33',
        maturity: '12 Ay',
        rateofReturn: '%55',
        returnFrequency: 'Aylık',
        companyValue: 'Gayrimenkul',
        valuation: 200000.00,
        minimumInvestmentAmount: 100,
        minimumfundingGoal: 25000.00,
        maxfundingGoal: 3000000.00,
        deadLine: "12 Aralık 2024",
        platformDocuments: const [
          "Bilgi Formu",
          "Yatırım Komitesi Raporu",
          "Kredibilite Raporu"
        ],
        startDate: "26.12.2024",
        stopDate: "21.02.2025",
        finishDate: "23.02.2025",
        lot: "8 TL",
        percent: "%6,54",
        additionalAmount: "1.000.000 TL",
        sharePcs: "700.000",
        additionalFundRate: "%20",
        companyValues: "85.600.000 TL",
        collateralStructure: "Gayeimenkul",
        campaignDocuments: const [
          "Fon Kullanımı Raporu",
          "Sunum",
          "Esas Sözleşme",
          "Finansal Projeksiyon",
          "Bilanço",
          "Gelir Tablosu"
        ],
        teamImageUrl: const [
          "https://people2partner.nl/app/uploads/2023/05/p2p-1.png",
          "https://people2partner.nl/app/uploads/2024/01/Mask-Group-23.png",
          "https://people2partner.nl/app/uploads/2024/01/Mask-Group-22.png",
          "https://people2partner.nl/app/uploads/2023/05/Mask-Group-20.png",
          "https://people2partner.nl/app/uploads/2024/01/Mask-Group-29.png",
          "https://people2partner.nl/app/uploads/2023/05/p2p-4.png"
        ],
        teamName: const [
          "Eyşan Öztürk",
          "Aktuğ Gültürk",
          "Alp Şeker",
          "Ecem Baskı",
          "Eyşan Öztürk",
          "Aktuğ Gültürk"
        ],
        teamsInfo: const ["", "", "", "", "", ""],
        teamrole: const [
          "Takım Lideri",
          "Senior Yazılım Uzmanı",
          "Veri Bilimci",
          "Yazılım Geliştirici",
          "Ortaklar",
          "Ortaklar",
        ],
        companyName: "Mionti Enerji",
        foundationYear: "2022",
        chairman: "Aktuğ Gültürk",
        numberofEmployees: "11 - 50",
        companyAddress: "Beşiktaş/İstanbul",
        problem:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        incomePlan:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        market:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        solution:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        competitorAnalysis:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        additionalReward:
            "Yatırım turumuzun başlama tarihi itibariyle yapılan yatırımlarda yatırımcılara aşağıda belirtilen oranlarda ek getiri verilecektir.20.000 TL - 49.999 TL arasında yatırım yapan kişilere %0,5, 50.000 TL - 99.999 TL arasında yatırım yapan kişilere %1, 100.000 TL ve üzerinde yatırım yapan kişilere %2 ek getiri verilecektir.",
        incomeStatementTitle: const [
          "Esas Faaliyet Karı",
          "Esas Faaliyet Zararı",
          "Ciro",
          "Satışların Maaliyeti",
          "Brüt Kar",
          "Yönetim Giderleri",
          "Faaliyet Karı",
          "Ödenecek Net Faiz",
          "Vergi Öncesi Kar",
          "Vergi",
          "Net Kar"
        ],
        incomeStatementData: const [
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00
        ],
        balanceSheetTitle: const [
          "Bilanço",
          "Duran Varlıklar",
          "Dönen Varlıklar",
          "Kısa Vadeli Yükümlülükler",
          "Uzun Vadeli Yükümlülükler",
          "Net Özsermaye"
        ],
        balanceSheetData: const [
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
        ],
        historyofUpdates: const [
          "23 Aralık",
          "23 Aralık",
          "23 Aralık",
          "23 Aralık",
        ],
        yearsofUpdates: const ["2021", "2021", "2021", "2021"],
        updatesTitle: const [
          "İlk Hedefimize Ulaştık!",
          "İlk Nitelikli Yatırımcı",
          "₺1.500 Fon Toplandı",
          "Proje Başlatıldı"
        ],
        updatesDescription: const [
          "Desteğiniz için teşekkürler 100.000 ₺’lik ilk hedefe ulaştık.\n\nSırada ikincisi var. 150.000 ₺’lik hedefe ulaşmamıza yardımcı olun.Lütfen daha sonra ne görmek istediğinizle ilgili yorumlarınızı ve fikirlerinizi bırakın. Bunu gerçekleştirmeye ve burada güncellemeye çalışacağız.",
          "",
          "",
          ""
        ],
      );
      ProjectDetailModel(
        id: UniqueKey().toString(),
        title: 'Mionti Enerji',
        subtitle: 'Araç şarj istasyon ağı',
        imageUrl: const [
          AssetConstants.canopyPng,
          AssetConstants.canopyPng,
          AssetConstants.canopyPng,
          AssetConstants.canopyPng,
          AssetConstants.canopyPng,
        ],
        risk: 3,
        tags: const ["Teknoloji", "Yazılım", "Enerji"],
        fundRaised: 3507285.00,
        targetFund: 5000000.00,
        remainingDay: '3 Gün',
        investment: '541',
        completed: '%33',
        maturity: '12 Ay',
        rateofReturn: '%55',
        returnFrequency: 'Aylık',
        companyValue: 'Gayrimenkul',
        valuation: 200000.00,
        minimumInvestmentAmount: 100,
        minimumfundingGoal: 25000.00,
        maxfundingGoal: 3000000.00,
        deadLine: "12 Aralık 2024",
        platformDocuments: const [
          "Bilgi Formu",
          "Yatırım Komitesi Raporu",
          "Kredibilite Raporu"
        ],
        startDate: "26.12.2024",
        stopDate: "21.02.2025",
        finishDate: "23.02.2025",
        lot: "8 TL",
        percent: "%6,54",
        additionalAmount: "1.000.000 TL",
        sharePcs: "700.000",
        additionalFundRate: "%20",
        companyValues: "85.600.000 TL",
        collateralStructure: "Gayeimenkul",
        campaignDocuments: const [
          "Fon Kullanımı Raporu",
          "Sunum",
          "Esas Sözleşme",
          "Finansal Projeksiyon",
          "Bilanço",
          "Gelir Tablosu"
        ],
        teamImageUrl: const [
          "https://people2partner.nl/app/uploads/2023/05/p2p-1.png",
          "https://people2partner.nl/app/uploads/2024/01/Mask-Group-23.png",
          "https://people2partner.nl/app/uploads/2024/01/Mask-Group-22.png",
          "https://people2partner.nl/app/uploads/2023/05/Mask-Group-20.png",
          "https://people2partner.nl/app/uploads/2024/01/Mask-Group-29.png",
          "https://people2partner.nl/app/uploads/2023/05/p2p-4.png"
        ],
        teamName: const [
          "Eyşan Öztürk",
          "Aktuğ Gültürk",
          "Alp Şeker",
          "Ecem Baskı",
          "Eyşan Öztürk",
          "Aktuğ Gültürk"
        ],
        teamsInfo: const ["", "", "", "", "", ""],
        teamrole: const [
          "Takım Lideri",
          "Senior Yazılım Uzmanı",
          "Veri Bilimci",
          "Yazılım Geliştirici",
          "Ortaklar",
          "Ortaklar",
        ],
        companyName: "Mionti Enerji",
        foundationYear: "2022",
        chairman: "Aktuğ Gültürk",
        numberofEmployees: "11 - 50",
        companyAddress: "Beşiktaş/İstanbul",
        problem:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        incomePlan:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        market:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        solution:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        competitorAnalysis:
            "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
        additionalReward:
            "Yatırım turumuzun başlama tarihi itibariyle yapılan yatırımlarda yatırımcılara aşağıda belirtilen oranlarda ek getiri verilecektir.20.000 TL - 49.999 TL arasında yatırım yapan kişilere %0,5, 50.000 TL - 99.999 TL arasında yatırım yapan kişilere %1, 100.000 TL ve üzerinde yatırım yapan kişilere %2 ek getiri verilecektir.",
        incomeStatementTitle: const [
          "Esas Faaliyet Karı",
          "Esas Faaliyet Zararı",
          "Ciro",
          "Satışların Maaliyeti",
          "Brüt Kar",
          "Yönetim Giderleri",
          "Faaliyet Karı",
          "Ödenecek Net Faiz",
          "Vergi Öncesi Kar",
          "Vergi",
          "Net Kar"
        ],
        incomeStatementData: const [
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00
        ],
        balanceSheetTitle: const [
          "Bilanço",
          "Duran Varlıklar",
          "Dönen Varlıklar",
          "Kısa Vadeli Yükümlülükler",
          "Uzun Vadeli Yükümlülükler",
          "Net Özsermaye"
        ],
        balanceSheetData: const [
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
          200000.00,
        ],
        historyofUpdates: const [
          "23 Aralık",
          "23 Aralık",
          "23 Aralık",
          "23 Aralık",
        ],
        yearsofUpdates: const ["2021", "2021", "2021", "2021"],
        updatesTitle: const [
          "İlk Hedefimize Ulaştık!",
          "İlk Nitelikli Yatırımcı",
          "₺1.500 Fon Toplandı",
          "Proje Başlatıldı"
        ],
        updatesDescription: const [
          "Desteğiniz için teşekkürler 100.000 ₺’lik ilk hedefe ulaştık.\n\nSırada ikincisi var. 150.000 ₺’lik hedefe ulaşmamıza yardımcı olun.Lütfen daha sonra ne görmek istediğinizle ilgili yorumlarınızı ve fikirlerinizi bırakın. Bunu gerçekleştirmeye ve burada güncellemeye çalışacağız.",
          "",
          "",
          ""
        ],
      );
      logger.i("Project details fetched successfully");
    } catch (e) {
      logger.e("Error fetching project details: $e");
      rethrow;
    }
  }

  Future<void> fetchProjectDetailsItemList() async {
    try {
      projectDetailitemList.value = [
        ProjectDetailModel(
          id: UniqueKey().toString(),
          title: 'Meta 3D Company',
          subtitle: '3D baskı teknolojiler',
          imageUrl: const [
            AssetConstants.meta3D,
            AssetConstants.meta3D,
            AssetConstants.meta3D,
            AssetConstants.meta3D,
            AssetConstants.meta3D
          ],
          risk: 3,
          tags: const ["Teknoloji", "Yazılım", "Enerji"],
          fundRaised: 3507285.00,
          targetFund: 5000000.00,
          remainingDay: '3 Gün',
          investment: '541',
          completed: '%33',
          maturity: '12 Ay',
          rateofReturn: '%55',
          returnFrequency: 'Aylık',
          companyValue: 'Gayrimenkul',
          valuation: 200000.00,
          minimumInvestmentAmount: 100,
          minimumfundingGoal: 25000.00,
          maxfundingGoal: 3000000.00,
          deadLine: "12 Aralık 2024",
          platformDocuments: const [
            "Bilgi Formu",
            "Yatırım Komitesi Raporu",
            "Kredibilite Raporu"
          ],
          startDate: "26.12.2024",
          stopDate: "21.02.2025",
          finishDate: "23.02.2025",
          lot: "8 TL",
          percent: "%6,54",
          additionalAmount: "1.000.000 TL",
          sharePcs: "700.000",
          additionalFundRate: "%20",
          companyValues: "85.600.000 TL",
          collateralStructure: "Gayeimenkul",
          campaignDocuments: const [
            "Fon Kullanımı Raporu",
            "Sunum",
            "Esas Sözleşme",
            "Finansal Projeksiyon",
            "Bilanço",
            "Gelir Tablosu"
          ],
          teamImageUrl: const [
            "https://people2partner.nl/app/uploads/2023/05/p2p-1.png",
            "https://people2partner.nl/app/uploads/2024/01/Mask-Group-23.png",
            "https://people2partner.nl/app/uploads/2024/01/Mask-Group-22.png",
            "https://people2partner.nl/app/uploads/2023/05/Mask-Group-20.png",
            "https://people2partner.nl/app/uploads/2024/01/Mask-Group-29.png",
            "https://people2partner.nl/app/uploads/2023/05/p2p-4.png"
          ],
          teamName: const [
            "Eyşan Öztürk",
            "Aktuğ Gültürk",
            "Alp Şeker",
            "Ecem Baskı",
            "Eyşan Öztürk",
            "Aktuğ Gültürk"
          ],
          teamsInfo: const ["", "", "", "", "", ""],
          teamrole: const [
            "Takım Lideri",
            "Senior Yazılım Uzmanı",
            "Veri Bilimci",
            "Yazılım Geliştirici",
            "Ortaklar",
            "Ortaklar",
          ],
          companyName: "Mionti Enerji",
          foundationYear: "2022",
          chairman: "Aktuğ Gültürk",
          numberofEmployees: "11 - 50",
          companyAddress: "Beşiktaş/İstanbul",
          problem:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          incomePlan:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          market:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          solution:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          competitorAnalysis:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          additionalReward:
              "Yatırım turumuzun başlama tarihi itibariyle yapılan yatırımlarda yatırımcılara aşağıda belirtilen oranlarda ek getiri verilecektir.20.000 TL - 49.999 TL arasında yatırım yapan kişilere %0,5, 50.000 TL - 99.999 TL arasında yatırım yapan kişilere %1, 100.000 TL ve üzerinde yatırım yapan kişilere %2 ek getiri verilecektir.",
          incomeStatementTitle: const [
            "Esas Faaliyet Karı",
            "Esas Faaliyet Zararı",
            "Ciro",
            "Satışların Maaliyeti",
            "Brüt Kar",
            "Yönetim Giderleri",
            "Faaliyet Karı",
            "Ödenecek Net Faiz",
            "Vergi Öncesi Kar",
            "Vergi",
            "Net Kar"
          ],
          incomeStatementData: const [
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00
          ],
          balanceSheetTitle: const [
            "Bilanço",
            "Duran Varlıklar",
            "Dönen Varlıklar",
            "Kısa Vadeli Yükümlülükler",
            "Uzun Vadeli Yükümlülükler",
            "Net Özsermaye"
          ],
          balanceSheetData: const [
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
          ],
          historyofUpdates: const [
            "23 Aralık",
            "23 Aralık",
            "23 Aralık",
            "23 Aralık",
          ],
          yearsofUpdates: const ["2021", "2021", "2021", "2021"],
          updatesTitle: const [
            "İlk Hedefimize Ulaştık!",
            "İlk Nitelikli Yatırımcı",
            "₺1.500 Fon Toplandı",
            "Proje Başlatıldı"
          ],
          updatesDescription: const [
            "Desteğiniz için teşekkürler 100.000 ₺’lik ilk hedefe ulaştık.\n\nSırada ikincisi var. 150.000 ₺’lik hedefe ulaşmamıza yardımcı olun.Lütfen daha sonra ne görmek istediğinizle ilgili yorumlarınızı ve fikirlerinizi bırakın. Bunu gerçekleştirmeye ve burada güncellemeye çalışacağız.",
            "",
            "",
            ""
          ],
        ),
        ProjectDetailModel(
          id: UniqueKey().toString(),
          title: 'melda io',
          subtitle: 'Yeni nesil data analizi & LMS platform',
          imageUrl: const [
            'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
            'https://samunnativentures.com/wp-content/uploads/2023/12/AI-through-his-laptop-computer-in-office-to-help-him-analyze-data-or-generate-virtual-images-and-using-big-data-810x500.jpg',
          ],
          risk: 3,
          tags: const ["Teknoloji", "Yazılım", "Enerji"],
          fundRaised: 3507285.00,
          targetFund: 5000000.00,
          remainingDay: '3 Gün',
          investment: '541',
          completed: '%33',
          maturity: '12 Ay',
          rateofReturn: '%55',
          returnFrequency: 'Aylık',
          companyValue: 'Gayrimenkul',
          valuation: 200000.00,
          minimumInvestmentAmount: 100,
          minimumfundingGoal: 25000.00,
          maxfundingGoal: 3000000.00,
          deadLine: "12 Aralık 2024",
          platformDocuments: const [
            "Bilgi Formu",
            "Yatırım Komitesi Raporu",
            "Kredibilite Raporu"
          ],
          startDate: "26.12.2024",
          stopDate: "21.02.2025",
          finishDate: "23.02.2025",
          lot: "8 TL",
          percent: "%6,54",
          additionalAmount: "1.000.000 TL",
          sharePcs: "700.000",
          additionalFundRate: "%20",
          companyValues: "85.600.000 TL",
          collateralStructure: "Gayeimenkul",
          campaignDocuments: const [
            "Fon Kullanımı Raporu",
            "Sunum",
            "Esas Sözleşme",
            "Finansal Projeksiyon",
            "Bilanço",
            "Gelir Tablosu"
          ],
          teamImageUrl: const [
            "https://people2partner.nl/app/uploads/2023/05/p2p-1.png",
            "https://people2partner.nl/app/uploads/2024/01/Mask-Group-23.png",
            "https://people2partner.nl/app/uploads/2024/01/Mask-Group-22.png",
            "https://people2partner.nl/app/uploads/2023/05/Mask-Group-20.png",
            "https://people2partner.nl/app/uploads/2024/01/Mask-Group-29.png",
            "https://people2partner.nl/app/uploads/2023/05/p2p-4.png"
          ],
          teamName: const [
            "Eyşan Öztürk",
            "Aktuğ Gültürk",
            "Alp Şeker",
            "Ecem Baskı",
            "Eyşan Öztürk",
            "Aktuğ Gültürk"
          ],
          teamsInfo: const ["", "", "", "", "", ""],
          teamrole: const [
            "Takım Lideri",
            "Senior Yazılım Uzmanı",
            "Veri Bilimci",
            "Yazılım Geliştirici",
            "Ortaklar",
            "Ortaklar",
          ],
          companyName: "Mionti Enerji",
          foundationYear: "2022",
          chairman: "Aktuğ Gültürk",
          numberofEmployees: "11 - 50",
          companyAddress: "Beşiktaş/İstanbul",
          problem:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          incomePlan:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          market:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          solution:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          competitorAnalysis:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          additionalReward:
              "Yatırım turumuzun başlama tarihi itibariyle yapılan yatırımlarda yatırımcılara aşağıda belirtilen oranlarda ek getiri verilecektir.20.000 TL - 49.999 TL arasında yatırım yapan kişilere %0,5, 50.000 TL - 99.999 TL arasında yatırım yapan kişilere %1, 100.000 TL ve üzerinde yatırım yapan kişilere %2 ek getiri verilecektir.",
          incomeStatementTitle: const [
            "Esas Faaliyet Karı",
            "Esas Faaliyet Zararı",
            "Ciro",
            "Satışların Maaliyeti",
            "Brüt Kar",
            "Yönetim Giderleri",
            "Faaliyet Karı",
            "Ödenecek Net Faiz",
            "Vergi Öncesi Kar",
            "Vergi",
            "Net Kar"
          ],
          incomeStatementData: const [
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00
          ],
          balanceSheetTitle: const [
            "Bilanço",
            "Duran Varlıklar",
            "Dönen Varlıklar",
            "Kısa Vadeli Yükümlülükler",
            "Uzun Vadeli Yükümlülükler",
            "Net Özsermaye"
          ],
          balanceSheetData: const [
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
          ],
          historyofUpdates: const [
            "23 Aralık",
            "23 Aralık",
            "23 Aralık",
            "23 Aralık",
          ],
          yearsofUpdates: const ["2021", "2021", "2021", "2021"],
          updatesTitle: const [
            "İlk Hedefimize Ulaştık!",
            "İlk Nitelikli Yatırımcı",
            "₺1.500 Fon Toplandı",
            "Proje Başlatıldı"
          ],
          updatesDescription: const [
            "Desteğiniz için teşekkürler 100.000 ₺’lik ilk hedefe ulaştık.\n\nSırada ikincisi var. 150.000 ₺’lik hedefe ulaşmamıza yardımcı olun.Lütfen daha sonra ne görmek istediğinizle ilgili yorumlarınızı ve fikirlerinizi bırakın. Bunu gerçekleştirmeye ve burada güncellemeye çalışacağız.",
            "",
            "",
            ""
          ],
        ),
        ProjectDetailModel(
          id: UniqueKey().toString(),
          title: 'Mionti Enerji',
          subtitle: 'Araç şarj istasyon ağı',
          imageUrl: const [
            AssetConstants.canopyPng,
            AssetConstants.canopyPng,
            AssetConstants.canopyPng,
            AssetConstants.canopyPng,
            AssetConstants.canopyPng,
          ],
          risk: 3,
          tags: const ["Teknoloji", "Yazılım", "Enerji"],
          fundRaised: 3507285.00,
          targetFund: 5000000.00,
          remainingDay: '3 Gün',
          investment: '541',
          completed: '%33',
          maturity: '12 Ay',
          rateofReturn: '%55',
          returnFrequency: 'Aylık',
          companyValue: 'Gayrimenkul',
          valuation: 200000.00,
          minimumInvestmentAmount: 100,
          minimumfundingGoal: 25000.00,
          maxfundingGoal: 3000000.00,
          deadLine: "12 Aralık 2024",
          platformDocuments: const [
            "Bilgi Formu",
            "Yatırım Komitesi Raporu",
            "Kredibilite Raporu"
          ],
          startDate: "26.12.2024",
          stopDate: "21.02.2025",
          finishDate: "23.02.2025",
          lot: "8 TL",
          percent: "%6,54",
          additionalAmount: "1.000.000 TL",
          sharePcs: "700.000",
          additionalFundRate: "%20",
          companyValues: "85.600.000 TL",
          collateralStructure: "Gayeimenkul",
          campaignDocuments: const [
            "Fon Kullanımı Raporu",
            "Sunum",
            "Esas Sözleşme",
            "Finansal Projeksiyon",
            "Bilanço",
            "Gelir Tablosu"
          ],
          teamImageUrl: const [
            "https://people2partner.nl/app/uploads/2023/05/p2p-1.png",
            "https://people2partner.nl/app/uploads/2024/01/Mask-Group-23.png",
            "https://people2partner.nl/app/uploads/2024/01/Mask-Group-22.png",
            "https://people2partner.nl/app/uploads/2023/05/Mask-Group-20.png",
            "https://people2partner.nl/app/uploads/2024/01/Mask-Group-29.png",
            "https://people2partner.nl/app/uploads/2023/05/p2p-4.png"
          ],
          teamName: const [
            "Eyşan Öztürk",
            "Aktuğ Gültürk",
            "Alp Şeker",
            "Ecem Baskı",
            "Eyşan Öztürk",
            "Aktuğ Gültürk"
          ],
          teamsInfo: const ["", "", "", "", "", ""],
          teamrole: const [
            "Takım Lideri",
            "Senior Yazılım Uzmanı",
            "Veri Bilimci",
            "Yazılım Geliştirici",
            "Ortaklar",
            "Ortaklar",
          ],
          companyName: "Mionti Enerji",
          foundationYear: "2022",
          chairman: "Aktuğ Gültürk",
          numberofEmployees: "11 - 50",
          companyAddress: "Beşiktaş/İstanbul",
          problem:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          incomePlan:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          market:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          solution:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          competitorAnalysis:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          additionalReward:
              "Yatırım turumuzun başlama tarihi itibariyle yapılan yatırımlarda yatırımcılara aşağıda belirtilen oranlarda ek getiri verilecektir.20.000 TL - 49.999 TL arasında yatırım yapan kişilere %0,5, 50.000 TL - 99.999 TL arasında yatırım yapan kişilere %1, 100.000 TL ve üzerinde yatırım yapan kişilere %2 ek getiri verilecektir.",
          incomeStatementTitle: const [
            "Esas Faaliyet Karı",
            "Esas Faaliyet Zararı",
            "Ciro",
            "Satışların Maaliyeti",
            "Brüt Kar",
            "Yönetim Giderleri",
            "Faaliyet Karı",
            "Ödenecek Net Faiz",
            "Vergi Öncesi Kar",
            "Vergi",
            "Net Kar"
          ],
          incomeStatementData: const [
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00
          ],
          balanceSheetTitle: const [
            "Bilanço",
            "Duran Varlıklar",
            "Dönen Varlıklar",
            "Kısa Vadeli Yükümlülükler",
            "Uzun Vadeli Yükümlülükler",
            "Net Özsermaye"
          ],
          balanceSheetData: const [
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
          ],
          historyofUpdates: const [
            "23 Aralık",
            "23 Aralık",
            "23 Aralık",
            "23 Aralık",
          ],
          yearsofUpdates: const ["2021", "2021", "2021", "2021"],
          updatesTitle: const [
            "İlk Hedefimize Ulaştık!",
            "İlk Nitelikli Yatırımcı",
            "₺1.500 Fon Toplandı",
            "Proje Başlatıldı"
          ],
          updatesDescription: const [
            "Desteğiniz için teşekkürler 100.000 ₺’lik ilk hedefe ulaştık.\n\nSırada ikincisi var. 150.000 ₺’lik hedefe ulaşmamıza yardımcı olun.Lütfen daha sonra ne görmek istediğinizle ilgili yorumlarınızı ve fikirlerinizi bırakın. Bunu gerçekleştirmeye ve burada güncellemeye çalışacağız.",
            "",
            "",
            ""
          ],
        ),
        ProjectDetailModel(
          id: UniqueKey().toString(),
          title: 'Tunga Soft',
          subtitle: 'Eğitici online mobil platform oyunu',
          imageUrl: const [
            AssetConstants.tunga,
            AssetConstants.tunga,
            AssetConstants.tunga,
            AssetConstants.tunga,
            AssetConstants.tunga,
          ],
          risk: 3,
          tags: const ["Teknoloji", "Yazılım", "Enerji"],
          fundRaised: 3507285.00,
          targetFund: 5000000.00,
          remainingDay: '3 Gün',
          investment: '541',
          completed: '%33',
          maturity: '12 Ay',
          rateofReturn: '%55',
          returnFrequency: 'Aylık',
          companyValue: 'Gayrimenkul',
          valuation: 200000.00,
          minimumInvestmentAmount: 100,
          minimumfundingGoal: 25000.00,
          maxfundingGoal: 3000000.00,
          deadLine: "12 Aralık 2024",
          platformDocuments: const [
            "Bilgi Formu",
            "Yatırım Komitesi Raporu",
            "Kredibilite Raporu"
          ],
          startDate: "26.12.2024",
          stopDate: "21.02.2025",
          finishDate: "23.02.2025",
          lot: "8 TL",
          percent: "%6,54",
          additionalAmount: "1.000.000 TL",
          sharePcs: "700.000",
          additionalFundRate: "%20",
          companyValues: "85.600.000 TL",
          collateralStructure: "Gayeimenkul",
          campaignDocuments: const [
            "Fon Kullanımı Raporu",
            "Sunum",
            "Esas Sözleşme",
            "Finansal Projeksiyon",
            "Bilanço",
            "Gelir Tablosu"
          ],
          teamImageUrl: const [
            "https://people2partner.nl/app/uploads/2023/05/p2p-1.png",
            "https://people2partner.nl/app/uploads/2024/01/Mask-Group-23.png",
            "https://people2partner.nl/app/uploads/2024/01/Mask-Group-22.png",
            "https://people2partner.nl/app/uploads/2023/05/Mask-Group-20.png",
            "https://people2partner.nl/app/uploads/2024/01/Mask-Group-29.png",
            "https://people2partner.nl/app/uploads/2023/05/p2p-4.png"
          ],
          teamName: const [
            "Eyşan Öztürk",
            "Aktuğ Gültürk",
            "Alp Şeker",
            "Ecem Baskı",
            "Eyşan Öztürk",
            "Aktuğ Gültürk"
          ],
          teamsInfo: const ["", "", "", "", "", ""],
          teamrole: const [
            "Takım Lideri",
            "Senior Yazılım Uzmanı",
            "Veri Bilimci",
            "Yazılım Geliştirici",
            "Ortaklar",
            "Ortaklar",
          ],
          companyName: "Mionti Enerji",
          foundationYear: "2022",
          chairman: "Aktuğ Gültürk",
          numberofEmployees: "11 - 50",
          companyAddress: "Beşiktaş/İstanbul",
          problem:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          incomePlan:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          market:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          solution:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          competitorAnalysis:
              "Biz, 21. yüzyılın en büyük zorluklarından üçünü (düşük maliyetli temiz elektrik, şebeke ölçeğinde enerji depolama ve deniz suyunun tuzdan arındırılması) çözmek için çığır açıcı bir teknoloji geliştiren bir teknoloji girişimiyiz. Bunların hepsi sonuçta dikey eksenli rüzgar rotorları ve açık deniz tabanlı uçurtma sistemleri kullanılarak açık denizdeki rüzgardan sağlanır. Ayrıca insani amaçlar, afet yardımı ve açık deniz denizcilik sektörü için dünyanın tek düşük maliyetli, elde taşınabilen deniz suyu tuzdan arındırma cihazını (QuenchSea) geliştirdik ve ticarileştirdik.",
          additionalReward:
              "Yatırım turumuzun başlama tarihi itibariyle yapılan yatırımlarda yatırımcılara aşağıda belirtilen oranlarda ek getiri verilecektir.20.000 TL - 49.999 TL arasında yatırım yapan kişilere %0,5, 50.000 TL - 99.999 TL arasında yatırım yapan kişilere %1, 100.000 TL ve üzerinde yatırım yapan kişilere %2 ek getiri verilecektir.",
          incomeStatementTitle: const [
            "Esas Faaliyet Karı",
            "Esas Faaliyet Zararı",
            "Ciro",
            "Satışların Maaliyeti",
            "Brüt Kar",
            "Yönetim Giderleri",
            "Faaliyet Karı",
            "Ödenecek Net Faiz",
            "Vergi Öncesi Kar",
            "Vergi",
            "Net Kar"
          ],
          incomeStatementData: const [
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00
          ],
          balanceSheetTitle: const [
            "Bilanço",
            "Duran Varlıklar",
            "Dönen Varlıklar",
            "Kısa Vadeli Yükümlülükler",
            "Uzun Vadeli Yükümlülükler",
            "Net Özsermaye"
          ],
          balanceSheetData: const [
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
            200000.00,
          ],
          historyofUpdates: const [
            "23 Aralık",
            "23 Aralık",
            "23 Aralık",
            "23 Aralık",
          ],
          yearsofUpdates: const ["2021", "2021", "2021", "2021"],
          updatesTitle: const [
            "İlk Hedefimize Ulaştık!",
            "İlk Nitelikli Yatırımcı",
            "₺1.500 Fon Toplandı",
            "Proje Başlatıldı"
          ],
          updatesDescription: const [
            "Desteğiniz için teşekkürler 100.000 ₺’lik ilk hedefe ulaştık.\n\nSırada ikincisi var. 150.000 ₺’lik hedefe ulaşmamıza yardımcı olun.Lütfen daha sonra ne görmek istediğinizle ilgili yorumlarınızı ve fikirlerinizi bırakın. Bunu gerçekleştirmeye ve burada güncellemeye çalışacağız.",
            "",
            "",
            ""
          ],
        )
      ];
      logger.i("Project details fetched successfully");
    } catch (e) {
      logger.e("Error fetching project details: $e");
      rethrow;
    }
  }

  Future<void> fetchDetailsMessage() async {
    try {
      detailMessage.value = DetailsMessageModel(
        id: UniqueKey().toString(),
        date: const [
          "2 gün önce",
          "2 gün önce",
          "2 gün önce",
          "2 gün önce",
        ],
        profilePicture: const [
          AssetConstants.messageImage,
          AssetConstants.messageImage,
          AssetConstants.messageImage,
          AssetConstants.messageImage
        ],
        name: const [
          "Eyşan Öztürk",
          "Eyşan Öztürk",
          "Eyşan Öztürk",
          "Eyşan Öztürk"
        ],
        message: const [
          "Proje hakkında yapılan bir yorum text.",
          "Proje hakkında yapılan bir yorum text.",
          "Proje hakkında yapılan bir yorum text.",
          "Proje hakkında yapılan bir yorum text. 2 satırdan oluşan."
        ],
      );

      logger.i("Project details fetched successfully");
    } catch (e) {
      logger.e("Error fetching project details: $e");
      rethrow;
    }
  }

  Future<void> fetchDetailsManegerMessage() async {
    try {
      detailManagerMessage.value = DetailsManegerMessageModel(
        id: UniqueKey().toString(),
        date: "şimdi",
        profilePicture: AssetConstants.messageImage,
        name: "Canopy",
        message: "",
      );

      logger.i("Project details fetched successfully");
    } catch (e) {
      logger.e("Error fetching project details: $e");
      rethrow;
    }
  }

  Future<void> fetchRealizedTransactionList() async {
    try {
      realizedTransactionList.value = [
        InvestmentModel(
            ownerName: 'Tunga Soft',
            imageUrl:
                'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTWL6JqVuWQDs0_23XEC3r92fgNFsZu9O4MQGxxUfV46PsaWp4p',
            monthlyPaymentCount: 'Ön Talep',
            amountReceived: -22325.13,
            startDate: '2024-09-20',
            accountPaymentMethod: 'İptal Et',
            paymentMethod: PaymentMethod.takeMoney),
        InvestmentModel(
            ownerName: 'Oleatex',
            imageUrl:
                'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcT-OgP2VdeMuQc5I3sh7tZczgfnr0ROybRBLaPN7W5vVnGgg-O8',
            monthlyPaymentCount: 'Yatırım (Havale/EFT)',
            amountReceived: -22325.13,
            startDate: '2024-09-16',
            accountPaymentMethod: 'İptal Et',
            paymentMethod: PaymentMethod.takeMoney),
        InvestmentModel(
            ownerName: 'melda io',
            backimage:
                'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
            imageUrl:
                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSPhPks6T4vFjVTSIVjEPQ__8WAnDE8zUwWdH-0D7C-ym8w9Ql0',
            amountReceived: -22325.13,
            startDate: '2024-09-14',
            monthlyPaymentCount: 'Yatırım(Kredi Kartı)',
            paymentMethod: PaymentMethod.takeMoney),
        InvestmentModel(
            backimage:
                'https://tr.ml-vehicle.com/uploads/38258/news/p2024071621574974d90.jpg?size=1200x0',
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            ownerName: 'Mionti Enerji',
            amountReceived: 1200.13,
            startDate: '2024-09-12',
            monthlyPaymentCount: 'Aylık Ödeme 7/12',
            paymentMethod: PaymentMethod.sendMoney)
      ];
    } catch (e) {
      logger.e("Error fetching project transaction : $e");
      rethrow;
    }
  }

  Future<void> fetchpendingTransactionList() async {
    try {
      pendingTransactionList.value = [
        InvestmentModel(
            ownerName: 'Mionti Enerji',
            imageUrl:
                'https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/fc/c7/f6/fcc7f665-fe4d-9864-d1ad-526cd453367d/AppIcon-0-0-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp',
            monthlyPaymentCount: 'Aylık Ödeme 7/12',
            amountReceived: 1200.13,
            startDate: '2024-10-29',
            accountPaymentMethod: 'Gecikmede',
            paymentMethod: PaymentMethod.sendMoney),
        InvestmentModel(
            ownerName: 'Oleatex',
            imageUrl:
                'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcT-OgP2VdeMuQc5I3sh7tZczgfnr0ROybRBLaPN7W5vVnGgg-O8',
            monthlyPaymentCount: 'iptal isteği',
            amountReceived: 22325.13,
            startDate: '2024-10-29',
            paymentMethod: PaymentMethod.sendMoney),
        InvestmentModel(
            ownerName: 'TiPlay',
            imageUrl:
                'https://media.licdn.com/dms/image/v2/D4E22AQEfsmmHBS7b3w/feedshare-shrink_800/feedshare-shrink_800/0/1723472812613?e=2147483647&v=beta&t=-_zaEJNPP--0LiSIvc7sMpslvWUbFKyeCoEaL6SZk2E',
            amountReceived: 22325.13,
            startDate: '2024-09-04',
            monthlyPaymentCount: 'Parçalı İade',
            paymentMethod: PaymentMethod.sendMoney),
      ];
    } catch (e) {
      logger.e("Error fetching project transaction : $e");
      rethrow;
    }
  }

  Future<void> fetchcanceldTransactionList() async {
    try {
      canceldTransactionList.value = [
        InvestmentModel(
            ownerName: 'Oleatex',
            imageUrl:
                'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcT-OgP2VdeMuQc5I3sh7tZczgfnr0ROybRBLaPN7W5vVnGgg-O8',
            monthlyPaymentCount: 'Aylık Ödeme 7/12',
            amountReceived: 1200.13,
            startDate: '2024-10-29',
            paymentMethod: PaymentMethod.sendMoney),
        InvestmentModel(
            ownerName: 'melda io',
            imageUrl:
                'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSPhPks6T4vFjVTSIVjEPQ__8WAnDE8zUwWdH-0D7C-ym8w9Ql0',
            monthlyPaymentCount: 'iptal isteği',
            amountReceived: 22325.13,
            startDate: '2024-10-29',
            paymentMethod: PaymentMethod.sendMoney),
      ];
    } catch (e) {
      logger.e("Error fetching project transaction : $e");
      rethrow;
    }
  }
}
