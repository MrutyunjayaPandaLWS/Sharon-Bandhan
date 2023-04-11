

import Foundation
struct ObjQueryResponseJsonList : Codable {
	let color : String?
	let createdDate : String?
	let imageUrl : String?
	let jCreatedDate : String?
	let queryResponseInfo : String?
	let queryStatus : String?
	let repliedBy : String?
	let userType : String?

	enum CodingKeys: String, CodingKey {

		case color = "Color"
		case createdDate = "CreatedDate"
		case imageUrl = "ImageUrl"
		case jCreatedDate = "JCreatedDate"
		case queryResponseInfo = "QueryResponseInfo"
		case queryStatus = "QueryStatus"
		case repliedBy = "RepliedBy"
		case userType = "UserType"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		color = try values.decodeIfPresent(String.self, forKey: .color)
		createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
		jCreatedDate = try values.decodeIfPresent(String.self, forKey: .jCreatedDate)
		queryResponseInfo = try values.decodeIfPresent(String.self, forKey: .queryResponseInfo)
		queryStatus = try values.decodeIfPresent(String.self, forKey: .queryStatus)
		repliedBy = try values.decodeIfPresent(String.self, forKey: .repliedBy)
		userType = try values.decodeIfPresent(String.self, forKey: .userType)
	}

}
