

import Foundation
struct NewChatSubmission : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let objCustomerAllQueryJsonList : String?
	let objCustomerAllQueryList : String?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case objCustomerAllQueryJsonList = "objCustomerAllQueryJsonList"
		case objCustomerAllQueryList = "objCustomerAllQueryList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		objCustomerAllQueryJsonList = try values.decodeIfPresent(String.self, forKey: .objCustomerAllQueryJsonList)
		objCustomerAllQueryList = try values.decodeIfPresent(String.self, forKey: .objCustomerAllQueryList)
	}

}
