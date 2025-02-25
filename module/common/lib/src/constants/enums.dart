enum SnackBarType { success, error, warning }

enum TimeRange { Day1, Day3, Week1, Month1, Month6, Year1 }

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

//Silinecek
enum InvestmentStatus {
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
