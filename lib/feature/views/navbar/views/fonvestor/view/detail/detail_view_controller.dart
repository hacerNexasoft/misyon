import 'package:common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/awards/awards_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/details/details_tab_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/documents_and_financials/documents_and_financials.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/frequently_asked_questions/frequently_asked_questions_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/question_and_answer/question_and_answer_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/summary/summary_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/updates/updates_view.dart';
import 'package:misyonbank/product/constants/app_constants.dart';
import 'package:misyonbank/product/models/project/investment_projections_model.dart';
import 'package:misyonbank/product/models/project/project_comments_model.dart';
import 'package:misyonbank/product/models/project/project_create_highlights_model.dart';
import 'package:misyonbank/product/models/project/project_details_model.dart';
import 'package:misyonbank/product/models/project/project_documents_model.dart';
import 'package:misyonbank/product/models/project/project_faq_model.dart';
import 'package:misyonbank/product/models/project/project_finansial_model.dart';
import 'package:misyonbank/product/models/project/project_funding_info_model.dart';
import 'package:misyonbank/product/models/project/project_investment_info_model.dart';
import 'package:misyonbank/product/models/project/project_model.dart';
import 'package:misyonbank/product/models/project/project_summary_model.dart';
import 'package:misyonbank/product/models/project/project_team_model.dart';
import 'package:misyonbank/product/models/project/project_trophies_model.dart';
import 'package:misyonbank/product/models/project/project_update_model.dart';
import 'package:misyonbank/product/models/widget_models/investments_item_model.dart';
import 'package:misyonbank/product/services/fetchers/fonvestor_api_service.dart';
import 'package:misyonbank/product/services/jwt_token_service.dart';
import 'package:misyonbank/product/services/project_service.dart';

import '../../../../../../../product/localization/localization_keys.dart';

class DetailViewController extends BaseGetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  final _projectService = Get.find<ProjectService>();
  final tabs = AppConstants.detailViewTabs;
  var selectedIncomeYear = Rx<String?>(null);
  var selectedBalanceYear = Rx<String?>(null);
  String? jwtToken = Get.find<JwtTokenService>().jwtToken;

  RxList<InvestmentsItemModel?> get investmentsItemList => _projectService.investmentsItemList;

  var isFavorite = false.obs;

  var starColor = Rx<Color>(Colors.transparent);

  late ProjectModel selectedProject; // Seçilen proje
  ProjectDetailsModel? selectedProjectDetails; // Seçilen proje detayları
  ProjectSummaryModel? selectedProjectSummary;
  ProjectFundingInfoModel? selectedProjectFundingInfo;
  String? selectedProjectAbout;
  ProjectInvestmentInfoModel? selectedProjectInvestmentInfo;
  List<ProjectCreateHighlightsModel>? selectedProjectHighlightsList;
  List<InvestmentProjection>? selectedInvestmentProjectionList;
  ProjectTeamModel? selectedProjectTeam;
  List<ProjectTrophiesModel>? selectedProjectTrophiesList;
  ProjectDocumentsModel? selectedProjectDocuments;
  List<ProjectFinancialModel>? selectedProjectFinancials;
  List<ProjectUpdateModel>? selectedProjectUpdateList;
  List<ProjectFaqModel>? selectedProjectFaqList;
  List<ProjectCommentsModel>? selectedProjectCommentsList;

  final textController = TextEditingController();
  List<Widget> detailsTabbarList = [
    const SummaryView(),
    const AwardsView(),
    const DetailsTabView(),
    const DocumentsAndFinancialsView(),
    const UpdatesView(),
    const FrequentlyAskedQuestionsView(),
    const QuestionAndAnswerView(),
  ];

  final PageController pageController = PageController();
  var currentPage = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    if (Get.arguments["project"].runtimeType == ProjectModel) {
      selectedProject = Get.arguments["project"];
    } else {
      change(state, status: RxStatus.error("Proje modeli bulunamadı!"));
      logger.e("Proje modeli bulunamadı!");
      return;
    }

    change(state, status: RxStatus.loading());

    await initView();

    if (kDebugMode) {
      if (selectedProjectDetails == null) {
        logger.e("Proje detayları bulunamadı!");
      } else {
        logger.i("Proje detayları yüklendi: ${selectedProjectDetails!.title}");
      }
    }
  }

  Future<void> initView({Function()? action}) async {
    try {
      if (kDebugMode) {
        print("Selected Project ID: ${selectedProject.id}");
      }

      change(state, status: RxStatus.loading());

      selectedProjectDetails =
          await FonvestorService.fetchProjectDetails(projectID: selectedProject.id);
      selectedProjectSummary =
          await FonvestorService.fetchProjectSummary(projectID: selectedProject.id);
      selectedProjectFundingInfo =
          await FonvestorService.fetchProjectFundingInfo(projectID: selectedProject.id);
      selectedProjectAbout =
          await FonvestorService.fetchProjectAbout(projectID: selectedProject.id);
      selectedProjectInvestmentInfo =
          await FonvestorService.fetchProjectInvestmentInfo(projectID: selectedProject.id);
      if (jwtToken != null) {
        selectedProjectHighlightsList = await FonvestorService.fetchProjectHighlights(
            projectID: selectedProject.id, token: jwtToken!);

        selectedProjectTeam = await FonvestorService.fetchProjectTeam(
            projectID: selectedProject.id, token: jwtToken!);

        selectedProjectTrophiesList = await FonvestorService.fetchProjectTrophies(
            projectID: selectedProject.id, token: jwtToken!);

        selectedProjectDocuments = await FonvestorService.fetchProjectDocuments(
            projectID: selectedProject.id, token: jwtToken!);
        selectedProjectUpdateList = await FonvestorService.fetchProjectUpdates(
            projectID: selectedProject.id, token: jwtToken!);

        selectedProjectFaqList = await FonvestorService.fetchProjectFaqs(
            projectID: selectedProject.id, token: jwtToken!);
        selectedProjectCommentsList = await FonvestorService.fetchProjectComments(
            projectID: selectedProject.id, token: jwtToken!);
      }

      selectedInvestmentProjectionList =
          await FonvestorService.fetchInvestmentProjections(projectID: selectedProject.id);
      selectedProjectFinancials = await FonvestorService.fetchProjectFinansials(
        projectID: selectedProject.id,
      );

      if (selectedProjectDetails == null ||
          selectedProjectSummary == null ||
          selectedProjectInvestmentInfo == null) {
        change(state, status: RxStatus.error());
        return;
      }
      change(state, status: RxStatus.success());
    } catch (e) {
      change(state, status: RxStatus.error(e.toString()));
      logger.e(e);
    }
  }

  double getProgress() {
    final fundRaised = selectedProjectInvestmentInfo!.fundedAmount;
    final targetFund = selectedProjectInvestmentInfo!.fundingGoal;
    return fundRaised / targetFund;
  }

  String remainingDayText() {
    String remainingDay = "-";

    DateTime endDate =
        DateTime.fromMillisecondsSinceEpoch(selectedProjectInvestmentInfo!.projectEndDate * 1000);

    remainingDay =
        endDate.difference(DateTime.now().toUtc().add(const Duration(hours: 3))).inDays.toString();
    return remainingDay;
  }

  void changeTab(int newIndex) async {
    change(state, status: RxStatus.loading());
    tabController.animateTo(newIndex);
    change(state, status: RxStatus.success());
  }

  void onSelectIncomeYear(String years) {
    selectedIncomeYear.value = years;
    update();
  }

  void onSelectBalanceYear(String years) {
    selectedBalanceYear.value = years;
    update();
  }

  Future<bool> upsertProjectToFavorites(String projectId) async {
    final result = await FonvestorService.upsertProjectToFavorites(
        projectId: projectId,
        token:
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjQ3NjY5Y2JhLTg4ZjMtZWYxMS04Mzg4LTAwNTA1NmIwY2Y4MSIsIm5iZiI6MTc0MDc0MzgwNywiZXhwIjoxNzQwODMwMjA3LCJpYXQiOjE3NDA3NDM4MDd9.z_opEym8afpLOT0jxSYDs6iWNFEUNI-3WBn5udgEa9c');
    return result != null;
  }

  void toggleFavorite() async {
    if (jwtToken == null) {
      Get.snackbar(
        LocalizationKeys.warning.tr,
        LocalizationKeys.warningForAuthTextKey.tr,
      );
      return;
    }
    final success = await upsertProjectToFavorites(selectedProject.id);
    if (success) {
      isFavorite.value = !isFavorite.value;
    } else {
      if (kDebugMode) {
        print("Favoriye ekleme/çıkarma başarısız!");
      }
      Get.snackbar("Hata", "Favori işlemi gerçekleştirilemedi");
    }
  }

  @override
  void onClose() {
    textController.dispose();
    pageController.dispose();
    tabController.dispose();
    super.onClose();
  }
}

class ColorProvider {
  static const List<Color> _colors = [
    Color(0xFFF0F0F2), // #f0f0f2
    Color(0xFFE8F2FA), // #e8f2fa
    Color(0xFFB7EAEB), // #b7eaeb
    Color(0xFF3ACEF0), // #3acef0
    Color(0xFFE8F2FA), // #e8f2fa
    Color(0xFFF0F0F2), // #f0f0f2
    Color(0xFF6641FA), // #6641fa
  ];

  static Color getColor(int index) {
    return _colors[index % _colors.length]; // Mod işlemi ile tekrar eden renkler
  }
}
