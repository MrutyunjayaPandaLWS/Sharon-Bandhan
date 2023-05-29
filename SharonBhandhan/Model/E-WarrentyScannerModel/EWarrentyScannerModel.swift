/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct EWarrentyScannerModel : Codable {
	var returnMessage : String?
	var returnValue : Int?
	var totalRecords : Int?
	var createdDate : String?
	var customerTypeCode : String?
	var generatedCodesCount : Int?
	var generatedFor : String?
	var invoiceNo : String?
	var month : Int?
	var plantCode : String?
	var plantName : String?
	var qrUsegereport : [QrUsegereport1]?
	var sCQueueID : Int?
	var sKU : String?
	var scratchCodesList : String?
	var segment : String?
	var subSegment : String?
	var totalRows : Int?
	var usedScratchCodesList : String?
	var year : Int?

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
		qrUsegereport = try values.decodeIfPresent([QrUsegereport1].self, forKey: .qrUsegereport)
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
