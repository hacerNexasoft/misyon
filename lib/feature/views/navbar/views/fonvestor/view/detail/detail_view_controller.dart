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
import 'package:misyonbank/product/models/project/project_details_model.dart';
import 'package:misyonbank/product/models/project/project_funding_info_model.dart';
import 'package:misyonbank/product/models/project/project_investment_info_model.dart';
import 'package:misyonbank/product/models/project/project_model.dart';
import 'package:misyonbank/product/models/project/project_summary_model.dart';
import 'package:misyonbank/product/models/widget_models/investments_item_model.dart';
import 'package:misyonbank/product/services/fetcher_static_service.dart';
import 'package:misyonbank/product/services/project_service.dart';

class DetailViewController extends BaseGetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  final _projectService = Get.find<ProjectService>();
  final tabs = AppConstants.detailViewTabs;
  var selectedyears = Rx<String?>(null);
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

  void changeTab(int newIndex) async {
    change(state, status: RxStatus.loading());
    tabController.animateTo(newIndex);
    change(state, status: RxStatus.success());
  }

  void onSelectYears(String years) {
    selectedyears.value = years;
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
