

import Foundation
struct DashboardModels : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let activeStatus : Bool?
	let objActivityDetailsJsonList : [ObjActivityDetailsJsonList]?
	let objActivityDetailsList : String?
	let objCatalogueDetailsForCustomer : [ObjCatalogueDetailsForCustomer]?
	let objCustomerDashboardList : [ObjCustomerDashboardList]?
	let objCustomerDashboardMenuList : String?
	let objGamificationTransaction : String?
	let objImageGalleryList : String?
	let objProductList : String?
	let lstCustomerFeedBackJsonApi : [LstCustomerFeedBackJsonApi]?
	let lstLoyaltyProgramReport : [LstLoyaltyProgramReport]?
	let lstPromotionListJsonApi : [LstPromotionListJsonApi]?
	let lstUserDashboardDetails : String?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case activeStatus = "ActiveStatus"
		case objActivityDetailsJsonList = "ObjActivityDetailsJsonList"
		case objActivityDetailsList = "ObjActivityDetailsList"
		case objCatalogueDetailsForCustomer = "ObjCatalogueDetailsForCustomer"
		case objCustomerDashboardList = "ObjCustomerDashboardList"
		case objCustomerDashboardMenuList = "ObjCustomerDashboardMenuList"
		case objGamificationTransaction = "ObjGamificationTransaction"
		case objImageGalleryList = "ObjImageGalleryList"
		case objProductList = "ObjProductList"
		case lstCustomerFeedBackJsonApi = "lstCustomerFeedBackJsonApi"
		case lstLoyaltyProgramReport = "lstLoyaltyProgramReport"
		case lstPromotionListJsonApi = "lstPromotionListJsonApi"
		case lstUserDashboardDetails = "lstUserDashboardDetails"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		activeStatus = try values.decodeIfPresent(Bool.self, forKey: .activeStatus)
		objActivityDetailsJsonList = try values.decodeIfPresent([ObjActivityDetailsJsonList].self, forKey: .objActivityDetailsJsonList)
		objActivityDetailsList = try values.decodeIfPresent(String.self, forKey: .objActivityDetailsList)
		objCatalogueDetailsForCustomer = try values.decodeIfPresent([ObjCatalogueDetailsForCustomer].self, forKey: .objCatalogueDetailsForCustomer)
		objCustomerDashboardList = try values.decodeIfPresent([ObjCustomerDashboardList].self, forKey: .objCustomerDashboardList)
		objCustomerDashboardMenuList = try values.decodeIfPresent(String.self, forKey: .objCustomerDashboardMenuList)
		objGamificationTransaction = try values.decodeIfPresent(String.self, forKey: .objGamificationTransaction)
		objImageGalleryList = try values.decodeIfPresent(String.self, forKey: .objImageGalleryList)
		objProductList = try values.decodeIfPresent(String.self, forKey: .objProductList)
		lstCustomerFeedBackJsonApi = try values.decodeIfPresent([LstCustomerFeedBackJsonApi].self, forKey: .lstCustomerFeedBackJsonApi)
		lstLoyaltyProgramReport = try values.decodeIfPresent([LstLoyaltyProgramReport].self, forKey: .lstLoyaltyProgramReport)
		lstPromotionListJsonApi = try values.decodeIfPresent([LstPromotionListJsonApi].self, forKey: .lstPromotionListJsonApi)
		lstUserDashboardDetails = try values.decodeIfPresent(String.self, forKey: .lstUserDashboardDetails)
	}

}
