

import Foundation
struct ObjImageGalleryList : Codable {
	let actionType : Int?
	let actorId : Int?
	let actorRole : String?
	let isActive : Bool?
	let actionImageUrl : String?
	let albumCategoryID : Int?
	let imageGalleryUrl : String?

	enum CodingKeys: String, CodingKey {

		case actionType = "ActionType"
		case actorId = "ActorId"
		case actorRole = "ActorRole"
		case isActive = "IsActive"
		case actionImageUrl = "ActionImageUrl"
		case albumCategoryID = "AlbumCategoryID"
		case imageGalleryUrl = "ImageGalleryUrl"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
		actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
		actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		actionImageUrl = try values.decodeIfPresent(String.self, forKey: .actionImageUrl)
		albumCategoryID = try values.decodeIfPresent(Int.self, forKey: .albumCategoryID)
		imageGalleryUrl = try values.decodeIfPresent(String.self, forKey: .imageGalleryUrl)
	}

}
