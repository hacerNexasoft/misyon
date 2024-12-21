import 'dart:convert';
import 'package:common/common.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:misyonbank/product/localization/localization_keys.dart';
import 'package:misyonbank/product/localization/localization_service.dart';
import 'package:money_input_formatter/money_input_formatter.dart';

class Formatter {
  static String fotmatStr = '###,##0.';

  // Uygulama içerisindeki para değerlerini formatlamak için kodlanmış fonksiyon
  static String formatMoney(dynamic value,
      {int? zeroCount, int? afterZeroCount, bool showCurrency = true}) {
    if (value == null) return '-';
    String? str;
    NumberFormat customFormat;
    var customfotmatStr = fotmatStr;
    if (zeroCount == null && afterZeroCount == null) {
      customFormat = _createFormat(value) ??
          NumberFormat(customfotmatStr += '00##', 'tr_TR');
    } else {
      for (var i = 0; i < zeroCount!; i++) {
        customfotmatStr += '0';
      }
      for (var i = 0; i < afterZeroCount!; i++) {
        customfotmatStr += '#';
      }
      customFormat = NumberFormat(customfotmatStr, 'tr_TR');
    }

    try {
      if (value is double) {
        str = customFormat.format(value);
      } else if (value is String) {
        var number = double.tryParse(value) ??
            double.tryParse(value.replaceFirst(',', '.'));
        if (number == null) return '-';
        str = customFormat.format(number);
      } else {
        str = '-';
      }
    } catch (e) {
      Get.find<Logger>().e(e);
      str = '-';
    }
    return showCurrency ? '$str ₺' : str;
  }

  static String formatPercent(dynamic value,
      {int? zeroCount, int? afterZeroCount}) {
    if (value == null) return '-';
    String? str;
    NumberFormat customFormat;
    var customfotmatStr = fotmatStr;

    if (zeroCount == null && afterZeroCount == null) {
      customFormat = NumberFormat.percentPattern('tr_TR');
    } else {
      // Yüzde formatını oluştur
      customfotmatStr += '0';

      for (var i = 1; i < zeroCount!; i++) {
        customfotmatStr += '0';
      }
      for (var i = 0; i < afterZeroCount!; i++) {
        customfotmatStr += '#';
      }

      customFormat = NumberFormat(customfotmatStr, 'tr_TR');
    }

    try {
      if (value is double) {
        str = customFormat.format(value / 100);
      } else if (value is String) {
        var number = double.tryParse(value) ??
            double.tryParse(value.replaceFirst(',', '.'));
        if (number == null) return '-';
        str = customFormat.format(number / 100);
      } else {
        str = '-';
      }
    } catch (e) {
      Get.find<Logger>().e(e);
      str = '-';
    }
    return str;
  }

  static NumberFormat? _createFormat(dynamic value) {
    try {
      List<String> digits;
      var format = fotmatStr;
      var count = 1;
      if (value is double) {
        digits = value.toString().split('.');
      } else if (value is String) {
        var number = double.tryParse(value) ??
            double.tryParse(value.replaceFirst(',', '.'));
        if (number == null) return null;
        digits = number.toString().split('.');
      } else {
        return null;
      }
      if (digits.isNotEmpty) {
        if (digits[0].length > 2) {
          format += '00';
        } else {
          for (var i = 0; i < digits[1].length; i++) {
            if (int.parse(digits[1][i].toString()) != 0) {
              count = i + 1;
            }
          }
          for (var i = 0; i < count; i++) {
            format += '0';
          }
        }
        return NumberFormat(format, 'tr_TR');
      }
    } catch (e) {
      Get.find<Logger>().e(e);
    }
    return null;
  }

  static double? parseFormattedStringToDouble(String? formattedString) {
    String? sanitizedString =
        formattedString?.replaceAll('.', '').replaceAll(',', '.');

    return double.tryParse(sanitizedString ?? '');
  }

  static List<TextInputFormatter> moneyInputFormat(
    int precision,
  ) =>
      [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
        ...inputFormat,
        MoneyInputFormatter(precision: precision),
      ];

  static List<TextInputFormatter> get inputFormat => [
        TextInputFormatter.withFunction((oldValue, newValue) {
          String newText = newValue.text;
          if (newText.trim().isNotEmpty) {
            if (newText.length == 1 && (newText == ',' || newText == '.')) {
              if (newText == '.') {
                var replacedValue = newText.replaceAll('.', '0,');
                return newValue.copyWith(
                  text: replacedValue,
                  selection: TextSelection.fromPosition(
                    TextPosition(offset: replacedValue.length),
                  ),
                );
              } else {
                var replacedValue = newText.replaceAll(',', '0,');
                return newValue.copyWith(
                  text: replacedValue,
                  selection: TextSelection.fromPosition(
                    TextPosition(offset: replacedValue.length),
                  ),
                );
              }
            }

            String newChar = newText.length > oldValue.text.length
                ? newText[newValue.selection.baseOffset - 1]
                : '';

            if (newChar == '.') {
              newText = newText.replaceRange(newValue.selection.baseOffset - 1,
                  newValue.selection.baseOffset, ',');
            }
            return newValue.copyWith(
              text: newText,
              selection: TextSelection.collapsed(
                  offset: newValue.selection.baseOffset),
              composing: TextRange.empty,
            );
          }
          return newValue;
        })
      ];

  static dynamic apiDecode(dynamic data) {
    if (data is String) {
      try {
        return jsonDecode(data);
      } catch (e) {
        return null;
      }
    } else if (data is Map || data is List) {
      return data;
    } else {
      return null;
    }
  }

  static final DateFormat _formatter = DateFormat('dd/MM/yyyy');

  static String processDate(dynamic dateInput) {
    DateTime date;

    if (dateInput is String) {
      final isUtc = dateInput.contains('T') && dateInput.contains('Z');
      date = isUtc
          ? DateTime.parse(dateInput).toLocal()
          : _formatter.parse(dateInput).toLocal();
    } else if (dateInput is DateTime) {
      date = dateInput.toLocal();
    } else {
      throw ArgumentError('Invalid date input: $dateInput');
    }

    return _formatter.format(date);
  }

  static String? convertToUtcString(String dateInput) {
    if (!RegExp(r'\d').hasMatch(dateInput)) {
      return null;
    }

    try {
      DateTime date = _formatter.parse(dateInput);
      DateTime utcDate = date.toUtc();
      String formattedDate = utcDate.toString();
      return formattedDate;
    } catch (e) {
      return null;
    }
  }

  static DateTime? stringToDateTime(String? timeString) {
    if (timeString != null) {
      List<String> parts = timeString.split(':');
      if (parts.length == 2) {
        int? hour = int.tryParse(parts[0]);
        int? minute = int.tryParse(parts[1]);
        if (hour != null && minute != null) {
          return DateTime(1, 1, 1, hour, minute);
        }
      }
    }
    return null;
  }

  static String formatName(String? fullName) {
    if (fullName == null) {
      return '';
    }
    List<String> nameParts = fullName.split(" ");

    if (nameParts.length != 2) {
      throw Exception('Invalid input, exactly two words expected');
    }

    String formattedFirstName = _maskPart(nameParts[0]);
    String formattedLastName = _maskPart(nameParts[1]);

    return '$formattedFirstName $formattedLastName';
  }

  static String _maskPart(String part) {
    if (part.length > 1) {
      return part[0] + '*' * (part.length - 1);
    } else {
      return part;
    }
  }

  static String formatDateTime(dynamic dateInput, {bool isDayOfWeek = false}) {
    DateTime? dateTime;

    if (dateInput is String) {
      try {
        dateTime = DateTime.parse(dateInput);
      } catch (e) {
        throw ArgumentError('Invalid date string: $dateInput');
      }
    } else if (dateInput is DateTime) {
      dateTime = dateInput;
    } else {
      throw ArgumentError('Invalid date input: $dateInput');
    }

    final monthNames = {
      1: LocalizationKeys.januaryTextKey.tr,
      2: LocalizationKeys.februaryTextKey.tr,
      3: LocalizationKeys.marchTextKey.tr,
      4: LocalizationKeys.aprilTextKey.tr,
      5: LocalizationKeys.mayTextKey.tr,
      6: LocalizationKeys.juneTextKey.tr,
      7: LocalizationKeys.julyTextKey.tr,
      8: LocalizationKeys.augustTextKey.tr,
      9: LocalizationKeys.septemberTextKey.tr,
      10: LocalizationKeys.octoberTextKey.tr,
      11: LocalizationKeys.novemberTextKey.tr,
      12: LocalizationKeys.decemberTextKey.tr,
    };

    final day = dateTime.day;
    final month = monthNames[dateTime.month];
    final year = dateTime.year;

    if (isDayOfWeek) {
      var locale = Get.find<LocalizationService>().getLocale().toString();
      if (!locale.contains('_')) {
        locale = '${locale.toLowerCase()}_${locale.toUpperCase()}';
      }
      var dayOfWeek = DateFormat('EEEE', locale).format(dateTime);
      return '$dayOfWeek, $day $month';
    }
    return '$day $month $year';
  }

  static double convertFormattedAmountStringToDouble(String value) {
    value = value.replaceAll('.', '').replaceAll(',', '.');
    return double.parse(value);
  }

  static int calculateMonthDifference(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) {
      return 0;
    }

    int startYear = startDate.year;
    int startMonth = startDate.month;
    int endYear = endDate.year;
    int endMonth = endDate.month;

    int yearDifference = endYear - startYear;
    int monthDifference = endMonth - startMonth;

    return yearDifference * 12 + monthDifference;
  }

  static var creditCardExpirationDateInputFormatters = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(4),
    ExpirationDateInputFormatter(),
  ];

  static var creditCardNumberInputFormatters = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(19),
    CreditCardNumberFormatter(),
  ];

  static List<int>? getExprationDateInputs(String dateInput) {
    final parts = dateInput.split('/');
    if (parts.length == 2) {
      final month = int.tryParse(parts[0]);
      final year = int.tryParse(parts[1]);
      if (month != null && year != null) {
        return [month, year];
      }
    }
    return null;
  }

  static List<TextInputFormatter> onlyLettersInputFormatter = [
    OnlyLettersInputFormatter()
  ];
}

class OnlyLettersInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final RegExp regex = RegExp(r'^[a-zA-Z\s]*$');
    if (regex.hasMatch(newValue.text)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}

class ExpirationDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    if (newText.length >= 3) {
      newText = newText.replaceRange(2, 2, '/');
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class CreditCardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = _addSpaces(newValue.text);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String _addSpaces(String text) {
    final buffer = StringBuffer();
    final cleanedText = text.replaceAll(' ', '');

    for (int i = 0; i < cleanedText.length; i++) {
      if (i % 4 == 0 && i != 0) {
        buffer.write(' ');
      }
      buffer.write(cleanedText[i]);
    }

    return buffer.toString();
  }
}
