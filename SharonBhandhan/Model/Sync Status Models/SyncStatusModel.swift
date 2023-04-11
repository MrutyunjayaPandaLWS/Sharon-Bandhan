

import Foundation
struct SyncStatusModel : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let createdDate : String?
	let customerTypeCode : String?
	let generatedCodesCount : Int?
	let generatedFor : String?
	let invoiceNo : String?
	let month : Int?
	let plantCode : String?
	let plantName : String?
	let qrUsegereport : [QrUsegereport]?
	let sCQueueID : Int?
	let sKU : String?
	let scratchCodesList : String?
	let segment : String?
	let subSegment : String?
	let totalRows : Int?
	let usedScratchCodesList : String?
	let year : Int?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case createdDate = "CreatedDate"
		case customerTypeCode = "CustomerTypeCode"
		case generatedCodesCount = "GeneratedCodesCount"
		case generatedFor = "GeneratedFor"
		case invoiceNo = "InvoiceNo"
		case month = "Month"
		case plantCode = "PlantCode"
		case plantName = "PlantName"
		case qrUsegereport = "QrUsegereport"
		case sCQueueID = "SCQueueID"
		case sKU = "SKU"
		case scratchCodesList = "ScratchCodesList"
		case segment = "Segment"
		case subSegment = "SubSegment"
		case totalRows = "TotalRows"
		case usedScratchCodesList = "UsedScratchCodesList"
		case year = "Year"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
		customerTypeCode = try values.decodeIfPresent(String.self, forKey: .customerTypeCode)
		generatedCodesCount = try values.decodeIfPresent(Int.self, forKey: .generatedCodesCount)
		generatedFor = try values.decodeIfPresent(String.self, forKey: .generatedFor)
		invoiceNo = try values.decodeIfPresent(String.self, forKey: .invoiceNo)
		month = try values.decodeIfPresent(Int.self, forKey: .month)
		plantCode = try values.decodeIfPresent(String.self, forKey: .plantCode)
		plantName = try values.decodeIfPresent(String.self, forKey: .plantName)
		qrUsegereport = try values.decodeIfPresent([QrUsegereport].self, forKey: .qrUsegereport)
		sCQueueID = try values.decodeIfPresent(Int.self, forKey: .sCQueueID)
		sKU = try values.decodeIfPresent(String.self, forKey: .sKU)
		scratchCodesList = try values.decodeIfPresent(String.self, forKey: .scratchCodesList)
		segment = try values.decodeIfPresent(String.self, forKey: .segment)
		subSegment = try values.decodeIfPresent(String.self, forKey: .subSegment)
		totalRows = try values.decodeIfPresent(Int.self, forKey: .totalRows)
		usedScratchCodesList = try values.decodeIfPresent(String.self, forKey: .usedScratchCodesList)
		year = try values.decodeIfPresent(Int.self, forKey: .year)
	}

}
