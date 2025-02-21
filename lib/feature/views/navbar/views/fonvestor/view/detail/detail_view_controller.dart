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
import 'package:misyonbank/product/models/details_message_model.dart';
import 'package:misyonbank/product/models/investment_details_model.dart';
import 'package:misyonbank/product/models/project/investment_projections_model.dart';
import 'package:misyonbank/product/models/project/project_create_highlights_model.dart';
import 'package:misyonbank/product/models/project/project_details_model.dart';
import 'package:misyonbank/product/models/project/project_documents_model.dart';
import 'package:misyonbank/product/models/project/project_finansial_model.dart';
import 'package:misyonbank/product/models/project/project_funding_info_model.dart';
import 'package:misyonbank/product/models/project/project_investment_info_model.dart';
import 'package:misyonbank/product/models/project/project_model.dart';
import 'package:misyonbank/product/models/project/project_summary_model.dart';
import 'package:misyonbank/product/models/project/project_team_model.dart';
import 'package:misyonbank/product/models/project/project_trophies_model.dart';
import 'package:misyonbank/product/models/widget_models/investments_item_model.dart';
import 'package:misyonbank/product/services/fetcher_static_service.dart';
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
  var years = ['2020', '2021', '2022', '2023', '2024', '2025'];
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  //OLD
  Rx<InvestmentDetailModel?> get investmentDetail => _projectService.investmentDetail;
  RxList<InvestmentDetailModel?> get projectDetailIremList => _projectService.projectDetailitemList;
  Rx<DetailsMessageModel?> get projectMessageModel => _projectService.detailMessage;
  Rx<DetailsManegerMessageModel?> get projectManagerMessageModel =>
      _projectService.detailManagerMessage;
  //

  @override
  void onInit() async {
    super.onInit();
    selectedProject = Get.arguments["project"];

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
      selectedProjectDetails =
          await FetcherStaticService.fetchProjectDetails(projectID: selectedProject.id);
      selectedProjectSummary =
          await FetcherStaticService.fetchProjectSummary(projectID: selectedProject.id);
      selectedProjectFundingInfo =
          await FetcherStaticService.fetchProjectFundingInfo(projectID: selectedProject.id);
      selectedProjectAbout =
          await FetcherStaticService.fetchProjectAbout(projectID: selectedProject.id);
      selectedProjectInvestmentInfo =
          await FetcherStaticService.fetchProjectInvestmentInfo(projectID: selectedProject.id);
      selectedProjectHighlightsList = await FetcherStaticService.fetchProjectHighlights(
          projectID: selectedProject.id, token: "");
      selectedInvestmentProjectionList =
          await FetcherStaticService.fetchInvestmentProjections(projectID: selectedProject.id);

      selectedProjectTeam =
          await FetcherStaticService.fetchProjectTeam(projectID: selectedProject.id, token: "");

      selectedProjectTrophiesList =
          await FetcherStaticService.fetchProjectTrophies(projectID: selectedProject.id, token: "");

      selectedProjectDocuments = await FetcherStaticService.fetchProjectDocuments(
          projectID: selectedProject.id, token: "");
      selectedProjectFinancials = await FetcherStaticService.fetchProjectFinansials(
        projectID: "5982e0c9-68b9-ef11-8386-005056b0cf81", //selectedProject.id,
      );

      //OLD
      //await _projectService.fetchProjectDetails();
      //await _projectService.fetchProjectDetailsItemList();
      //await _projectService.fetchDetailsMessage();
      //await _projectService.fetchDetailsManegerMessage();
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

  String get fundRaisedText => selectedProjectInvestmentInfo!.fundedAmount.toString();

  String? get targetFundText => selectedProjectInvestmentInfo!.fundingGoal.toString();

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
