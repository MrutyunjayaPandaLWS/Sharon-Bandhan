

import Foundation
struct CityListModels : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let cityList : [CityList]?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case cityList = "CityList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		cityList = try values.decodeIfPresent([CityList].self, forKey: .cityList)
	}

}
