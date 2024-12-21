import 'package:common/common.dart';

class YieldCalculatorToolWidgetController extends BaseGetxController {
  final interestRateController = TextEditingController();
  final monthsController = TextEditingController();
  final amountController = TextEditingController();

  var isExpanded = false.obs;
  var monthlyIncome = 0.0.obs;
  var netIncome = 0.0.obs;

  void calculate() {
    double interestRate = _parseDouble(interestRateController.text);
    double months = _parseDouble(monthsController.text);
    double amount = _parseDouble(amountController.text);

    if (_isValidInput(interestRate, months, amount)) {
      _updateIncomeValues(amount, interestRate, months);
    } else {
      _resetIncomeValues();
    }
  }

  double _parseDouble(String value) {
    return double.tryParse(value) ?? 0.0;
  }

  bool _isValidInput(double interestRate, double months, double amount) {
    return months > 0 && interestRate > 0 && amount > 0;
  }

  void _updateIncomeValues(double amount, double interestRate, double months) {
    monthlyIncome.value = (amount * (interestRate / 100)) / months;
    netIncome.value = amount + (monthlyIncome.value * months);

    change(null, status: RxStatus.success());
  }

  void _resetIncomeValues() {
    monthlyIncome.value = 0.0;
    netIncome.value = 0.0;

    change(null, status: RxStatus.empty());
  }

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
  }
}
