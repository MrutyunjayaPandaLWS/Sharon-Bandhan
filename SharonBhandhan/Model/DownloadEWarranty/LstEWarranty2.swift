

import Foundation
struct LstEWarranty2 : Codable {
	let accessedDate : String?
	let address : String?
	let areaId : Int?
	let areaName : String?
	let brandId : Int?
	let brandName : String?
	let cityId : Int?
	let cityName : String?
	let contractorName : String?
	let createdBy : String?
	let customerActiveStatus : String?
	let customerID : Int?
	let customerName : String?
	let eWarrantyDate : String?
	let eWarrantyID : Int?
	let eWarrantyQty : Int?
	let emailId : String?
	let enrolledDate : String?
	let generatorEmailId : String?
	let generatorMobile : String?
	let generatorName : String?
	let isEWarrantyGenerated : String?
	let loyaltyId : String?
	let memberType : String?
	let mobileNum : String?
	let monthOfScanning : String?
	let prodWarrantyDesc : String?
	let productId : Int?
	let productName : String?
	let scannedCode : String?
	let size : String?
	let state : String?
	let subHelpTopicId : Int?
	let successQRCount : Int?
	let thickness : String?
	let total_Row : Int?
	let warrantyFilePath : String?

	enum CodingKeys: String, CodingKey {

		case accessedDate = "AccessedDate"
		case address = "Address"
		case areaId = "AreaId"
		case areaName = "AreaName"
		case brandId = "BrandId"
		case brandName = "BrandName"
		case cityId = "CityId"
		case cityName = "CityName"
		case contractorName = "ContractorName"
		case createdBy = "CreatedBy"
		case customerActiveStatus = "CustomerActiveStatus"
		case customerID = "CustomerID"
		case customerName = "CustomerName"
		case eWarrantyDate = "EWarrantyDate"
		case eWarrantyID = "EWarrantyID"
		case eWarrantyQty = "EWarrantyQty"
		case emailId = "EmailId"
		case enrolledDate = "EnrolledDate"
		case generatorEmailId = "GeneratorEmailId"
		case generatorMobile = "GeneratorMobile"
		case generatorName = "GeneratorName"
		case isEWarrantyGenerated = "IsEWarrantyGenerated"
		case loyaltyId = "LoyaltyId"
		case memberType = "MemberType"
		case mobileNum = "MobileNum"
		case monthOfScanning = "MonthOfScanning"
		case prodWarrantyDesc = "ProdWarrantyDesc"
		case productId = "ProductId"
		case productName = "ProductName"
		case scannedCode = "ScannedCode"
		case size = "Size"
		case state = "State"
		case subHelpTopicId = "SubHelpTopicId"
		case successQRCount = "SuccessQRCount"
		case thickness = "Thickness"
		case total_Row = "Total_Row"
		case warrantyFilePath = "WarrantyFilePath"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		accessedDate = try values.decodeIfPresent(String.self, forKey: .accessedDate)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		areaId = try values.decodeIfPresent(Int.self, forKey: .areaId)
		areaName = try values.decodeIfPresent(String.self, forKey: .areaName)
		brandId = try values.decodeIfPresent(Int.self, forKey: .brandId)
		brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
		cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
		contractorName = try values.decodeIfPresent(String.self, forKey: .contractorName)
		createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
		customerActiveStatus = try values.decodeIfPresent(String.self, forKey: .customerActiveStatus)
		customerID = try values.decodeIfPresent(Int.self, forKey: .customerID)
		customerName = try values.decodeIfPresent(String.self, forKey: .customerName)
		eWarrantyDate = try values.decodeIfPresent(String.self, forKey: .eWarrantyDate)
		eWarrantyID = try values.decodeIfPresent(Int.self, forKey: .eWarrantyID)
		eWarrantyQty = try values.decodeIfPresent(Int.self, forKey: .eWarrantyQty)
		emailId = try values.decodeIfPresent(String.self, forKey: .emailId)
		enrolledDate = try values.decodeIfPresent(String.self, forKey: .enrolledDate)
		generatorEmailId = try values.decodeIfPresent(String.self, forKey: .generatorEmailId)
		generatorMobile = try values.decodeIfPresent(String.self, forKey: .generatorMobile)
		generatorName = try values.decodeIfPresent(String.self, forKey: .generatorName)
		isEWarrantyGenerated = try values.decodeIfPresent(String.self, forKey: .isEWarrantyGenerated)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		memberType = try values.decodeIfPresent(String.self, forKey: .memberType)
		mobileNum = try values.decodeIfPresent(String.self, forKey: .mobileNum)
		monthOfScanning = try values.decodeIfPresent(String.self, forKey: .monthOfScanning)
		prodWarrantyDesc = try values.decodeIfPresent(String.self, forKey: .prodWarrantyDesc)
		productId = try values.decodeIfPresent(Int.self, forKey: .productId)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		scannedCode = try values.decodeIfPresent(String.self, forKey: .scannedCode)
		size = try values.decodeIfPresent(String.self, forKey: .size)
		state = try values.decodeIfPresent(String.self, forKey: .state)
		subHelpTopicId = try values.decodeIfPresent(Int.self, forKey: .subHelpTopicId)
		successQRCount = try values.decodeIfPresent(Int.self, forKey: .successQRCount)
		thickness = try values.decodeIfPresent(String.self, forKey: .thickness)
		total_Row = try values.decodeIfPresent(Int.self, forKey: .total_Row)
		warrantyFilePath = try values.decodeIfPresent(String.self, forKey: .warrantyFilePath)
	}

}
