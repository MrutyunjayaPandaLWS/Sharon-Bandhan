

import Foundation
struct LstCustomerOfficalInfoJson : Codable {
	let cityId : Int?
	let cityName : String?
	let companyName : String?
	let countryId : Int?
	let countryName : String?
	let departmentIdOfficial : Int?
	let designation : String?
	let designationIdOfficial : Int?
	let firmAddress : String?
	let firmMobile : String?
	let firmSize : String?
	let firmTypeID : Int?
	let firmTypeName : String?
	let gSTNumber : String?
	let incorporationDate : String?
	let industryID : Int?
	let jobTypeID : Int?
	let jobTypeName : String?
	let officalEmail : String?
	let ownerName : String?
	let phoneOffice : String?
	let phoneResidence : String?
	let sAPCode : String?
	let stateId : Int?
	let stateName : String?
	let stdCode : String?
	let storeName : String?
	let targetCreditPeriod : Int?
	let targetValue : Int?
	let venderCode : String?
	let zip : String?

	enum CodingKeys: String, CodingKey {

		case cityId = "CityId"
		case cityName = "CityName"
		case companyName = "CompanyName"
		case countryId = "CountryId"
		case countryName = "CountryName"
		case departmentIdOfficial = "DepartmentIdOfficial"
		case designation = "Designation"
		case designationIdOfficial = "DesignationIdOfficial"
		case firmAddress = "FirmAddress"
		case firmMobile = "FirmMobile"
		case firmSize = "FirmSize"
		case firmTypeID = "FirmTypeID"
		case firmTypeName = "FirmTypeName"
		case gSTNumber = "GSTNumber"
		case incorporationDate = "IncorporationDate"
		case industryID = "IndustryID"
		case jobTypeID = "JobTypeID"
		case jobTypeName = "JobTypeName"
		case officalEmail = "OfficalEmail"
		case ownerName = "OwnerName"
		case phoneOffice = "PhoneOffice"
		case phoneResidence = "PhoneResidence"
		case sAPCode = "SAPCode"
		case stateId = "StateId"
		case stateName = "StateName"
		case stdCode = "StdCode"
		case storeName = "StoreName"
		case targetCreditPeriod = "TargetCreditPeriod"
		case targetValue = "TargetValue"
		case venderCode = "VenderCode"
		case zip = "Zip"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
		companyName = try values.decodeIfPresent(String.self, forKey: .companyName)
		countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
		countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
		departmentIdOfficial = try values.decodeIfPresent(Int.self, forKey: .departmentIdOfficial)
		designation = try values.decodeIfPresent(String.self, forKey: .designation)
		designationIdOfficial = try values.decodeIfPresent(Int.self, forKey: .designationIdOfficial)
		firmAddress = try values.decodeIfPresent(String.self, forKey: .firmAddress)
		firmMobile = try values.decodeIfPresent(String.self, forKey: .firmMobile)
		firmSize = try values.decodeIfPresent(String.self, forKey: .firmSize)
		firmTypeID = try values.decodeIfPresent(Int.self, forKey: .firmTypeID)
		firmTypeName = try values.decodeIfPresent(String.self, forKey: .firmTypeName)
		gSTNumber = try values.decodeIfPresent(String.self, forKey: .gSTNumber)
		incorporationDate = try values.decodeIfPresent(String.self, forKey: .incorporationDate)
		industryID = try values.decodeIfPresent(Int.self, forKey: .industryID)
		jobTypeID = try values.decodeIfPresent(Int.self, forKey: .jobTypeID)
		jobTypeName = try values.decodeIfPresent(String.self, forKey: .jobTypeName)
		officalEmail = try values.decodeIfPresent(String.self, forKey: .officalEmail)
		ownerName = try values.decodeIfPresent(String.self, forKey: .ownerName)
		phoneOffice = try values.decodeIfPresent(String.self, forKey: .phoneOffice)
		phoneResidence = try values.decodeIfPresent(String.self, forKey: .phoneResidence)
		sAPCode = try values.decodeIfPresent(String.self, forKey: .sAPCode)
		stateId = try values.decodeIfPresent(Int.self, forKey: .stateId)
		stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
		stdCode = try values.decodeIfPresent(String.self, forKey: .stdCode)
		storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
		targetCreditPeriod = try values.decodeIfPresent(Int.self, forKey: .targetCreditPeriod)
		targetValue = try values.decodeIfPresent(Int.self, forKey: .targetValue)
		venderCode = try values.decodeIfPresent(String.self, forKey: .venderCode)
		zip = try values.decodeIfPresent(String.self, forKey: .zip)
	}

}
