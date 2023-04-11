

import Foundation
struct SaveEWarrantyDetails : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let warrantyFilePath : String?
	let lstEWarranty : [LstEWarranty1]?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case warrantyFilePath = "WarrantyFilePath"
		case lstEWarranty = "lstEWarranty"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		warrantyFilePath = try values.decodeIfPresent(String.self, forKey: .warrantyFilePath)
		lstEWarranty = try values.decodeIfPresent([LstEWarranty1].self, forKey: .lstEWarranty)
	}

}
