

import Foundation
struct AreaListModels : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let areaList : [AreaList]?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case areaList = "AreaList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		areaList = try values.decodeIfPresent([AreaList].self, forKey: .areaList)
	}

}
