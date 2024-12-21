import 'package:common/common.dart';
import 'package:misyonbank/product/models/bank_model.dart';

class BankService extends BaseGetxService {
  final bankList = <BankModel>[].obs;
  var selectedBank = Rx<BankModel?>(null);

  void changeSelectedBank(BankModel? bank) => selectedBank.value = bank;

  Future<void> fetchBanks() async {
    try {
      bankList.value = const [
        BankModel(
          id: 'akbank',
          name: 'Akbank',
          imageUrl: 'https://logos-world.net/wp-content/uploads/2021/02/Akbank-Symbol.png',
        ),
        BankModel(
          id: 'garanti',
          name: 'Garanti BBVA',
          imageUrl:
              'https://downloadr2.apkmirror.com/wp-content/uploads/2023/08/53/64d131494376d_com.garanti.cepsubesi.png',
        ),
        BankModel(
          id: 'isbank',
          name: 'Türkiye İş Bankası',
          imageUrl:
              'https://play-lh.googleusercontent.com/4l4ZfAuIgui4G86SOTkmm-WRMycF69yEdJFVgFtGXJOTQCpbqmxZ7_y8tWDgJ0wer5V9',
        ),
        BankModel(
          id: 'yapikredi',
          name: 'Yapı Kredi',
          imageUrl: 'https://s3-symbol-logo.tradingview.com/yapi-ve-kredi--600.png',
        ),
        BankModel(
          id: 'ziraat',
          name: 'Ziraat Bankası',
          imageUrl:
              'https://mir-s3-cdn-cf.behance.net/projects/404/baeaab48371107.Y3JvcCw0MDUsMzE3LDAsMA.png',
        ),
      ];
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
