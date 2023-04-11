
import Foundation
struct ObjCatalogueCategoryListJson : Codable {
	let actionType : Int?
	let actorId : Int?
	let actorRole : String?
	let isActive : Bool?
	let catalogueBrandId : Int?
	let catalogueBrandName : String?
	let catogoryId : Int?
	let catogoryImage : String?
	let catogoryName : String?
	let encashValue : String?
	let memberId : String?
	let preferedModeOfRedemption : String?
	let redemptionDateTime : String?
	let redemptionRefNo : String?
	let redemptionStatus : String?
	let subCategoryID : Int?
	let subCategoryName : String?
	let totalPointsRedemed : String?

	enum CodingKeys: String, CodingKey {

		case actionType = "ActionType"
		case actorId = "ActorId"
		case actorRole = "ActorRole"
		case isActive = "IsActive"
		case catalogueBrandId = "CatalogueBrandId"
		case catalogueBrandName = "CatalogueBrandName"
		case catogoryId = "CatogoryId"
		case catogoryImage = "CatogoryImage"
		case catogoryName = "CatogoryName"
		case encashValue = "EncashValue"
		case memberId = "MemberId"
		case preferedModeOfRedemption = "PreferedModeOfRedemption"
		case redemptionDateTime = "RedemptionDateTime"
		case redemptionRefNo = "RedemptionRefNo"
		case redemptionStatus = "RedemptionStatus"
		case subCategoryID = "SubCategoryID"
		case subCategoryName = "SubCategoryName"
		case totalPointsRedemed = "TotalPointsRedemed"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
		actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
		actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		catalogueBrandId = try values.decodeIfPresent(Int.self, forKey: .catalogueBrandId)
		catalogueBrandName = try values.decodeIfPresent(String.self, forKey: .catalogueBrandName)
		catogoryId = try values.decodeIfPresent(Int.self, forKey: .catogoryId)
		catogoryImage = try values.decodeIfPresent(String.self, forKey: .catogoryImage)
		catogoryName = try values.decodeIfPresent(String.self, forKey: .catogoryName)
		encashValue = try values.decodeIfPresent(String.self, forKey: .encashValue)
		memberId = try values.decodeIfPresent(String.self, forKey: .memberId)
		preferedModeOfRedemption = try values.decodeIfPresent(String.self, forKey: .preferedModeOfRedemption)
		redemptionDateTime = try values.decodeIfPresent(String.self, forKey: .redemptionDateTime)
		redemptionRefNo = try values.decodeIfPresent(String.self, forKey: .redemptionRefNo)
		redemptionStatus = try values.decodeIfPresent(String.self, forKey: .redemptionStatus)
		subCategoryID = try values.decodeIfPresent(Int.self, forKey: .subCategoryID)
		subCategoryName = try values.decodeIfPresent(String.self, forKey: .subCategoryName)
		totalPointsRedemed = try values.decodeIfPresent(String.self, forKey: .totalPointsRedemed)
	}

}
