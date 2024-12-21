import 'package:common/common.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/awards/awards_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/details/details_tab_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/documents_and_financials/documents_and_financials.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/frequently_asked_questions/frequently_asked_questions_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/question_and_answer/question_and_answer_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/summary/summary_view.dart';
import 'package:misyonbank/feature/views/navbar/views/fonvestor/view/detail/widgets/updates/updates_view.dart';
import 'package:misyonbank/product/constants/app_constants.dart';
import 'package:misyonbank/product/models/details_message_model.dart';
import 'package:misyonbank/product/models/project_details_model.dart';
import 'package:misyonbank/product/models/widget_models/investments_item_model.dart';
import 'package:misyonbank/product/services/project_service.dart';

class DetailViewController extends BaseGetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  final _projectService = Get.find<ProjectService>();
  final tabs = AppConstants.detailViewTabs;
  var selectedyears = Rx<String?>(null);
  var messageList = <String>[].obs;
  RxList<InvestmentsItemModel?> get investmentsItemList =>
      _projectService.investmentsItemList;
  void addMessage(String newMessage) {
    messageList.add(newMessage);
  }

  late ProjectDetailModel? selectedProject; // Seçilen proje detayları

  @override
  void onInit() async {
    super.onInit();
    await initView();

    final args = Get.arguments as Map<String, dynamic>?;
    final projectName = args?['projectName'] as String?;

    print("Gelen projectName: $projectName");
    print(
        "Model title: ${projectDetailModel.value!.title}"); // Eğer liste ise, ilk elemanı alıyoruz
    print("Model title türü: ${projectDetailModel.value!.title.runtimeType}");

    selectedProject = projectDetailIremList.firstWhere(
      (sel) => sel?.title?.toLowerCase() == projectName?.toLowerCase(),
      orElse: () => null,
    );

    if (selectedProject == null) {
      logger.e("Eşleşen proje bulunamadı!");
    } else {
      logger.i("Proje yüklendi: ${selectedProject!.title}");
      print("Eşleşen proje: ${selectedProject!}");
    }
  }

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
  var years = ['2020', '2021', '2022', '2023', '2024'];
  final PageController pageController = PageController();
  var currentPage = 0.obs;

  Future<void> initView({Function()? action}) async {
    try {
      change(state, status: RxStatus.loading());
      tabController = TabController(length: tabs.length, vsync: this);
      await _projectService.fetchProjectDetails();
      await _projectService.fetchProjectDetailsItemList();
      await _projectService.fetchDetailsMessage();
      await _projectService.fetchDetailsManegerMessage();
      if (projectDetailModel.value == null) {
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
    final fundRaised = projectDetailModel.value?.fundRaised ?? 0;
    final targetFund = projectDetailModel.value?.targetFund ?? 1;
    return fundRaised / targetFund;
  }

  String get fundRaisedText =>
      (projectDetailModel.value?.fundRaised ?? 0).toString();

  String? get targetFundText => projectDetailModel.value?.targetFund.toString();

  void changeTab(int newIndex) async {
    change(state, status: RxStatus.loading());
    tabController.animateTo(newIndex);
    change(state, status: RxStatus.success());
  }

  Rx<ProjectDetailModel?> get projectDetailModel =>
      _projectService.projectDetail;
  RxList<ProjectDetailModel?> get projectDetailIremList =>
      _projectService.projectDetailitemList;

  Rx<DetailsMessageModel?> get projectMessageModel =>
      _projectService.detailMessage;
  Rx<DetailsManegerMessageModel?> get projectManagerMessageModel =>
      _projectService.detailManagerMessage;
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
    return _colors[
        index % _colors.length]; // Mod işlemi ile tekrar eden renkler
  }
}
