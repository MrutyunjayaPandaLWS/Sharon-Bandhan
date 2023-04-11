

import Foundation
struct RemovePlannedProduct : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let objCatalogueList : String?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case objCatalogueList = "ObjCatalogueList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		objCatalogueList = try values.decodeIfPresent(String.self, forKey: .objCatalogueList)
	}

}
