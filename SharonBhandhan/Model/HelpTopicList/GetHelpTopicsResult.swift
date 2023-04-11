

import Foundation
struct GetHelpTopicsResult : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let objHelpTopicList : [ObjHelpTopicList]?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case objHelpTopicList = "objHelpTopicList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		objHelpTopicList = try values.decodeIfPresent([ObjHelpTopicList].self, forKey: .objHelpTopicList)
	}

}
