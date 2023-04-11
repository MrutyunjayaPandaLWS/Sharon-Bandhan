
import Foundation
struct OffersandPromotionsVM : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let lstPromotionJsonList : [LstPromotionJsonList]?
	let lstPromotionList : String?
	let lstPromotionUserActionDetails : String?
	let lstPromotionView : String?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case lstPromotionJsonList = "LstPromotionJsonList"
		case lstPromotionList = "LstPromotionList"
		case lstPromotionUserActionDetails = "LstPromotionUserActionDetails"
		case lstPromotionView = "lstPromotionView"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		lstPromotionJsonList = try values.decodeIfPresent([LstPromotionJsonList].self, forKey: .lstPromotionJsonList)
		lstPromotionList = try values.decodeIfPresent(String.self, forKey: .lstPromotionList)
		lstPromotionUserActionDetails = try values.decodeIfPresent(String.self, forKey: .lstPromotionUserActionDetails)
		lstPromotionView = try values.decodeIfPresent(String.self, forKey: .lstPromotionView)
	}

}
