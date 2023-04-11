

import Foundation
struct LstEWarranty : Codable {
	let address : String?
	let areaId : Int?
	let areaName : String?
	let brandId : Int?
	let brandName : String?
	let cityId : Int?
	let cityName : String?
	let contractorName : String?
	let createdBy : String?
	let customerID : Int?
	let customerName : String?
	let eWarrantyDate : String?
	let eWarrantyID : Int?
	let eWarrantyQty : Int?
	let emailId : String?
	let generatorEmailId : String?
	let generatorMobile : String?
	let loyaltyId : String?
	let mobileNum : String?
	let monthOfScanning : String?
	let prodWarrantyDesc : String?
	let productId : Int?
	let productName : String?
	let scannedCode : String?
	let subHelpTopicId : Int?
	let successQRCount : Int?
	let total_Row : Int?
	let warrantyFilePath : String?
    var textAdded = 0
    var noOfQty = 0

	enum CodingKeys: String, CodingKey {

		case address = "Address"
		case areaId = "AreaId"
		case areaName = "AreaName"
		case brandId = "BrandId"
		case brandName = "BrandName"
		case cityId = "CityId"
		case cityName = "CityName"
		case contractorName = "ContractorName"
		case createdBy = "CreatedBy"
		case customerID = "CustomerID"
		case customerName = "CustomerName"
		case eWarrantyDate = "EWarrantyDate"
		case eWarrantyID = "EWarrantyID"
		case eWarrantyQty = "EWarrantyQty"
		case emailId = "EmailId"
		case generatorEmailId = "GeneratorEmailId"
		case generatorMobile = "GeneratorMobile"
		case loyaltyId = "LoyaltyId"
		case mobileNum = "MobileNum"
		case monthOfScanning = "MonthOfScanning"
		case prodWarrantyDesc = "ProdWarrantyDesc"
		case productId = "ProductId"
		case productName = "ProductName"
		case scannedCode = "ScannedCode"
		case subHelpTopicId = "SubHelpTopicId"
		case successQRCount = "SuccessQRCount"
		case total_Row = "Total_Row"
		case warrantyFilePath = "WarrantyFilePath"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		areaId = try values.decodeIfPresent(Int.self, forKey: .areaId)
		areaName = try values.decodeIfPresent(String.self, forKey: .areaName)
		brandId = try values.decodeIfPresent(Int.self, forKey: .brandId)
		brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
		cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
		contractorName = try values.decodeIfPresent(String.self, forKey: .contractorName)
		createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
		customerID = try values.decodeIfPresent(Int.self, forKey: .customerID)
		customerName = try values.decodeIfPresent(String.self, forKey: .customerName)
		eWarrantyDate = try values.decodeIfPresent(String.self, forKey: .eWarrantyDate)
		eWarrantyID = try values.decodeIfPresent(Int.self, forKey: .eWarrantyID)
		eWarrantyQty = try values.decodeIfPresent(Int.self, forKey: .eWarrantyQty)
		emailId = try values.decodeIfPresent(String.self, forKey: .emailId)
		generatorEmailId = try values.decodeIfPresent(String.self, forKey: .generatorEmailId)
		generatorMobile = try values.decodeIfPresent(String.self, forKey: .generatorMobile)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		mobileNum = try values.decodeIfPresent(String.self, forKey: .mobileNum)
		monthOfScanning = try values.decodeIfPresent(String.self, forKey: .monthOfScanning)
		prodWarrantyDesc = try values.decodeIfPresent(String.self, forKey: .prodWarrantyDesc)
		productId = try values.decodeIfPresent(Int.self, forKey: .productId)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		scannedCode = try values.decodeIfPresent(String.self, forKey: .scannedCode)
		subHelpTopicId = try values.decodeIfPresent(Int.self, forKey: .subHelpTopicId)
		successQRCount = try values.decodeIfPresent(Int.self, forKey: .successQRCount)
		total_Row = try values.decodeIfPresent(Int.self, forKey: .total_Row)
		warrantyFilePath = try values.decodeIfPresent(String.self, forKey: .warrantyFilePath)
	}

}
