

import Foundation
struct PanModels : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let objPanDetailsRetrieverequest : ObjPanDetailsRetrieverequest?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case objPanDetailsRetrieverequest = "ObjPanDetailsRetrieverequest"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		objPanDetailsRetrieverequest = try values.decodeIfPresent(ObjPanDetailsRetrieverequest.self, forKey: .objPanDetailsRetrieverequest)
	}

}
