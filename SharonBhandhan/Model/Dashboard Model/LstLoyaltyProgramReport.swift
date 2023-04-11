/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstLoyaltyProgramReport : Codable {
	let iD : Int?
	let locationID : Int?
	let locationUserID : Int?
	let name : String?
	let programDesc : String?
	let programID : Int?
	let programName : String?
	let status : Bool?
	let accountStatus : String?
	let amount : Int?
	let authenticityCardImgPath : String?
	let brandName : String?
	let currencyName : String?
	let customerGrade : String?
	let customerType : String?
	let discount : Int?
	let grandTotalAmount : Int?
	let grandTotalAwarded : Int?
	let grandTotalRedemed : Int?
	let invoiceNo : String?
	let isProgramValid : Int?
	let jTransactionDate : String?
	let locationName : String?
	let loyalityID : String?
	let ltyTranTempId : Int?
	let memberCount : Int?
	let membershipName : String?
	let merchantName : String?
	let merchantUserId : Int?
	let noOfAwardTrxn : Int?
	let noOfNotAwardTrxn : Int?
	let noofTrans : Int?
	let productCode : String?
	let productName : String?
	let programStartDate : String?
	let quantity : Int?
	let remarks : String?
	let rewardCurrency : String?
	let rewardCurrencyID : Int?
	let rewardDebited : Int?
	let rewardGiven : Int?
	let rewardQty : Int?
	let salesReturn : Int?
	let serialNo : String?
	let totAmt : Int?
	let totAward : Int?
	let totDeebit : Int?
	let totSalesReturn : Int?
	let totalAmount : Int?
	let totalAwarded : Int?
	let transactionDate : String?
	let transactionType : String?
	let txnsDate : String?
	let verificationStatus : String?

	enum CodingKeys: String, CodingKey {

		case iD = "ID"
		case locationID = "LocationID"
		case locationUserID = "LocationUserID"
		case name = "Name"
		case programDesc = "ProgramDesc"
		case programID = "ProgramID"
		case programName = "ProgramName"
		case status = "Status"
		case accountStatus = "AccountStatus"
		case amount = "Amount"
		case authenticityCardImgPath = "AuthenticityCardImgPath"
		case brandName = "BrandName"
		case currencyName = "CurrencyName"
		case customerGrade = "CustomerGrade"
		case customerType = "CustomerType"
		case discount = "Discount"
		case grandTotalAmount = "GrandTotalAmount"
		case grandTotalAwarded = "GrandTotalAwarded"
		case grandTotalRedemed = "GrandTotalRedemed"
		case invoiceNo = "InvoiceNo"
		case isProgramValid = "IsProgramValid"
		case jTransactionDate = "JTransactionDate"
		case locationName = "LocationName"
		case loyalityID = "LoyalityID"
		case ltyTranTempId = "LtyTranTempId"
		case memberCount = "MemberCount"
		case membershipName = "MembershipName"
		case merchantName = "MerchantName"
		case merchantUserId = "MerchantUserId"
		case noOfAwardTrxn = "NoOfAwardTrxn"
		case noOfNotAwardTrxn = "NoOfNotAwardTrxn"
		case noofTrans = "NoofTrans"
		case productCode = "ProductCode"
		case productName = "ProductName"
		case programStartDate = "ProgramStartDate"
		case quantity = "Quantity"
		case remarks = "Remarks"
		case rewardCurrency = "RewardCurrency"
		case rewardCurrencyID = "RewardCurrencyID"
		case rewardDebited = "RewardDebited"
		case rewardGiven = "RewardGiven"
		case rewardQty = "RewardQty"
		case salesReturn = "SalesReturn"
		case serialNo = "SerialNo"
		case totAmt = "TotAmt"
		case totAward = "TotAward"
		case totDeebit = "TotDeebit"
		case totSalesReturn = "TotSalesReturn"
		case totalAmount = "TotalAmount"
		case totalAwarded = "TotalAwarded"
		case transactionDate = "TransactionDate"
		case transactionType = "TransactionType"
		case txnsDate = "TxnsDate"
		case verificationStatus = "VerificationStatus"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		iD = try values.decodeIfPresent(Int.self, forKey: .iD)
		locationID = try values.decodeIfPresent(Int.self, forKey: .locationID)
		locationUserID = try values.decodeIfPresent(Int.self, forKey: .locationUserID)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		programDesc = try values.decodeIfPresent(String.self, forKey: .programDesc)
		programID = try values.decodeIfPresent(Int.self, forKey: .programID)
		programName = try values.decodeIfPresent(String.self, forKey: .programName)
		status = try values.decodeIfPresent(Bool.self, forKey: .status)
		accountStatus = try values.decodeIfPresent(String.self, forKey: .accountStatus)
		amount = try values.decodeIfPresent(Int.self, forKey: .amount)
		authenticityCardImgPath = try values.decodeIfPresent(String.self, forKey: .authenticityCardImgPath)
		brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
		currencyName = try values.decodeIfPresent(String.self, forKey: .currencyName)
		customerGrade = try values.decodeIfPresent(String.self, forKey: .customerGrade)
		customerType = try values.decodeIfPresent(String.self, forKey: .customerType)
		discount = try values.decodeIfPresent(Int.self, forKey: .discount)
		grandTotalAmount = try values.decodeIfPresent(Int.self, forKey: .grandTotalAmount)
		grandTotalAwarded = try values.decodeIfPresent(Int.self, forKey: .grandTotalAwarded)
		grandTotalRedemed = try values.decodeIfPresent(Int.self, forKey: .grandTotalRedemed)
		invoiceNo = try values.decodeIfPresent(String.self, forKey: .invoiceNo)
		isProgramValid = try values.decodeIfPresent(Int.self, forKey: .isProgramValid)
		jTransactionDate = try values.decodeIfPresent(String.self, forKey: .jTransactionDate)
		locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
		loyalityID = try values.decodeIfPresent(String.self, forKey: .loyalityID)
		ltyTranTempId = try values.decodeIfPresent(Int.self, forKey: .ltyTranTempId)
		memberCount = try values.decodeIfPresent(Int.self, forKey: .memberCount)
		membershipName = try values.decodeIfPresent(String.self, forKey: .membershipName)
		merchantName = try values.decodeIfPresent(String.self, forKey: .merchantName)
		merchantUserId = try values.decodeIfPresent(Int.self, forKey: .merchantUserId)
		noOfAwardTrxn = try values.decodeIfPresent(Int.self, forKey: .noOfAwardTrxn)
		noOfNotAwardTrxn = try values.decodeIfPresent(Int.self, forKey: .noOfNotAwardTrxn)
		noofTrans = try values.decodeIfPresent(Int.self, forKey: .noofTrans)
		productCode = try values.decodeIfPresent(String.self, forKey: .productCode)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		programStartDate = try values.decodeIfPresent(String.self, forKey: .programStartDate)
		quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
		remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
		rewardCurrency = try values.decodeIfPresent(String.self, forKey: .rewardCurrency)
		rewardCurrencyID = try values.decodeIfPresent(Int.self, forKey: .rewardCurrencyID)
		rewardDebited = try values.decodeIfPresent(Int.self, forKey: .rewardDebited)
		rewardGiven = try values.decodeIfPresent(Int.self, forKey: .rewardGiven)
		rewardQty = try values.decodeIfPresent(Int.self, forKey: .rewardQty)
		salesReturn = try values.decodeIfPresent(Int.self, forKey: .salesReturn)
		serialNo = try values.decodeIfPresent(String.self, forKey: .serialNo)
		totAmt = try values.decodeIfPresent(Int.self, forKey: .totAmt)
		totAward = try values.decodeIfPresent(Int.self, forKey: .totAward)
		totDeebit = try values.decodeIfPresent(Int.self, forKey: .totDeebit)
		totSalesReturn = try values.decodeIfPresent(Int.self, forKey: .totSalesReturn)
		totalAmount = try values.decodeIfPresent(Int.self, forKey: .totalAmount)
		totalAwarded = try values.decodeIfPresent(Int.self, forKey: .totalAwarded)
		transactionDate = try values.decodeIfPresent(String.self, forKey: .transactionDate)
		transactionType = try values.decodeIfPresent(String.self, forKey: .transactionType)
		txnsDate = try values.decodeIfPresent(String.self, forKey: .txnsDate)
		verificationStatus = try values.decodeIfPresent(String.self, forKey: .verificationStatus)
	}

}