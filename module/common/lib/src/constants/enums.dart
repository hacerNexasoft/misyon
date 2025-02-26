enum ProjectStatus {
  activeFunding,
  activeFundingStopped,
  successful,
  upcomingPreview,
  upcomingPrerelease,
  upcomingDetailedPrerelease,
  unknown,
}

enum FinancialType { income, balance, unknown }

enum CollateralStructure { RealEstate, unknown }

enum Period { Annual, Monthly, unknown }

enum MyInvestmentsProcess { openInvestment, atTermination, returnPeriod }

enum RiskType {
  risky,
  neutral,
  profitable,
}

enum ProjectOpportunityDetail {
  all,
  favorite,
  active,
  successful,
  upcoming,
}

enum InvestmentStateFilter { All, Waiting, Completed, Failed }

enum InvestmentStatus {
  waitingPayment,
  paymentReceived,
  paymentFinalized,
  partiallyRefunded,
  waitingCancel,
  waitingRefund,
  shareDistributed,
  waitingRemainingPayment,
  canceled,
  refunded,
  noPaymentMade,
  paymentFailed,
  notSentToTakasbank,
  underPayment,
  takasbankBadRequest,
  waitingExcessFundRefund,
  unknown
}

enum InvestmentType { CreditCard, Eft, unknown }

//Old Enums

enum SnackBarType { success, error, warning }

enum TimeRange { Day1, Day3, Week1, Month1, Month6, Year1 }

//Silinecek
enum InvestmentStatusOld {
  all,
  reachedTarget,
  openInvestments,
  upcoming,
  preRequest,
  favorites,
  failureToReachTarget
}

enum ExploreInvestment { firstInvestment, highestInvestment, lastInvestment, empty }

enum BankAccountType { current, futures }

enum BankAccountCategory { mission, otherAccounts, bankInstitution }

enum PaymentMethod {
  sendMoney,
  takeMoney,
}
