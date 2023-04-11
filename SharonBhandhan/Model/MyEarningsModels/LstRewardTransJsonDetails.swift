/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstRewardTransJsonDetails : Codable {
	let amount : Double?
	let behaviorId : Int?
	let bonusName : String?
	let brandName : String?
	let cashierName : String?
	let categoryName : String?
	let createdBy : String?
	let currencyName : String?
	let expairyOnDate : String?
	let invoiceNo : String?
	let isNotionalId : Int?
	let jTranDate : String?
	let locationID : Int?
	let locationName : String?
	let loyaltyId : String?
	let ltyBehaviourId : Int?
	let memberName : String?
	let merchantID : Int?
	let merchantName : String?
	let partyName : String?
	let pointBalance : Int?
	let pointsGiftedBy : String?
	let processDateTime : String?
	let prodCode : String?
	let prodName : String?
	let quantity : Int?
	let remarks : String?
	let rewardPoints : Int?
	let serialNumber : String?
	let skuName : String?
	let totalRows : Int?
	let tranDate : String?
	let transactionType : String?
	let vendorName : String?

	enum CodingKeys: String, CodingKey {

		case amount = "Amount"
		case behaviorId = "BehaviorId"
		case bonusName = "BonusName"
		case brandName = "BrandName"
		case cashierName = "CashierName"
		case categoryName = "CategoryName"
		case createdBy = "CreatedBy"
		case currencyName = "CurrencyName"
		case expairyOnDate = "ExpairyOnDate"
		case invoiceNo = "InvoiceNo"
		case isNotionalId = "IsNotionalId"
		case jTranDate = "JTranDate"
		case locationID = "LocationID"
		case locationName = "LocationName"
		case loyaltyId = "LoyaltyId"
		case ltyBehaviourId = "LtyBehaviourId"
		case memberName = "MemberName"
		case merchantID = "MerchantID"
		case merchantName = "MerchantName"
		case partyName = "PartyName"
		case pointBalance = "PointBalance"
		case pointsGiftedBy = "PointsGiftedBy"
		case processDateTime = "ProcessDateTime"
		case prodCode = "ProdCode"
		case prodName = "ProdName"
		case quantity = "Quantity"
		case remarks = "Remarks"
		case rewardPoints = "RewardPoints"
		case serialNumber = "SerialNumber"
		case skuName = "SkuName"
		case totalRows = "TotalRows"
		case tranDate = "TranDate"
		case transactionType = "TransactionType"
		case vendorName = "VendorName"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		amount = try values.decodeIfPresent(Double.self, forKey: .amount)
		behaviorId = try values.decodeIfPresent(Int.self, forKey: .behaviorId)
		bonusName = try values.decodeIfPresent(String.self, forKey: .bonusName)
		brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
		cashierName = try values.decodeIfPresent(String.self, forKey: .cashierName)
		categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
		createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
		currencyName = try values.decodeIfPresent(String.self, forKey: .currencyName)
		expairyOnDate = try values.decodeIfPresent(String.self, forKey: .expairyOnDate)
		invoiceNo = try values.decodeIfPresent(String.self, forKey: .invoiceNo)
		isNotionalId = try values.decodeIfPresent(Int.self, forKey: .isNotionalId)
		jTranDate = try values.decodeIfPresent(String.self, forKey: .jTranDate)
		locationID = try values.decodeIfPresent(Int.self, forKey: .locationID)
		locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		ltyBehaviourId = try values.decodeIfPresent(Int.self, forKey: .ltyBehaviourId)
		memberName = try values.decodeIfPresent(String.self, forKey: .memberName)
		merchantID = try values.decodeIfPresent(Int.self, forKey: .merchantID)
		merchantName = try values.decodeIfPresent(String.self, forKey: .merchantName)
		partyName = try values.decodeIfPresent(String.self, forKey: .partyName)
		pointBalance = try values.decodeIfPresent(Int.self, forKey: .pointBalance)
		pointsGiftedBy = try values.decodeIfPresent(String.self, forKey: .pointsGiftedBy)
		processDateTime = try values.decodeIfPresent(String.self, forKey: .processDateTime)
		prodCode = try values.decodeIfPresent(String.self, forKey: .prodCode)
		prodName = try values.decodeIfPresent(String.self, forKey: .prodName)
		quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
		remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
		rewardPoints = try values.decodeIfPresent(Int.self, forKey: .rewardPoints)
		serialNumber = try values.decodeIfPresent(String.self, forKey: .serialNumber)
		skuName = try values.decodeIfPresent(String.self, forKey: .skuName)
		totalRows = try values.decodeIfPresent(Int.self, forKey: .totalRows)
		tranDate = try values.decodeIfPresent(String.self, forKey: .tranDate)
		transactionType = try values.decodeIfPresent(String.self, forKey: .transactionType)
		vendorName = try values.decodeIfPresent(String.self, forKey: .vendorName)
	}

}