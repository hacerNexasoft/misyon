class ApiEndpoints {
  static const String baseUrl = "https://crwdapi.nexasoft.io";
  static const String apiVersion = "v1";

  // ***************** Account *****************
  static const String getAccountInformation = "/api/account/getaccountinformation";
  static const String getCompanyInvestors = "/api/account/getcompanyinvestors";
  static const String upsertAccount = "/api/account/upsertaccount";
  static const String approveOrDenied = "/api/account/approveordenied";

  // *************** Additional Content ***************
  static const String getAdditionalContentByType = "/api/additionalcontent/getadditionalcontentbytype";

  // ***************** Auth *****************
  static const String signUp = "/api/auth/signup";
  static const String signIn = "/api/auth/signin";
  static const String logout = "/api/auth/logout";
  static const String forgotPassword = "/api/auth/forgotpassword";
  static const String validatePasswordToken = "/api/auth/validatepasswordtoken";
  static const String resetPassword = "/api/auth/resetpassword";
  static const String verifyEmail = "/api/auth/verifyemail";
  static const String sendVerificationEmail = "/api/auth/sendverificationemail";

  // *************** Business Model ***************
  static const String getAllBusinessModels = "/api/businessmodel/getallbusinessmodels";
  static const String getInvestorBusinessModels = "/api/businessmodel/getinvestorbusinessmodels";
  static const String updateInvestorBusinessModels = "/api/businessmodel/updateinvestorbusinessmodels";

  // ***************** Category *****************
  static const String getAllCategories = "/api/category/getallcategories";
  static const String getInvestorCategories = "/api/category/getinvestorcategories";
  static const String updateInvestorCategories = "/api/category/updateinvestorcategories";

  // ***************** Contact Us *****************
  static const String submitContactForm = "/api/contactus/submitform";

  // ***************** CRM *****************
  static const String getMasterData = "/api/crm/getmasterdata";
  static const String getCacheKeyMaster = "/api/crm/getcachekeymaster";
  static const String isOutOfService = "/api/crm/isoutofservice";
  static const String getMobileAppUrls = "/api/crm/getmobileappurls";

  // ***************** Document *****************
  static const String getDocument = "/api/document/getdocument";

  // ***************** E-Devlet *****************
  static const String getLoginUrl = "/api/edevlet/getloginurl";
  static const String getVerificationResult = "/api/edevlet/getverificationresult";
  static const String checkMemberState = "/api/edevlet/checkmemberstate";
  static const String verifyEdevlet = "/api/edevlet/verifyedevlet";

  // ***************** Entrepreneur *****************
  static const String getEntrepreneurLimit = "/api/entrepreneur/getentrepreneurlimit";

  // *************** EntrepreneurDbit ***************
  static const String getEntrepreneurDbitLimit = "/api/entrepreneurdbit/getentrepreneurlimit";

  // *************** Favorite Project ***************
  static const String getFavoriteProjects = "/api/favoriteproject/getfavoriteprojects";
  static const String upsertProjectToFavorites = "/api/favoriteproject/upsertprojecttofavorites";

  // ***************** How It Work *****************
  static const String getHowItWork = "/api/favoriteproject/gethowitwork";

  // ***************** Investment *****************
  static const String makeCreditCardInvestment = "/api/investment/makecreditcardinvestment";
  static const String makeEftInvestment = "/api/investment/makeeftinvestment";
  static const String cancelRefundInvestment = "/api/investment/cancelrefundinvestment";
  static const String creditCardPaymentFallback = "/api/investment/creditcardpaymentfallback";

  // ***************** Investor *****************
  static const String getInvestorAddressInformation = "/api/investor/getinvestoraddressinformation";
  static const String getInvestorIdentityInformation = "/api/investor/getinvestoridentityinformation";
  static const String getInvestorCommunicationInformation = "/api/investor/getinvestorcommunicationinformation";
  static const String getInvestorPersonalInformation = "/api/investor/getinvestorpersonalinformation";
  static const String getIncomeStatements = "/api/investor/getincomestatements";
  static const String getInvestorInformation = "/api/investor/getinvestorinformation";
  static const String getMyProjects = "/api/investor/getmyprojects";
  static const String getMyQuestions = "/api/investor/getmyquestions";
  static const String getMyProjectSummary = "/api/investor/getmyprojectsummary";
  static const String getMkkLimit = "/api/investor/getmkklimit";
  static const String checkInvestorProjectPreApplication = "/api/investor/checkinvestorprojectpreapplication";
  static const String getInvestorPermissions = "/api/investor/getinvestorpermissions";
  static const String getInvestorCorporateInformation = "/api/investor/getinvestorcorporateinformation";
  static const String updateInvestorAddress = "/api/investor/updateinvestoraddress";
  static const String updateInvestorPersonalInformation = "/api/investor/updateinvestorpersonalinformation";
  static const String updateEmail = "/api/investor/updateemail";
  static const String updatePhoneNumber = "/api/investor/updatephonenumber";
  static const String updatePassword = "/api/investor/updatepassword";
  static const String updateIncomeStatement = "/api/investor/updateincomestatement";
  static const String updateMkkNo = "/api/investor/updatemkkno";
  static const String deleteMember = "/api/investor/deletemember";
  static const String updateEmailVerify = "/api/investor/updateemailverify";
  static const String getMyBankAccountInformations = "/api/investor/getmybankaccountinformations";
  static const String getMyBankAccountInformationDetail = "/api/investor/getmybankaccountinformationdetail";
  static const String upsertBankAccountInformation = "/api/investor/upsertbankaccountinformation";
  static const String deleteBankAccountInformation = "/api/investor/deletebankaccountinformation";

  // *************** InvestorDbit ***************
  static const String updateIncomeStatementDbit = "/api/investordbit/updateincomestatement";

  // *************** Newsletter ***************
  static const String addNewsletter = "/api/notification/addnewsletter";

  // *************** Notification ***************
  static const String getInvestorNotifications = "/api/notification/getinvestornotifications";
  static const String updateInvestorNotifications = "/api/notification/updateinvestornotifications";

  // *************** Portfolio ***************
  static const String getInvestmentSummary = "/api/portfolio/getinvestmentsummary";
  static const String getInvestments = "/api/portfolio/getinvestments";

  // *************** PortfolioDbit ***************
  static const String getInvestmentSummaryDbit = "/api/portfoliodbit/getinvestmentsummary";
  static const String getInvestmentsDbit = "/api/portfoliodbit/getinvestments";

  // *************** PreInvestment Gathering ***************
  static const String getPreInvestmentGatheringByProjectExternalId = "/api/preinvestmentgethering/getpreinvestmentgetheringbyprojectexternalid";
  static const String upsertPreInvestmentGathering = "/api/preinvestmentgethering/upsertpreinvestmentgethering";
  static const String deletePreInvestmentGathering = "/api/preinvestmentgethering/deletepreinvestmentgethering";

  // *************** Preview ***************
  static const String getProjectSummaryPreview = "/api/preview/getprojectsummary";
  static const String getProjectAboutPreview = "/api/preview/getprojectabout";
  static const String getProjectFundingInfoPreview = "/api/preview/getprojectfundinginfo";
  static const String getProjectDetailsPreview = "/api/preview/getprojectdetails";
  static const String getProjectInvestmentInfoPreview = "/api/preview/getprojectinvestmentinfo";
  static const String getProjectTeamPreview = "/api/preview/getprojectteam";
  static const String getProjectDocumentsPreview = "/api/preview/getprojectdocuments";
  static const String getProjectUpdatesPreview = "/api/preview/getprojectupdates";
  static const String getProjectFaqPreview = "/api/preview/getprojectfaq";

  // *************** Project ***************
  static const String getFilteredProjects = "/api/project/getfilteredprojects";
  static const String getProjectSummary = "/api/project/getprojectsummary";
  static const String getProjectAbout = "/api/project/getprojectabout";
  static const String getProjectFundingInfo = "/api/project/getprojectfundinginfo";
  static const String getProjectDetails = "/api/project/getprojectdetails";
  static const String getProjectInvestmentInfo = "/api/project/getprojectinvestmentinfo";
  static const String getProjectSummaryByExternalId = "/api/project/getprojectsummarybyexternalid";
  static const String deleteProject = "/api/project/deleteproject";
  static const String searchProjects = "/api/project/searchprojects";

  // *************** Project Comment ***************
  static const String getProjectComments = "/api/projectcomment/getprojectcomments";
  static const String createProjectComment = "/api/projectcomment/createprojectcomment";

  // *************** Project Create ***************
  static const String getProjectCreateStep = "/api/project/getprojectcreateprojectstep";
  static const String getProjectCreateFaq = "/api/project/getprojectcreateprojectfaq";
  static const String getProjectCreateInformation = "/api/project/getprojectcreateprojectinformation";
  static const String getProjectCreateLeaderMember = "/api/project/getprojectcreateprojectleadermember";
  static const String getProjectCreateParticipantMembers = "/api/project/getprojectcreateprojectparticipantmembers";
  static const String getProjectCreateParticipantMemberById = "/api/project/getprojectcreateprojectparticipantmemberbymemberid";
  static const String getProjectCreateTeamMembers = "/api/project/getprojectcreateprojectteammembers";
  static const String getProjectCreateTeamMemberById = "/api/project/getprojectcreateprojectteammemberbymemberid";
  static const String getProjectCreateFundingInformations = "/api/project/getprojectcreatefundinginformations";
  static const String getProjectDocumentTypes = "/api/project/getprojectdocumenttypes";
  static const String getProjectCreateDocuments = "/api/project/getprojectcreateprojectdocuments";
  static const String getProjectStartEndDateInterval = "/api/project/getprojectstartenddateinterval";
  static const String upsertProjectInfo = "/api/project/upsertprojectinfo";
  static const String projectCreateMembersCheck = "/api/project/projectcreateprojectmemberscheck";
  static const String upsertProjectLeaderMember = "/api/project/upsertprojectleadermember";
  static const String upsertProjectParticipantMember = "/api/project/upsertprojectparticipantmember";
  static const String upsertProjectTeamMember = "/api/project/upsertprojectteammember";
  static const String updateProjectFundingInformation = "/api/project/updateprojectfundinginformation";
  static const String updateProjectStep = "/api/project/updateprojectstep";
  static const String upsertProjectDocument = "/api/project/upsertprojectdocument";
  static const String upsertProjectFaq = "/api/project/upsertprojectfaq";
  static const String sendProjectToReview = "/api/project/sendprojecttoreview";
  static const String deleteProjectMember = "/api/project/deleteprojectmember";
  static const String deleteProjectDocument = "/api/project/deleteprojectdocument";
  static const String getProjectEndDateToCloseDateInterval = "/api/project/getprojectenddatetoclosedateinterval";

  // *************** Project Create Dbit ***************
  static const String getProjectCreateStepDbit = "/api/projectdbit/getprojectcreateprojectstep";
  static const String getProjectCreateFaqDbit = "/api/projectdbit/getprojectcreateprojectfaq";
  static const String getProjectCreateInformationDbit = "/api/projectdbit/getprojectcreateprojectinformation";
  static const String getProjectCreateLeaderMemberDbit = "/api/projectdbit/getprojectcreateprojectleadermember";
  static const String getProjectCreateParticipantMembersDbit = "/api/projectdbit/getprojectcreateprojectparticipantmembers";
  static const String getProjectCreateParticipantMemberByIdDbit = "/api/projectdbit/getprojectcreateprojectparticipantmemberbymemberid";
  static const String getProjectCreateTeamMembersDbit = "/api/projectdbit/getprojectcreateprojectteammembers";
  static const String getProjectCreateTeamMemberByIdDbit = "/api/projectdbit/getprojectcreateprojectteammemberbymemberid";
  static const String getProjectCreateFundingInformationsDbit = "/api/projectdbit/getprojectcreatefundinginformations";
  static const String getProjectDocumentTypesDbit = "/api/projectdbit/getprojectdocumenttypes";
  static const String getProjectCreateDocumentsDbit = "/api/projectdbit/getprojectcreateprojectdocuments";
  static const String getProjectStartEndDateIntervalDbit = "/api/projectdbit/getprojectstartenddateinterval";
  static const String upsertProjectInfoDbit = "/api/projectdbit/upsertprojectinfo";
  static const String projectCreateMembersCheckDbit = "/api/projectdbit/projectcreateprojectmemberscheck";
  static const String upsertProjectLeaderMemberDbit = "/api/projectdbit/upsertprojectleadermember";
  static const String upsertProjectParticipantMemberDbit = "/api/projectdbit/upsertprojectparticipantmember";
  static const String upsertProjectTeamMemberDbit = "/api/projectdbit/upsertprojectteammember";
  static const String updateProjectFundingInformationDbit = "/api/projectdbit/updateprojectfundinginformation";
  static const String updateProjectStepDbit = "/api/projectdbit/updateprojectstep";
  static const String upsertProjectDocumentDbit = "/api/projectdbit/upsertprojectdocument";
  static const String upsertProjectFaqDbit = "/api/projectdbit/upsertprojectfaq";
  static const String sendProjectToReviewDbit = "/api/projectdbit/sendprojecttoreview";
  static const String deleteProjectMemberDbit = "/api/projectdbit/deleteprojectmember";
  static const String deleteProjectDocumentDbit = "/api/projectdbit/deleteprojectdocument";
  static const String getProjectEndDateToCloseDateIntervalDbit = "/api/projectdbit/getprojectenddatetoclosedateinterval";
  static const String upsertProjectHighlight = "/api/projectdbit/upsertprojecthighlight";
  static const String deleteProjectHighlight = "/api/projectdbit/deleteprojecthighlight";
  static const String getProjectCreateHighlights = "/api/projectdbit/getprojectcreatehighlights";
  static const String getProjectCreateHighlightsByProjectId = "/api/projectdbit/getprojectcreatehighlightsbyprojectid";
  static const String getProjectCreateHighlightsByPreviewKey = "/api/projectdbit/getprojectcreatehighlightsbypreviewkey";
  static const String getProjectHighlight = "/api/projectdbit/Getprojecthighlight";
  static const String upsertProjectTrophy = "/api/projectdbit/upsertprojecttrophy";
  static const String deleteProjectTrophy = "/api/projectdbit/deleteprojecttrophy";
  static const String getProjectCreateTrophies = "/api/projectdbit/getprojectcreatetrophies";
  static const String getProjectCreateTrophiesByProjectId = "/api/projectdbit/getprojectcreatetrophiesbyprojectid";
  static const String getProjectCreateTrophiesByPreviewKey = "/api/projectdbit/getprojectcreatetrophiesbypreviewkey";
  static const String getProjectTrophy = "/api/projectdbit/getprojecttrophy";
  static const String deleteInvestmentProjection = "/api/projectdbit/deleteivestmentprojection";
  static const String getInvestmentProjectionsByProjectId = "/api/projectdbit/getinvestmentprojectionsbyprojectid";
  static const String getInvestmentProjectionsByProjectPreviewKey = "/api/projectdbit/getinvestmentprojectionsbyprojectpreviewkey";
  static const String getInvestmentProjectionsByProjectExternalId = "/api/projectdbit/getinvestmentprojectionsbyprojectexternalid";
  static const String getProjectFinancialItemDefinitions = "/api/projectdbit/getprojectfinancialitemdefinations";
  static const String upsertProjectFinancial = "/api/projectdbit/upsertprojectfinancial";
  static const String deleteProjectFinancial = "/api/projectdbit/deleteprojectfinancial";
  static const String getProjectFinancialByProjectExternalId = "/api/projectdbit/getprojectfinancialbyprojectexternalid";
  static const String getProjectFinancialByProjectId = "/api/projectdbit/getprojectfinancialbyprojectid";
  static const String getProjectFinancialByProjectPreviewKey = "/api/projectdbit/getprojectfinancialbyprojectpreviewkey";
  static const String upsertProjectImageMedia = "/api/projectdbit/upsertprojectimagemedia";
  static const String upsertProjectVideoMedia = "/api/projectdbit/upsertprojectvideomedia";
  static const String getProjectMediaByProjectId = "/api/projectdbit/getprojectmediabyprojectid";
  static const String getProjectMediaByProjectPreviewKey = "/api/projectdbit/getprojectmediabyprojectpreviewkey";
  static const String getProjectMediaByProjectExternalId = "/api/projectdbit/getprojectmediabyprojectexternalid";
  static const String deleteProjectMedia = "/api/projectdbit/deleteprojectmedia";

  // *************** Project Debit ***************
  static const String getFilteredProjectsDbit = "/api/projectdbit/getfilteredprojects";
  static const String getProjectSummaryDbit = "/api/projectdbit/getprojectsummary";
  static const String getProjectAboutDbit = "/api/projectdbit/getprojectabout";
  static const String getProjectFundingInfoDbit = "/api/projectdbit/getprojectfundinginfo";
  static const String getProjectFundingInfoByPreviewKey = "/api/projectdbit/getprojectfundinginfobypreviewkey";
  static const String getProjectDetailsDbit = "/api/projectdbit/getprojectdetails";
  static const String getProjectInvestmentInfoDbit = "/api/projectdbit/getprojectinvestmentinfo";
  static const String getProjectSummaryByExternalIdDbit = "/api/projectdbit/getprojectsummarybyexternalid";
  static const String deleteProjectDbit = "/api/projectdbit/deleteproject";
  static const String profitCalculator = "/api/projectdbit/profitcalculator";
  static const String searchProjectsDbit = "/api/projectdbit/searchprojects";

  // *************** Project Document ***************
  static const String getProjectDocumentsDocument = "/api/projectdocument/getprojectdocuments";
  static const String getProjectInformationForm = "/api/projectdocument/getprojectinformationform";

  // *************** Project FAQ ***************
  static const String getProjectFaqFaq = "/api/projectfaq/getprojectfaq";

  // *************** Project Member ***************
  static const String getProjectTeam = "/api/projectmember/getprojectteam";

  // *************** Project Question Answer ***************
  static const String getProjectQuestionsForEntrepreneur = "/api/projectquestionanswer/getprojectquestionsforentrepreneur";
  static const String answerQuestion = "/api/projectquestionanswer/answerquestion";
  static const String createProjectQuestionAnswer = "/api/projectquestionanswer/createprojectquestionanswer";

  // *************** Project Update ***************
  static const String getProjectUpdatesUpdate = "/api/projectupdate/getprojectupdates";
  static const String getEntrepreneurProjectUpdates = "/api/projectupdate/getentrepreneurprojectupdates";
  static const String deleteProjectUpdate = "/api/projectupdate/deleteprojectupdate";
  static const String createProjectUpdate = "/api/projectupdate/createprojectupdate";

  // *************** Static Content ***************
  static const String getBanners = "/api/staticcontent/getbanners";
  static const String getPlatformStatistics = "/api/staticcontent/getplatformstatistics";
  static const String getCitiesByDefaultCountry = "/api/staticcontent/getcitiesbydefaultcountry";
  static const String getCities = "/api/staticcontent/getcities";
  static const String getDistricts = "/api/staticcontent/getdistricts";
  static const String getStaticContents = "/api/staticcontent/getstaticcontents";
  static const String getOtherStaticContents = "/api/staticcontent/getotherstaticcontents";
  static const String getStaticContentsByContentType = "/api/staticcontent/getstaticcontentsbycontenttype";
  static const String getStaticContentsLabelByContentType = "/api/staticcontent/getstaticcontentslabelbycontenttype";
  static const String getStaticContentDetails = "/api/staticcontent/getstaticcontentdetails";
  static const String getStaticContentBySeoNameDetails = "/api/staticcontent/getstaticcontentbyseonamedetails";
  static const String getPartnershipStructure = "/api/staticcontent/getpartnershipstructure";
  static const String getAnnouncements = "/api/staticcontent/getannouncements";
  static const String getAnnouncementsWithPageInfo = "/api/staticcontent/getannouncementswithpageinfo";
  static const String getFaqs = "/api/staticcontent/getfaqs";
  static const String getStakeholders = "/api/staticcontent/getstakeholders";
  static const String getPlatformContactInformations = "/api/staticcontent/getplatformcontactinformations";
  static const String getInvestmentDescriptions = "/api/staticcontent/getinvestmentdescriptions";
  static const String getStaticContentAttachmentBySeoName = "/api/staticcontent/getstaticcontentattachmentbyseoname";
  static const String getInvestorInterestDefinitions = "/api/staticcontent/getinvestorinterestdefinitions";

  // *************** Storage ***************
  // Özel parametre gerektiren endpoint: örneğin, path parametresi
  static const String uploadFile = "/api/file/uploadfile";
  static const String getFile = "/api/file/getfile"; // Kullanım: "$getFile/{path}"

  // *************** Two Factor ***************
  static const String updateTwoFactor = "/api/twofactor/updatetwofactor";

  // *************** User Verification ***************
  static const String checkUserVerification = "/api/userverification/checkuserverification";
}
