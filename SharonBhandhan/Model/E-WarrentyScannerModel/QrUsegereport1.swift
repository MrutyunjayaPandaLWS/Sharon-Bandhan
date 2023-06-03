

import Foundation
struct QrUsegereport1 : Codable {
	var accessedDate : String?
	var address : String?
	var addressCount : Int?
	var bankingBy : String?
	var bankingDate : String?
	var bankingDateFormat : String?
	var bankingSource : String?
	var brandId : Int?
	var city : String?
	var codeStatusWiseCount : Int?
	var country : String?
	var customerType : String?
	var distributor : String?
	var isMember : String?
	var lastDate : String?
	var latitude : String?
	var latitudeCount : Int?
	var locationName : String?
	var longitude : String?
	var mapURL : String?
	var memberName : String?
	var membershipId : String?
	var mobile : String?
	var pinCode : String?
	var pointsawarded : Int?
	var printDate : String?
	var printDateFormat : String?
	var productId : Int?
	var productName : String?
	var qRCodeStatusID : Int?
	var remarks : String?
	var retailer : String?
	var scratchCode : String?
	var size : String?
	var sku : String?
	var state : String?
	var status : String?
	var thickness : String?
	var totalCode : String?
	var totalRows : String?
	var transactiondate : String?
	var usedBankingBy : String?
	var usedBankingDate : String?
	var usedBankingSource : String?
	var usedMembershipId : String?
	var usedRemarks : String?
	var userImage : String?
	var warehouse : String?
	var loyaltyId : String?

	enum CodingKeys: String, CodingKey {

		case accessedDate = "AccessedDate"
		case address = "Address"
		case addressCount = "AddressCount"
		case bankingBy = "BankingBy"
		case bankingDate = "BankingDate"
		case bankingDateFormat = "BankingDateFormat"
		case bankingSource = "BankingSource"
		case brandId = "BrandId"
		case city = "City"
		case codeStatusWiseCount = "CodeStatusWiseCount"
		case country = "Country"
		case customerType = "CustomerType"
		case distributor = "Distributor"
		case isMember = "IsMember"
		case lastDate = "LastDate"
		case latitude = "Latitude"
		case latitudeCount = "LatitudeCount"
		case locationName = "LocationName"
		case longitude = "Longitude"
		case mapURL = "MapURL"
		case memberName = "MemberName"
		case membershipId = "MembershipId"
		case mobile = "Mobile"
		case pinCode = "PinCode"
		case pointsawarded = "Pointsawarded"
		case printDate = "PrintDate"
		case printDateFormat = "PrintDateFormat"
		case productId = "ProductId"
		case productName = "ProductName"
		case qRCodeStatusID = "QRCodeStatusID"
		case remarks = "Remarks"
		case retailer = "Retailer"
		case scratchCode = "ScratchCode"
		case size = "Size"
		case sku = "Sku"
		case state = "State"
		case status = "Status"
		case thickness = "Thickness"
		case totalCode = "TotalCode"
		case totalRows = "TotalRows"
		case transactiondate = "Transactiondate"
		case usedBankingBy = "UsedBankingBy"
		case usedBankingDate = "UsedBankingDate"
		case usedBankingSource = "UsedBankingSource"
		case usedMembershipId = "UsedMembershipId"
		case usedRemarks = "UsedRemarks"
		case userImage = "UserImage"
		case warehouse = "Warehouse"
		case loyaltyId = "loyaltyId"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		accessedDate = try values.decodeIfPresent(String.self, forKey: .accessedDate)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		addressCount = try values.decodeIfPresent(Int.self, forKey: .addressCount)
		bankingBy = try values.decodeIfPresent(String.self, forKey: .bankingBy)
		bankingDate = try values.decodeIfPresent(String.self, forKey: .bankingDate)
		bankingDateFormat = try values.decodeIfPresent(String.self, forKey: .bankingDateFormat)
		bankingSource = try values.decodeIfPresent(String.self, forKey: .bankingSource)
		brandId = try values.decodeIfPresent(Int.self, forKey: .brandId)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		codeStatusWiseCount = try values.decodeIfPresent(Int.self, forKey: .codeStatusWiseCount)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		customerType = try values.decodeIfPresent(String.self, forKey: .customerType)
		distributor = try values.decodeIfPresent(String.self, forKey: .distributor)
		isMember = try values.decodeIfPresent(String.self, forKey: .isMember)
		lastDate = try values.decodeIfPresent(String.self, forKey: .lastDate)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		latitudeCount = try values.decodeIfPresent(Int.self, forKey: .latitudeCount)
		locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
		mapURL = try values.decodeIfPresent(String.self, forKey: .mapURL)
		memberName = try values.decodeIfPresent(String.self, forKey: .memberName)
		membershipId = try values.decodeIfPresent(String.self, forKey: .membershipId)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		pinCode = try values.decodeIfPresent(String.self, forKey: .pinCode)
		pointsawarded = try values.decodeIfPresent(Int.self, forKey: .pointsawarded)
		printDate = try values.decodeIfPresent(String.self, forKey: .printDate)
		printDateFormat = try values.decodeIfPresent(String.self, forKey: .printDateFormat)
		productId = try values.decodeIfPresent(Int.self, forKey: .productId)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		qRCodeStatusID = try values.decodeIfPresent(Int.self, forKey: .qRCodeStatusID)
		remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
		retailer = try values.decodeIfPresent(String.self, forKey: .retailer)
		scratchCode = try values.decodeIfPresent(String.self, forKey: .scratchCode)
		size = try values.decodeIfPresent(String.self, forKey: .size)
		sku = try values.decodeIfPresent(String.self, forKey: .sku)
		state = try values.decodeIfPresent(String.self, forKey: .state)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		thickness = try values.decodeIfPresent(String.self, forKey: .thickness)
		totalCode = try values.decodeIfPresent(String.self, forKey: .totalCode)
		totalRows = try values.decodeIfPresent(String.self, forKey: .totalRows)
		transactiondate = try values.decodeIfPresent(String.self, forKey: .transactiondate)
		usedBankingBy = try values.decodeIfPresent(String.self, forKey: .usedBankingBy)
		usedBankingDate = try values.decodeIfPresent(String.self, forKey: .usedBankingDate)
		usedBankingSource = try values.decodeIfPresent(String.self, forKey: .usedBankingSource)
		usedMembershipId = try values.decodeIfPresent(String.self, forKey: .usedMembershipId)
		usedRemarks = try values.decodeIfPresent(String.self, forKey: .usedRemarks)
		userImage = try values.decodeIfPresent(String.self, forKey: .userImage)
		warehouse = try values.decodeIfPresent(String.self, forKey: .warehouse)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
	}

}
