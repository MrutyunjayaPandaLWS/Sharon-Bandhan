

import Foundation
struct E_WarrantyListingModel : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let lstEWarranty : [LstEWarranty]?
	let lstScannedCode : String?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case lstEWarranty = "lstEWarranty"
		case lstScannedCode = "lstScannedCode"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		lstEWarranty = try values.decodeIfPresent([LstEWarranty].self, forKey: .lstEWarranty)
		lstScannedCode = try values.decodeIfPresent(String.self, forKey: .lstScannedCode)
	}

}
