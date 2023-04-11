

import Foundation
struct DownloadEWarranty : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let base64Image : String?
	let lstEWarranty : [LstEWarranty2]?
	let lstScannedCode : [LstScannedCode]?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case base64Image = "base64Image"
		case lstEWarranty = "lstEWarranty"
		case lstScannedCode = "lstScannedCode"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		base64Image = try values.decodeIfPresent(String.self, forKey: .base64Image)
		lstEWarranty = try values.decodeIfPresent([LstEWarranty2].self, forKey: .lstEWarranty)
		lstScannedCode = try values.decodeIfPresent([LstScannedCode].self, forKey: .lstScannedCode)
	}

}
