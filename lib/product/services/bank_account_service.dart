import 'package:common/common.dart';
import 'package:misyonbank/product/models/bank_account_model.dart';

class BankAccountService extends BaseGetxController {
  var selectedAccount = Rx<BankAccountModel?>(null);
  var bankAccounts = <BankAccountModel>[].obs;

  void changeSelectedAccount(BankAccountModel? account) => selectedAccount.value = account;

  Future<void> fetchBankAccounts() async {
    try {
      bankAccounts.clear();
      bankAccounts.addAll(const [
        BankAccountModel(
          id: '1',
          title: 'My Account',
          imageUrl: 'https://cdn-icons-png.flaticon.com/512/33/33206.png',
          balance: 213345,
          availableBalance: 213345,
          accountType: BankAccountType.current,
          currency: 'TL',
          category: BankAccountCategory.mission,
          iban: 'TR56 0014 3000 0000 0005 4149 58',
          accountHolder: 'John Doe',
        ),
        BankAccountModel(
          id: '2',
          title: 'My Other Account',
          imageUrl: 'https://cdn-icons-png.flaticon.com/512/33/33206.png',
          balance: 121650.0,
          availableBalance: 50550,
          accountType: BankAccountType.futures,
          currency: 'TL',
          category: BankAccountCategory.otherAccounts,
          iban: 'TR56 0014 3000 0000 0005 4149 58',
          accountHolder: 'Jeniffer Sanders',
        ),
        BankAccountModel(
          id: '3',
          title: 'Bank Institution',
          imageUrl: 'https://cdn-icons-png.flaticon.com/512/33/33206.png',
          balance: 12312.05,
          availableBalance: 34567.12,
          accountType: BankAccountType.current,
          currency: 'TL',
          category: BankAccountCategory.bankInstitution,
          iban: 'TR56 0014 3000 0000 0005 4149 58',
          accountHolder: 'Albert G. Smith',
        ),
        BankAccountModel(
          id: '4',
          title: 'My Account',
          imageUrl: 'https://cdn-icons-png.flaticon.com/512/33/33206.png',
          balance: 213345,
          availableBalance: 213345,
          accountType: BankAccountType.current,
          currency: 'TL',
          category: BankAccountCategory.mission,
          iban: 'TR56 0014 3000 0000 0005 4149 58',
          accountHolder: 'John Vaer',
        ),
        BankAccountModel(
          id: '5',
          title: 'My Other Account',
          imageUrl: 'https://cdn-icons-png.flaticon.com/512/33/33206.png',
          balance: 121650.0,
          availableBalance: 50550,
          accountType: BankAccountType.futures,
          currency: 'TL',
          category: BankAccountCategory.otherAccounts,
          iban: 'TR56 0014 3000 0000 0005 4149 58',
          accountHolder: 'Julia Roberts',
        ),
        BankAccountModel(
          id: '6',
          title: 'Bank Institution',
          imageUrl: 'https://cdn-icons-png.flaticon.com/512/33/33206.png',
          balance: 12312.05,
          availableBalance: 34567.12,
          accountType: BankAccountType.current,
          currency: 'TL',
          category: BankAccountCategory.bankInstitution,
          iban: 'TR56 0014 3000 0000 0005 4149 58',
          accountHolder: 'Albert G. Smith',
        ),
      ]);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
