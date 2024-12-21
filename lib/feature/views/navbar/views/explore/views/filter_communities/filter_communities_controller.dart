import 'package:common/common.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/models/widget_models/check_list_comp_model.dart';
import 'package:misyonbank/product/models/widget_models/time_range_model.dart';

class FilterCommunitiesController extends BaseGetxController {
  var selectedInvestmentTypes = <String>[].obs;
  Rx<TimeRangeModel?> selectedTimeRange = Rx<TimeRangeModel?>(null);
  var selectedInvestmentRange = const RangeValues(0, 1000000).obs;
  var selectedCurrency = Rx<String?>(null);

  var currencies = ['TL', 'USD', 'EUR', 'GBP', 'JPY', 'CNY'];

  var investmentTypes = <CheckListCompModel>[
    CheckListCompModel(
      title: LocalizationKeys.highlightsTextKey.tr,
      isSelected: false,
    ),
    CheckListCompModel(
      title: LocalizationKeys.newOnesTextKey.tr,
      isSelected: false,
    ),
    CheckListCompModel(
      title: LocalizationKeys.soonTextKey.tr,
      isSelected: false,
    ),
    CheckListCompModel(
      title: LocalizationKeys.favoritesTextKey.tr,
      isSelected: false,
    ),
  ];

  var fundFounders = <CheckListCompModel>[
    CheckListCompModel(
      title: 'Fon Kurucusu 1',
      isSelected: false,
      imageUrl: 'https://iskulubu.com/wp-content/uploads/2021/06/proje-manegment-1024x566.jpg',
    ),
    CheckListCompModel(
      title: 'Fon Kurucusu 2',
      imageUrl: 'https://iskulubu.com/wp-content/uploads/2021/06/proje-manegment-1024x566.jpg',
      isSelected: false,
    ),
    CheckListCompModel(
      title: 'Fon Kurucusu 3',
      imageUrl: 'https://iskulubu.com/wp-content/uploads/2021/06/proje-manegment-1024x566.jpg',
      isSelected: false,
    ),
   
  ];

  var timeRanges = TimeRange.values.map((timeRange) => TimeRangeModel(
    timeRange: timeRange,
    isSelected: false,
  )).toList();

  void onInvestmentTypeSelected(int index) {
    investmentTypes[index].isSelected = !investmentTypes[index].isSelected;
    if (investmentTypes[index].isSelected) {
      selectedInvestmentTypes.add(investmentTypes[index].title);
    } else {
      selectedInvestmentTypes.remove(investmentTypes[index].title);
    }
    update();
  }

  void onFundFounderSelected(int index) {
    fundFounders[index].isSelected = !fundFounders[index].isSelected;
    update();
  }

  void onTimeRangeSelected(TimeRangeModel timeRangeModel) {
    timeRangeModel.isSelected = !timeRangeModel.isSelected;
    selectedTimeRange.value = timeRangeModel;
    update();
  }

  void onInvestmentRangeChanged(RangeValues rangeValues) {
    selectedInvestmentRange.value = rangeValues;
    update();
  }

  void onSelectCurrency(String currency) {
    selectedCurrency.value = currency;
    update();
  }
}
