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
import 'package:misyonbank/product/services/fetchers/projectdetail_fetcher_static_service.dart';
import 'package:misyonbank/product/services/project_service.dart';

class DetailViewController extends BaseGetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  final _projectService = Get.find<ProjectService>();
  final tabs = AppConstants.detailViewTabs;
  var selectedIncomeYear = Rx<String?>(null);
  var selectedBalanceYear = Rx<String?>(null);
  var messageList = <String>[].obs;
  RxList<InvestmentsItemModel?> get investmentsItemList => _projectService.investmentsItemList;
  void addMessage(String newMessage) {
    messageList.add(newMessage);
  }

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
      //print(selectedProject.id);

      change(state, status: RxStatus.loading());
      tabController = TabController(length: tabs.length, vsync: this);
      selectedProjectDetails = await ProjectDetailFetcherStaticService.fetchProjectDetails(
          projectID: selectedProject.id);
      selectedProjectSummary = await ProjectDetailFetcherStaticService.fetchProjectSummary(
          projectID: selectedProject.id);
      selectedProjectFundingInfo = await ProjectDetailFetcherStaticService.fetchProjectFundingInfo(
          projectID: selectedProject.id);
      selectedProjectAbout =
          await ProjectDetailFetcherStaticService.fetchProjectAbout(projectID: selectedProject.id);
      selectedProjectInvestmentInfo =
          await ProjectDetailFetcherStaticService.fetchProjectInvestmentInfo(
              projectID: selectedProject.id);
      selectedProjectHighlightsList =
          await ProjectDetailFetcherStaticService.fetchProjectHighlights(
              projectID: selectedProject.id, token: "");
      selectedInvestmentProjectionList =
          await ProjectDetailFetcherStaticService.fetchInvestmentProjections(
              projectID: selectedProject.id);

      selectedProjectTeam = await ProjectDetailFetcherStaticService.fetchProjectTeam(
          projectID: selectedProject.id, token: "");

      selectedProjectTrophiesList = await ProjectDetailFetcherStaticService.fetchProjectTrophies(
          projectID: selectedProject.id, token: "");

      selectedProjectDocuments = await ProjectDetailFetcherStaticService.fetchProjectDocuments(
          projectID: selectedProject.id, token: "");

      selectedProjectFinancials = await ProjectDetailFetcherStaticService.fetchProjectFinansials(
        projectID: "5982e0c9-68b9-ef11-8386-005056b0cf81", //selectedProject.id,
      );

      selectedProjectUpdateList = await ProjectDetailFetcherStaticService.fetchProjectUpdates(
          projectID: selectedProject.id, token: "");

      selectedProjectFaqList = await ProjectDetailFetcherStaticService.fetchProjectFaqs(
          projectID: selectedProject.id, token: "");
      selectedProjectCommentsList = await ProjectDetailFetcherStaticService.fetchProjectComments(
          projectID: selectedProject.id, token: "");

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
  ];

  static Color getColor(int index) {
    return _colors[index % _colors.length]; // Mod işlemi ile tekrar eden renkler
  }
}
