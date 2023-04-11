
import Foundation
struct ObjCatalogueRedemReqList : Codable {
	let actionType : Int?
	let actorId : Int?
	let actorRole : String?
	let isActive : Bool?
	let aSM : String?
	let address1 : String?
	let address2 : String?
	let addressId : Int?
	let addressType : String?
	let balance : String?
	let barcode : String?
	let cashPerUnit : Int?
	let cashValue : Int?
	let catalogueId : Int?
    let TDSPercentage : Double?
    let ApplicableTds : Double?
	let catalogueType : String?
	let categoryName : String?
	let cityId : Int?
	let cityName : String?
	let countryId : Int?
	let countryName : String?
	let createdBy : String?
	let custMobile : String?
	let deliveryType : Int?
	let email : String?
	let expiryDate : String?
	let fullName : String?
	let jRedemptionDate : String?
	let landmark : String?
	let locationName : String?
	let loyaltyId : String?
	let merchantEmail : String?
	let merchantName : String?
	let mobile : String?
	let name : String?
	let pDFLink : String?
	let partialPaymentCash : Int?
	let pendingVoucherBalance : Double?
	let pointsPerUnit : Int?
	let pointsRequired : Int?
	let processedBy : String?
	let productCode : String?
	let productDesc : String?
	let productImage : String?
	let productName : String?
	let quantity : Int?
	let redeemedPoints : Int?
	let redemptionDate : String?
	let redemptionId : Int?
	let redemptionPoints : Int?
	let redemptionRefno : String?
	let redemptionStatus : Int?
	let redemptionType : Int?
	let referrenceCustName : String?
	let sE : String?
	let sapCode : String?
	let sku : String?
	let stateId : Int?
	let stateName : String?
	let status : Int?
	let termsCondition : String?
	let totRowCount : Int?
	let transferMode : String?
	let vendorCode : String?
	let vendorId : Int?
	let vendorName : String?
	let walletNumber : String?
	let zip : String?
	let beneficiaryAccount : String?
	let beneficiaryIFSC : String?
	let beneficiaryName : String?

	enum CodingKeys: String, CodingKey {

		case actionType = "ActionType"
		case actorId = "ActorId"
		case actorRole = "ActorRole"
		case isActive = "IsActive"
		case aSM = "ASM"
        case ApplicableTds = "ApplicableTds"
        case TDSPercentage = "TDSPercentage"
		case address1 = "Address1"
		case address2 = "Address2"
		case addressId = "AddressId"
		case addressType = "AddressType"
		case balance = "Balance"
		case barcode = "Barcode"
		case cashPerUnit = "CashPerUnit"
		case cashValue = "CashValue"
		case catalogueId = "CatalogueId"
		case catalogueType = "CatalogueType"
		case categoryName = "CategoryName"
		case cityId = "CityId"
		case cityName = "CityName"
		case countryId = "CountryId"
		case countryName = "CountryName"
		case createdBy = "CreatedBy"
		case custMobile = "CustMobile"
		case deliveryType = "DeliveryType"
		case email = "Email"
		case expiryDate = "ExpiryDate"
		case fullName = "FullName"
		case jRedemptionDate = "JRedemptionDate"
		case landmark = "Landmark"
		case locationName = "LocationName"
		case loyaltyId = "LoyaltyId"
		case merchantEmail = "MerchantEmail"
		case merchantName = "MerchantName"
		case mobile = "Mobile"
		case name = "Name"
		case pDFLink = "PDFLink"
		case partialPaymentCash = "PartialPaymentCash"
		case pendingVoucherBalance = "PendingVoucherBalance"
		case pointsPerUnit = "PointsPerUnit"
		case pointsRequired = "PointsRequired"
		case processedBy = "ProcessedBy"
		case productCode = "ProductCode"
		case productDesc = "ProductDesc"
		case productImage = "ProductImage"
		case productName = "ProductName"
		case quantity = "Quantity"
		case redeemedPoints = "RedeemedPoints"
		case redemptionDate = "RedemptionDate"
		case redemptionId = "RedemptionId"
		case redemptionPoints = "RedemptionPoints"
		case redemptionRefno = "RedemptionRefno"
		case redemptionStatus = "RedemptionStatus"
		case redemptionType = "RedemptionType"
		case referrenceCustName = "ReferrenceCustName"
		case sE = "SE"
		case sapCode = "SapCode"
		case sku = "Sku"
		case stateId = "StateId"
		case stateName = "StateName"
		case status = "Status"
		case termsCondition = "TermsCondition"
		case totRowCount = "TotRowCount"
		case transferMode = "TransferMode"
		case vendorCode = "VendorCode"
		case vendorId = "VendorId"
		case vendorName = "VendorName"
		case walletNumber = "WalletNumber"
		case zip = "Zip"
		case beneficiaryAccount = "beneficiaryAccount"
		case beneficiaryIFSC = "beneficiaryIFSC"
		case beneficiaryName = "beneficiaryName"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
		actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
		actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        TDSPercentage = try values.decodeIfPresent(Double.self, forKey: .TDSPercentage)
        ApplicableTds = try values.decodeIfPresent(Double.self, forKey: .ApplicableTds)
		aSM = try values.decodeIfPresent(String.self, forKey: .aSM)
		address1 = try values.decodeIfPresent(String.self, forKey: .address1)
		address2 = try values.decodeIfPresent(String.self, forKey: .address2)
		addressId = try values.decodeIfPresent(Int.self, forKey: .addressId)
		addressType = try values.decodeIfPresent(String.self, forKey: .addressType)
		balance = try values.decodeIfPresent(String.self, forKey: .balance)
		barcode = try values.decodeIfPresent(String.self, forKey: .barcode)
		cashPerUnit = try values.decodeIfPresent(Int.self, forKey: .cashPerUnit)
		cashValue = try values.decodeIfPresent(Int.self, forKey: .cashValue)
		catalogueId = try values.decodeIfPresent(Int.self, forKey: .catalogueId)
		catalogueType = try values.decodeIfPresent(String.self, forKey: .catalogueType)
		categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
		cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
		countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
		countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
		createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
		custMobile = try values.decodeIfPresent(String.self, forKey: .custMobile)
		deliveryType = try values.decodeIfPresent(Int.self, forKey: .deliveryType)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		expiryDate = try values.decodeIfPresent(String.self, forKey: .expiryDate)
		fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
		jRedemptionDate = try values.decodeIfPresent(String.self, forKey: .jRedemptionDate)
		landmark = try values.decodeIfPresent(String.self, forKey: .landmark)
		locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		merchantEmail = try values.decodeIfPresent(String.self, forKey: .merchantEmail)
		merchantName = try values.decodeIfPresent(String.self, forKey: .merchantName)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		pDFLink = try values.decodeIfPresent(String.self, forKey: .pDFLink)
		partialPaymentCash = try values.decodeIfPresent(Int.self, forKey: .partialPaymentCash)
		pendingVoucherBalance = try values.decodeIfPresent(Double.self, forKey: .pendingVoucherBalance)
		pointsPerUnit = try values.decodeIfPresent(Int.self, forKey: .pointsPerUnit)
		pointsRequired = try values.decodeIfPresent(Int.self, forKey: .pointsRequired)
		processedBy = try values.decodeIfPresent(String.self, forKey: .processedBy)
		productCode = try values.decodeIfPresent(String.self, forKey: .productCode)
		productDesc = try values.decodeIfPresent(String.self, forKey: .productDesc)
		productImage = try values.decodeIfPresent(String.self, forKey: .productImage)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
		redeemedPoints = try values.decodeIfPresent(Int.self, forKey: .redeemedPoints)
		redemptionDate = try values.decodeIfPresent(String.self, forKey: .redemptionDate)
		redemptionId = try values.decodeIfPresent(Int.self, forKey: .redemptionId)
		redemptionPoints = try values.decodeIfPresent(Int.self, forKey: .redemptionPoints)
		redemptionRefno = try values.decodeIfPresent(String.self, forKey: .redemptionRefno)
		redemptionStatus = try values.decodeIfPresent(Int.self, forKey: .redemptionStatus)
		redemptionType = try values.decodeIfPresent(Int.self, forKey: .redemptionType)
		referrenceCustName = try values.decodeIfPresent(String.self, forKey: .referrenceCustName)
		sE = try values.decodeIfPresent(String.self, forKey: .sE)
		sapCode = try values.decodeIfPresent(String.self, forKey: .sapCode)
		sku = try values.decodeIfPresent(String.self, forKey: .sku)
		stateId = try values.decodeIfPresent(Int.self, forKey: .stateId)
		stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		termsCondition = try values.decodeIfPresent(String.self, forKey: .termsCondition)
		totRowCount = try values.decodeIfPresent(Int.self, forKey: .totRowCount)
		transferMode = try values.decodeIfPresent(String.self, forKey: .transferMode)
		vendorCode = try values.decodeIfPresent(String.self, forKey: .vendorCode)
		vendorId = try values.decodeIfPresent(Int.self, forKey: .vendorId)
		vendorName = try values.decodeIfPresent(String.self, forKey: .vendorName)
		walletNumber = try values.decodeIfPresent(String.self, forKey: .walletNumber)
		zip = try values.decodeIfPresent(String.self, forKey: .zip)
		beneficiaryAccount = try values.decodeIfPresent(String.self, forKey: .beneficiaryAccount)
		beneficiaryIFSC = try values.decodeIfPresent(String.self, forKey: .beneficiaryIFSC)
		beneficiaryName = try values.decodeIfPresent(String.self, forKey: .beneficiaryName)
	}

}
