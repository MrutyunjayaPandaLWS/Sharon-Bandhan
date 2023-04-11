
import Foundation
struct ChatDetailsModels : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let objQueryCenterList : String?
	let objQueryResponseJsonList : [ObjQueryResponseJsonList]?
	let objQueryResponseList : String?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case objQueryCenterList = "objQueryCenterList"
		case objQueryResponseJsonList = "objQueryResponseJsonList"
		case objQueryResponseList = "objQueryResponseList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		objQueryCenterList = try values.decodeIfPresent(String.self, forKey: .objQueryCenterList)
		objQueryResponseJsonList = try values.decodeIfPresent([ObjQueryResponseJsonList].self, forKey: .objQueryResponseJsonList)
		objQueryResponseList = try values.decodeIfPresent(String.self, forKey: .objQueryResponseList)
	}

}
