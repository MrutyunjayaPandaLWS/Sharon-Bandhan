

import Foundation
struct AreaList : Codable {
	let areaId : Int?
	let areaName : String?

	enum CodingKeys: String, CodingKey {

		case areaId = "AreaId"
		case areaName = "AreaName"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		areaId = try values.decodeIfPresent(Int.self, forKey: .areaId)
		areaName = try values.decodeIfPresent(String.self, forKey: .areaName)
	}

}
