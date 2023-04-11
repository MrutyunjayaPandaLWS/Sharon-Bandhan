

import Foundation
struct LstCustomerJson : Codable {
	let accountComStatus : Int?
	let accountNumber : String?
	let accountStatus : String?
	let accountType : String?
	let accountTypeID : Int?
	let acountHolderName : String?
	let address1 : String?
	let address2 : String?
	let addressId : Int?
	let addressLatitude : String?
	let addressLongitude : String?
	let ageGroupId : Int?
	let anniversary : String?
	let areaId : Int?
	let autoAccountType : String?
	let autoBankCounty : String?
	let autoBankPostCode : String?
	let bankAddress : String?
	let bankBranch : String?
	let bankCity : String?
	let bankCode : String?
	let bankCountryId : Int?
	let bankCountryName : String?
	let bankName : String?
	let bankPassbookImage : String?
	let bicSwiftCode : String?
	let branchCode : String?
	let bsbAbaRoutingNumber : String?
	let chassisNumber : String?
	let cityId : Int?
	let cityName : String?
	let company : String?
	let contractFileName : String?
	let contractId : Int?
	let contractName : String?
	let countryId : Int?
	let countryName : String?
	let currency : String?
	let currencyId : Int?
	let custFamilyId : Int?
	let customerCategoryId : Int?
	let customerDetailId : Int?
	let customerGrade : String?
	let customerId : Int?
	let customerRelationshipId : Int?
	let customerRemarks : String?
	let customerType : String?
	let customerTypeID : Int?
	let customerTypeId : Int?
	let customer_Grade_ID : Int?
	let dOB : String?
	let displayImage : String?
	let district : String?
	let districtId : Int?
	let districtName : String?
	let domain : String?
	let email : String?
	let emailStatus : Int?
	let engineNumber : String?
	let enrollmentReferenceNumber : String?
	let executiveName : String?
	let familyMemberBirthday : String?
	let familyMemberName : String?
	let firstName : String?
	let gender : String?
	let iFSCCode : String?
	let ibanNumber : String?
	let identificationNo : String?
	let identificationOthers : String?
	let incomeRangeId : Int?
	let insuranceRenewalAmount : Int?
	let invoiceAmount : String?
	let invoiceNo : String?
	let isActive : Int?
	let isBankPassbookNewImage : Bool?
	let isBlackListed : Bool?
	let isGradeVerified : Bool?
	let isSmartphoneUser : Bool?
	let isUpdatePassword : Bool?
	let isVerified : Int?
	let isVinChassis_Active : String?
	let isWhatsappUser : Bool?
	let jAnniversary : String?
	let jCreatedDate : String?
	let jDOB : String?
	let jD_InvoiceNo : String?
	let jDateOfSale : String?
	let jEnrollmentReferenceDate : String?
	let jInsuranceExpDate : String?
	let jJD_InvoiceDate : String?
	let jPolicyDate : String?
	let lIdentificationType : Int?
	let laborAmount : Int?
	let landmark : String?
	let languageId : Int?
	let languageName : String?
	let lastName : String?
	let locality : String?
	let locationCode : String?
	let locationId : Int?
	let locationName : String?
	let loyaltyId : String?
	let loyaltyIdAutoGen : Bool?
	let maritalStatus : String?
	let merchantId : Int?
	let mobile : String?
	let mobileNumberLimitation : Int?
	let mobilePrefix : String?
	let mobile_Two : String?
	let modelNumber : String?
	let nativeCountryId : Int?
	let nativeStateId : Int?
	let nativeStateName : String?
	let nominee : String?
	let nomineeDOB : String?
	let parentCustomerId : Int?
	let password : String?
	let payOut : Int?
	let plainPassword : String?
	let policyNumber : String?
	let professionId : Int?
	let profilePicture : String?
	let rELATED_PROJECT_TYPE : String?
	let recipientPhonenumber : String?
	let recipientType : String?
	let referedBy : String?
	let referralCode : String?
	let regStatus : Int?
	let regType : String?
	let registrationSource : Int?
	let relationship : String?
	let religionID : Int?
	let remarks : String?
	let stateId : Int?
	let stateName : String?
	let talukId : Int?
	let talukName : String?
	let taxId : String?
	let tehsilBlockMandal : String?
	let title : String?
	let tradeLicence : String?
	let userId : Int?
	let vehicleBrand : String?
	let vehicleID : Int?
	let vehicleNumber : String?
	let vehicleType : String?
	let verifiedStatus : String?
	let village : String?
	let walletNumber : String?
	let whatsAppNumber : String?
	let zip : String?
	let bankAccountVerifiedStatus : Int?

	enum CodingKeys: String, CodingKey {

		case accountComStatus = "AccountComStatus"
		case accountNumber = "AccountNumber"
		case accountStatus = "AccountStatus"
		case accountType = "AccountType"
		case accountTypeID = "AccountTypeID"
		case acountHolderName = "AcountHolderName"
		case address1 = "Address1"
		case address2 = "Address2"
		case addressId = "AddressId"
		case addressLatitude = "AddressLatitude"
		case addressLongitude = "AddressLongitude"
		case ageGroupId = "AgeGroupId"
		case anniversary = "Anniversary"
		case areaId = "AreaId"
		case autoAccountType = "AutoAccountType"
		case autoBankCounty = "AutoBankCounty"
		case autoBankPostCode = "AutoBankPostCode"
		case bankAddress = "BankAddress"
		case bankBranch = "BankBranch"
		case bankCity = "BankCity"
		case bankCode = "BankCode"
		case bankCountryId = "BankCountryId"
		case bankCountryName = "BankCountryName"
		case bankName = "BankName"
		case bankPassbookImage = "BankPassbookImage"
		case bicSwiftCode = "BicSwiftCode"
		case branchCode = "BranchCode"
		case bsbAbaRoutingNumber = "BsbAbaRoutingNumber"
		case chassisNumber = "ChassisNumber"
		case cityId = "CityId"
		case cityName = "CityName"
		case company = "Company"
		case contractFileName = "ContractFileName"
		case contractId = "ContractId"
		case contractName = "ContractName"
		case countryId = "CountryId"
		case countryName = "CountryName"
		case currency = "Currency"
		case currencyId = "CurrencyId"
		case custFamilyId = "CustFamilyId"
		case customerCategoryId = "CustomerCategoryId"
		case customerDetailId = "CustomerDetailId"
		case customerGrade = "CustomerGrade"
		case customerId = "CustomerId"
		case customerRelationshipId = "CustomerRelationshipId"
		case customerRemarks = "CustomerRemarks"
		case customerType = "CustomerType"
		case customerTypeID = "CustomerTypeID"
		case customerTypeId = "CustomerTypeId"
		case customer_Grade_ID = "Customer_Grade_ID"
		case dOB = "DOB"
		case displayImage = "DisplayImage"
		case district = "District"
		case districtId = "DistrictId"
		case districtName = "DistrictName"
		case domain = "Domain"
		case email = "Email"
		case emailStatus = "EmailStatus"
		case engineNumber = "EngineNumber"
		case enrollmentReferenceNumber = "EnrollmentReferenceNumber"
		case executiveName = "ExecutiveName"
		case familyMemberBirthday = "FamilyMemberBirthday"
		case familyMemberName = "FamilyMemberName"
		case firstName = "FirstName"
		case gender = "Gender"
		case iFSCCode = "IFSCCode"
		case ibanNumber = "IbanNumber"
		case identificationNo = "IdentificationNo"
		case identificationOthers = "IdentificationOthers"
		case incomeRangeId = "IncomeRangeId"
		case insuranceRenewalAmount = "InsuranceRenewalAmount"
		case invoiceAmount = "InvoiceAmount"
		case invoiceNo = "InvoiceNo"
		case isActive = "IsActive"
		case isBankPassbookNewImage = "IsBankPassbookNewImage"
		case isBlackListed = "IsBlackListed"
		case isGradeVerified = "IsGradeVerified"
		case isSmartphoneUser = "IsSmartphoneUser"
		case isUpdatePassword = "IsUpdatePassword"
		case isVerified = "IsVerified"
		case isVinChassis_Active = "IsVinChassis_Active"
		case isWhatsappUser = "IsWhatsappUser"
		case jAnniversary = "JAnniversary"
		case jCreatedDate = "JCreatedDate"
		case jDOB = "JDOB"
		case jD_InvoiceNo = "JD_InvoiceNo"
		case jDateOfSale = "JDateOfSale"
		case jEnrollmentReferenceDate = "JEnrollmentReferenceDate"
		case jInsuranceExpDate = "JInsuranceExpDate"
		case jJD_InvoiceDate = "JJD_InvoiceDate"
		case jPolicyDate = "JPolicyDate"
		case lIdentificationType = "LIdentificationType"
		case laborAmount = "LaborAmount"
		case landmark = "Landmark"
		case languageId = "LanguageId"
		case languageName = "LanguageName"
		case lastName = "LastName"
		case locality = "Locality"
		case locationCode = "LocationCode"
		case locationId = "LocationId"
		case locationName = "LocationName"
		case loyaltyId = "LoyaltyId"
		case loyaltyIdAutoGen = "LoyaltyIdAutoGen"
		case maritalStatus = "MaritalStatus"
		case merchantId = "MerchantId"
		case mobile = "Mobile"
		case mobileNumberLimitation = "MobileNumberLimitation"
		case mobilePrefix = "MobilePrefix"
		case mobile_Two = "Mobile_Two"
		case modelNumber = "ModelNumber"
		case nativeCountryId = "NativeCountryId"
		case nativeStateId = "NativeStateId"
		case nativeStateName = "NativeStateName"
		case nominee = "Nominee"
		case nomineeDOB = "NomineeDOB"
		case parentCustomerId = "ParentCustomerId"
		case password = "Password"
		case payOut = "PayOut"
		case plainPassword = "PlainPassword"
		case policyNumber = "PolicyNumber"
		case professionId = "ProfessionId"
		case profilePicture = "ProfilePicture"
		case rELATED_PROJECT_TYPE = "RELATED_PROJECT_TYPE"
		case recipientPhonenumber = "RecipientPhonenumber"
		case recipientType = "RecipientType"
		case referedBy = "ReferedBy"
		case referralCode = "ReferralCode"
		case regStatus = "RegStatus"
		case regType = "RegType"
		case registrationSource = "RegistrationSource"
		case relationship = "Relationship"
		case religionID = "ReligionID"
		case remarks = "Remarks"
		case stateId = "StateId"
		case stateName = "StateName"
		case talukId = "TalukId"
		case talukName = "TalukName"
		case taxId = "TaxId"
		case tehsilBlockMandal = "TehsilBlockMandal"
		case title = "Title"
		case tradeLicence = "TradeLicence"
		case userId = "UserId"
		case vehicleBrand = "VehicleBrand"
		case vehicleID = "VehicleID"
		case vehicleNumber = "VehicleNumber"
		case vehicleType = "VehicleType"
		case verifiedStatus = "VerifiedStatus"
		case village = "Village"
		case walletNumber = "WalletNumber"
		case whatsAppNumber = "WhatsAppNumber"
		case zip = "Zip"
		case bankAccountVerifiedStatus = "bankAccountVerifiedStatus"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		accountComStatus = try values.decodeIfPresent(Int.self, forKey: .accountComStatus)
		accountNumber = try values.decodeIfPresent(String.self, forKey: .accountNumber)
		accountStatus = try values.decodeIfPresent(String.self, forKey: .accountStatus)
		accountType = try values.decodeIfPresent(String.self, forKey: .accountType)
		accountTypeID = try values.decodeIfPresent(Int.self, forKey: .accountTypeID)
		acountHolderName = try values.decodeIfPresent(String.self, forKey: .acountHolderName)
		address1 = try values.decodeIfPresent(String.self, forKey: .address1)
		address2 = try values.decodeIfPresent(String.self, forKey: .address2)
		addressId = try values.decodeIfPresent(Int.self, forKey: .addressId)
		addressLatitude = try values.decodeIfPresent(String.self, forKey: .addressLatitude)
		addressLongitude = try values.decodeIfPresent(String.self, forKey: .addressLongitude)
		ageGroupId = try values.decodeIfPresent(Int.self, forKey: .ageGroupId)
		anniversary = try values.decodeIfPresent(String.self, forKey: .anniversary)
		areaId = try values.decodeIfPresent(Int.self, forKey: .areaId)
		autoAccountType = try values.decodeIfPresent(String.self, forKey: .autoAccountType)
		autoBankCounty = try values.decodeIfPresent(String.self, forKey: .autoBankCounty)
		autoBankPostCode = try values.decodeIfPresent(String.self, forKey: .autoBankPostCode)
		bankAddress = try values.decodeIfPresent(String.self, forKey: .bankAddress)
		bankBranch = try values.decodeIfPresent(String.self, forKey: .bankBranch)
		bankCity = try values.decodeIfPresent(String.self, forKey: .bankCity)
		bankCode = try values.decodeIfPresent(String.self, forKey: .bankCode)
		bankCountryId = try values.decodeIfPresent(Int.self, forKey: .bankCountryId)
		bankCountryName = try values.decodeIfPresent(String.self, forKey: .bankCountryName)
		bankName = try values.decodeIfPresent(String.self, forKey: .bankName)
		bankPassbookImage = try values.decodeIfPresent(String.self, forKey: .bankPassbookImage)
		bicSwiftCode = try values.decodeIfPresent(String.self, forKey: .bicSwiftCode)
		branchCode = try values.decodeIfPresent(String.self, forKey: .branchCode)
		bsbAbaRoutingNumber = try values.decodeIfPresent(String.self, forKey: .bsbAbaRoutingNumber)
		chassisNumber = try values.decodeIfPresent(String.self, forKey: .chassisNumber)
		cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
		company = try values.decodeIfPresent(String.self, forKey: .company)
		contractFileName = try values.decodeIfPresent(String.self, forKey: .contractFileName)
		contractId = try values.decodeIfPresent(Int.self, forKey: .contractId)
		contractName = try values.decodeIfPresent(String.self, forKey: .contractName)
		countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
		countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		currencyId = try values.decodeIfPresent(Int.self, forKey: .currencyId)
		custFamilyId = try values.decodeIfPresent(Int.self, forKey: .custFamilyId)
		customerCategoryId = try values.decodeIfPresent(Int.self, forKey: .customerCategoryId)
		customerDetailId = try values.decodeIfPresent(Int.self, forKey: .customerDetailId)
		customerGrade = try values.decodeIfPresent(String.self, forKey: .customerGrade)
		customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
		customerRelationshipId = try values.decodeIfPresent(Int.self, forKey: .customerRelationshipId)
		customerRemarks = try values.decodeIfPresent(String.self, forKey: .customerRemarks)
		customerType = try values.decodeIfPresent(String.self, forKey: .customerType)
		customerTypeID = try values.decodeIfPresent(Int.self, forKey: .customerTypeID)
		customerTypeId = try values.decodeIfPresent(Int.self, forKey: .customerTypeId)
		customer_Grade_ID = try values.decodeIfPresent(Int.self, forKey: .customer_Grade_ID)
		dOB = try values.decodeIfPresent(String.self, forKey: .dOB)
		displayImage = try values.decodeIfPresent(String.self, forKey: .displayImage)
		district = try values.decodeIfPresent(String.self, forKey: .district)
		districtId = try values.decodeIfPresent(Int.self, forKey: .districtId)
		districtName = try values.decodeIfPresent(String.self, forKey: .districtName)
		domain = try values.decodeIfPresent(String.self, forKey: .domain)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		emailStatus = try values.decodeIfPresent(Int.self, forKey: .emailStatus)
		engineNumber = try values.decodeIfPresent(String.self, forKey: .engineNumber)
		enrollmentReferenceNumber = try values.decodeIfPresent(String.self, forKey: .enrollmentReferenceNumber)
		executiveName = try values.decodeIfPresent(String.self, forKey: .executiveName)
		familyMemberBirthday = try values.decodeIfPresent(String.self, forKey: .familyMemberBirthday)
		familyMemberName = try values.decodeIfPresent(String.self, forKey: .familyMemberName)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		gender = try values.decodeIfPresent(String.self, forKey: .gender)
		iFSCCode = try values.decodeIfPresent(String.self, forKey: .iFSCCode)
		ibanNumber = try values.decodeIfPresent(String.self, forKey: .ibanNumber)
		identificationNo = try values.decodeIfPresent(String.self, forKey: .identificationNo)
		identificationOthers = try values.decodeIfPresent(String.self, forKey: .identificationOthers)
		incomeRangeId = try values.decodeIfPresent(Int.self, forKey: .incomeRangeId)
		insuranceRenewalAmount = try values.decodeIfPresent(Int.self, forKey: .insuranceRenewalAmount)
		invoiceAmount = try values.decodeIfPresent(String.self, forKey: .invoiceAmount)
		invoiceNo = try values.decodeIfPresent(String.self, forKey: .invoiceNo)
		isActive = try values.decodeIfPresent(Int.self, forKey: .isActive)
		isBankPassbookNewImage = try values.decodeIfPresent(Bool.self, forKey: .isBankPassbookNewImage)
		isBlackListed = try values.decodeIfPresent(Bool.self, forKey: .isBlackListed)
		isGradeVerified = try values.decodeIfPresent(Bool.self, forKey: .isGradeVerified)
		isSmartphoneUser = try values.decodeIfPresent(Bool.self, forKey: .isSmartphoneUser)
		isUpdatePassword = try values.decodeIfPresent(Bool.self, forKey: .isUpdatePassword)
		isVerified = try values.decodeIfPresent(Int.self, forKey: .isVerified)
		isVinChassis_Active = try values.decodeIfPresent(String.self, forKey: .isVinChassis_Active)
		isWhatsappUser = try values.decodeIfPresent(Bool.self, forKey: .isWhatsappUser)
		jAnniversary = try values.decodeIfPresent(String.self, forKey: .jAnniversary)
		jCreatedDate = try values.decodeIfPresent(String.self, forKey: .jCreatedDate)
		jDOB = try values.decodeIfPresent(String.self, forKey: .jDOB)
		jD_InvoiceNo = try values.decodeIfPresent(String.self, forKey: .jD_InvoiceNo)
		jDateOfSale = try values.decodeIfPresent(String.self, forKey: .jDateOfSale)
		jEnrollmentReferenceDate = try values.decodeIfPresent(String.self, forKey: .jEnrollmentReferenceDate)
		jInsuranceExpDate = try values.decodeIfPresent(String.self, forKey: .jInsuranceExpDate)
		jJD_InvoiceDate = try values.decodeIfPresent(String.self, forKey: .jJD_InvoiceDate)
		jPolicyDate = try values.decodeIfPresent(String.self, forKey: .jPolicyDate)
		lIdentificationType = try values.decodeIfPresent(Int.self, forKey: .lIdentificationType)
		laborAmount = try values.decodeIfPresent(Int.self, forKey: .laborAmount)
		landmark = try values.decodeIfPresent(String.self, forKey: .landmark)
		languageId = try values.decodeIfPresent(Int.self, forKey: .languageId)
		languageName = try values.decodeIfPresent(String.self, forKey: .languageName)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		locality = try values.decodeIfPresent(String.self, forKey: .locality)
		locationCode = try values.decodeIfPresent(String.self, forKey: .locationCode)
		locationId = try values.decodeIfPresent(Int.self, forKey: .locationId)
		locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		loyaltyIdAutoGen = try values.decodeIfPresent(Bool.self, forKey: .loyaltyIdAutoGen)
		maritalStatus = try values.decodeIfPresent(String.self, forKey: .maritalStatus)
		merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		mobileNumberLimitation = try values.decodeIfPresent(Int.self, forKey: .mobileNumberLimitation)
		mobilePrefix = try values.decodeIfPresent(String.self, forKey: .mobilePrefix)
		mobile_Two = try values.decodeIfPresent(String.self, forKey: .mobile_Two)
		modelNumber = try values.decodeIfPresent(String.self, forKey: .modelNumber)
		nativeCountryId = try values.decodeIfPresent(Int.self, forKey: .nativeCountryId)
		nativeStateId = try values.decodeIfPresent(Int.self, forKey: .nativeStateId)
		nativeStateName = try values.decodeIfPresent(String.self, forKey: .nativeStateName)
		nominee = try values.decodeIfPresent(String.self, forKey: .nominee)
		nomineeDOB = try values.decodeIfPresent(String.self, forKey: .nomineeDOB)
		parentCustomerId = try values.decodeIfPresent(Int.self, forKey: .parentCustomerId)
		password = try values.decodeIfPresent(String.self, forKey: .password)
		payOut = try values.decodeIfPresent(Int.self, forKey: .payOut)
		plainPassword = try values.decodeIfPresent(String.self, forKey: .plainPassword)
		policyNumber = try values.decodeIfPresent(String.self, forKey: .policyNumber)
		professionId = try values.decodeIfPresent(Int.self, forKey: .professionId)
		profilePicture = try values.decodeIfPresent(String.self, forKey: .profilePicture)
		rELATED_PROJECT_TYPE = try values.decodeIfPresent(String.self, forKey: .rELATED_PROJECT_TYPE)
		recipientPhonenumber = try values.decodeIfPresent(String.self, forKey: .recipientPhonenumber)
		recipientType = try values.decodeIfPresent(String.self, forKey: .recipientType)
		referedBy = try values.decodeIfPresent(String.self, forKey: .referedBy)
		referralCode = try values.decodeIfPresent(String.self, forKey: .referralCode)
		regStatus = try values.decodeIfPresent(Int.self, forKey: .regStatus)
		regType = try values.decodeIfPresent(String.self, forKey: .regType)
		registrationSource = try values.decodeIfPresent(Int.self, forKey: .registrationSource)
		relationship = try values.decodeIfPresent(String.self, forKey: .relationship)
		religionID = try values.decodeIfPresent(Int.self, forKey: .religionID)
		remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
		stateId = try values.decodeIfPresent(Int.self, forKey: .stateId)
		stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
		talukId = try values.decodeIfPresent(Int.self, forKey: .talukId)
		talukName = try values.decodeIfPresent(String.self, forKey: .talukName)
		taxId = try values.decodeIfPresent(String.self, forKey: .taxId)
		tehsilBlockMandal = try values.decodeIfPresent(String.self, forKey: .tehsilBlockMandal)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		tradeLicence = try values.decodeIfPresent(String.self, forKey: .tradeLicence)
		userId = try values.decodeIfPresent(Int.self, forKey: .userId)
		vehicleBrand = try values.decodeIfPresent(String.self, forKey: .vehicleBrand)
		vehicleID = try values.decodeIfPresent(Int.self, forKey: .vehicleID)
		vehicleNumber = try values.decodeIfPresent(String.self, forKey: .vehicleNumber)
		vehicleType = try values.decodeIfPresent(String.self, forKey: .vehicleType)
		verifiedStatus = try values.decodeIfPresent(String.self, forKey: .verifiedStatus)
		village = try values.decodeIfPresent(String.self, forKey: .village)
		walletNumber = try values.decodeIfPresent(String.self, forKey: .walletNumber)
		whatsAppNumber = try values.decodeIfPresent(String.self, forKey: .whatsAppNumber)
		zip = try values.decodeIfPresent(String.self, forKey: .zip)
		bankAccountVerifiedStatus = try values.decodeIfPresent(Int.self, forKey: .bankAccountVerifiedStatus)
	}

}
