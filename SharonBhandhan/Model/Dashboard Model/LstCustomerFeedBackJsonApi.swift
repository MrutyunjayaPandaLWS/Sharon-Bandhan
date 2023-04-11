/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstCustomerFeedBackJsonApi : Codable {
	let absent_Count : Int?
	let address : String?
	let addressTypeVerified : Bool?
	let attendanceDate : String?
	let bonusDate : String?
	let bonusName : String?
	let bonusValue : String?
	let callRemarks : String?
	let callStatusId : Int?
	let callingTime : String?
	let cashBack : Int?
	let cityID : String?
	let cityName : String?
	let company : String?
	let customerCartCount : Int?
	let customerGrade : String?
	let customerId : Int?
	let customerRelation : String?
	let designation : String?
	let district : String?
	let encashBalance : Int?
	let firstName : String?
	let identificationTypeVerified : Bool?
	let insuranceExpiredDate : String?
	let insuranceReferanceId : String?
	let isBlacklisted : Int?
	let isDormant : Int?
	let isOnHold : Int?
	let issueDescription : String?
	let languageId : Int?
	let languageName : String?
	let lastName : String?
	let locationId : Int?
	let locationName : String?
	let loyaltyId : String?
	let month_Name : String?
	let month_No : Int?
	let nativeStateId : Int?
	let nativeStateName : String?
	let nominee : String?
	let nomineeDOB : String?
	let ownerName : String?
	let pinStatus : Int?
	let present : Bool?
	let present_Count : Int?
	let profilePicture : String?
	let referralCode : String?
	let requiredPoints : Int?
	let skuMaxPrice : Int?
	let skuMinPrice : Int?
	let storeName : String?
	let tardy : Bool?
	let tardy_Count : Int?
	let targetAchieved : String?
	let title : String?
	let userId : Int?
	let verificationStatus : String?
	let verifiedStatus : Int?
	let walletNumber : String?
	let allowPlanner : Bool?
	let customerEmail : String?
	let customerImage : String?
	let customerMobile : String?
	let customerStatus : Int?
	let customerType : String?
	let customerTypeId : Int?
	let lastActive : String?
	let loyaltyIdQRCode : String?
	let merchantEmail : String?
	let merchantId : Int?
	let merchantMobile : String?
	let merchantname : String?
	let password : String?
	let prefix : String?

	enum CodingKeys: String, CodingKey {

		case absent_Count = "Absent_Count"
		case address = "Address"
		case addressTypeVerified = "AddressTypeVerified"
		case attendanceDate = "AttendanceDate"
		case bonusDate = "BonusDate"
		case bonusName = "BonusName"
		case bonusValue = "BonusValue"
		case callRemarks = "CallRemarks"
		case callStatusId = "CallStatusId"
		case callingTime = "CallingTime"
		case cashBack = "CashBack"
		case cityID = "CityID"
		case cityName = "CityName"
		case company = "Company"
		case customerCartCount = "CustomerCartCount"
		case customerGrade = "CustomerGrade"
		case customerId = "CustomerId"
		case customerRelation = "CustomerRelation"
		case designation = "Designation"
		case district = "District"
		case encashBalance = "EncashBalance"
		case firstName = "FirstName"
		case identificationTypeVerified = "IdentificationTypeVerified"
		case insuranceExpiredDate = "InsuranceExpiredDate"
		case insuranceReferanceId = "InsuranceReferanceId"
		case isBlacklisted = "IsBlacklisted"
		case isDormant = "IsDormant"
		case isOnHold = "IsOnHold"
		case issueDescription = "IssueDescription"
		case languageId = "LanguageId"
		case languageName = "LanguageName"
		case lastName = "LastName"
		case locationId = "LocationId"
		case locationName = "LocationName"
		case loyaltyId = "LoyaltyId"
		case month_Name = "Month_Name"
		case month_No = "Month_No"
		case nativeStateId = "NativeStateId"
		case nativeStateName = "NativeStateName"
		case nominee = "Nominee"
		case nomineeDOB = "NomineeDOB"
		case ownerName = "OwnerName"
		case pinStatus = "PinStatus"
		case present = "Present"
		case present_Count = "Present_Count"
		case profilePicture = "ProfilePicture"
		case referralCode = "ReferralCode"
		case requiredPoints = "RequiredPoints"
		case skuMaxPrice = "SkuMaxPrice"
		case skuMinPrice = "SkuMinPrice"
		case storeName = "StoreName"
		case tardy = "Tardy"
		case tardy_Count = "Tardy_Count"
		case targetAchieved = "TargetAchieved"
		case title = "Title"
		case userId = "UserId"
		case verificationStatus = "VerificationStatus"
		case verifiedStatus = "VerifiedStatus"
		case walletNumber = "WalletNumber"
		case allowPlanner = "AllowPlanner"
		case customerEmail = "CustomerEmail"
		case customerImage = "CustomerImage"
		case customerMobile = "CustomerMobile"
		case customerStatus = "CustomerStatus"
		case customerType = "CustomerType"
		case customerTypeId = "CustomerTypeId"
		case lastActive = "LastActive"
		case loyaltyIdQRCode = "LoyaltyIdQRCode"
		case merchantEmail = "MerchantEmail"
		case merchantId = "MerchantId"
		case merchantMobile = "MerchantMobile"
		case merchantname = "Merchantname"
		case password = "Password"
		case prefix = "Prefix"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		absent_Count = try values.decodeIfPresent(Int.self, forKey: .absent_Count)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		addressTypeVerified = try values.decodeIfPresent(Bool.self, forKey: .addressTypeVerified)
		attendanceDate = try values.decodeIfPresent(String.self, forKey: .attendanceDate)
		bonusDate = try values.decodeIfPresent(String.self, forKey: .bonusDate)
		bonusName = try values.decodeIfPresent(String.self, forKey: .bonusName)
		bonusValue = try values.decodeIfPresent(String.self, forKey: .bonusValue)
		callRemarks = try values.decodeIfPresent(String.self, forKey: .callRemarks)
		callStatusId = try values.decodeIfPresent(Int.self, forKey: .callStatusId)
		callingTime = try values.decodeIfPresent(String.self, forKey: .callingTime)
		cashBack = try values.decodeIfPresent(Int.self, forKey: .cashBack)
		cityID = try values.decodeIfPresent(String.self, forKey: .cityID)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
		company = try values.decodeIfPresent(String.self, forKey: .company)
		customerCartCount = try values.decodeIfPresent(Int.self, forKey: .customerCartCount)
		customerGrade = try values.decodeIfPresent(String.self, forKey: .customerGrade)
		customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
		customerRelation = try values.decodeIfPresent(String.self, forKey: .customerRelation)
		designation = try values.decodeIfPresent(String.self, forKey: .designation)
		district = try values.decodeIfPresent(String.self, forKey: .district)
		encashBalance = try values.decodeIfPresent(Int.self, forKey: .encashBalance)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		identificationTypeVerified = try values.decodeIfPresent(Bool.self, forKey: .identificationTypeVerified)
		insuranceExpiredDate = try values.decodeIfPresent(String.self, forKey: .insuranceExpiredDate)
		insuranceReferanceId = try values.decodeIfPresent(String.self, forKey: .insuranceReferanceId)
		isBlacklisted = try values.decodeIfPresent(Int.self, forKey: .isBlacklisted)
		isDormant = try values.decodeIfPresent(Int.self, forKey: .isDormant)
		isOnHold = try values.decodeIfPresent(Int.self, forKey: .isOnHold)
		issueDescription = try values.decodeIfPresent(String.self, forKey: .issueDescription)
		languageId = try values.decodeIfPresent(Int.self, forKey: .languageId)
		languageName = try values.decodeIfPresent(String.self, forKey: .languageName)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		locationId = try values.decodeIfPresent(Int.self, forKey: .locationId)
		locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		month_Name = try values.decodeIfPresent(String.self, forKey: .month_Name)
		month_No = try values.decodeIfPresent(Int.self, forKey: .month_No)
		nativeStateId = try values.decodeIfPresent(Int.self, forKey: .nativeStateId)
		nativeStateName = try values.decodeIfPresent(String.self, forKey: .nativeStateName)
		nominee = try values.decodeIfPresent(String.self, forKey: .nominee)
		nomineeDOB = try values.decodeIfPresent(String.self, forKey: .nomineeDOB)
		ownerName = try values.decodeIfPresent(String.self, forKey: .ownerName)
		pinStatus = try values.decodeIfPresent(Int.self, forKey: .pinStatus)
		present = try values.decodeIfPresent(Bool.self, forKey: .present)
		present_Count = try values.decodeIfPresent(Int.self, forKey: .present_Count)
		profilePicture = try values.decodeIfPresent(String.self, forKey: .profilePicture)
		referralCode = try values.decodeIfPresent(String.self, forKey: .referralCode)
		requiredPoints = try values.decodeIfPresent(Int.self, forKey: .requiredPoints)
		skuMaxPrice = try values.decodeIfPresent(Int.self, forKey: .skuMaxPrice)
		skuMinPrice = try values.decodeIfPresent(Int.self, forKey: .skuMinPrice)
		storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
		tardy = try values.decodeIfPresent(Bool.self, forKey: .tardy)
		tardy_Count = try values.decodeIfPresent(Int.self, forKey: .tardy_Count)
		targetAchieved = try values.decodeIfPresent(String.self, forKey: .targetAchieved)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		userId = try values.decodeIfPresent(Int.self, forKey: .userId)
		verificationStatus = try values.decodeIfPresent(String.self, forKey: .verificationStatus)
		verifiedStatus = try values.decodeIfPresent(Int.self, forKey: .verifiedStatus)
		walletNumber = try values.decodeIfPresent(String.self, forKey: .walletNumber)
		allowPlanner = try values.decodeIfPresent(Bool.self, forKey: .allowPlanner)
		customerEmail = try values.decodeIfPresent(String.self, forKey: .customerEmail)
		customerImage = try values.decodeIfPresent(String.self, forKey: .customerImage)
		customerMobile = try values.decodeIfPresent(String.self, forKey: .customerMobile)
		customerStatus = try values.decodeIfPresent(Int.self, forKey: .customerStatus)
		customerType = try values.decodeIfPresent(String.self, forKey: .customerType)
		customerTypeId = try values.decodeIfPresent(Int.self, forKey: .customerTypeId)
		lastActive = try values.decodeIfPresent(String.self, forKey: .lastActive)
		loyaltyIdQRCode = try values.decodeIfPresent(String.self, forKey: .loyaltyIdQRCode)
		merchantEmail = try values.decodeIfPresent(String.self, forKey: .merchantEmail)
		merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
		merchantMobile = try values.decodeIfPresent(String.self, forKey: .merchantMobile)
		merchantname = try values.decodeIfPresent(String.self, forKey: .merchantname)
		password = try values.decodeIfPresent(String.self, forKey: .password)
		prefix = try values.decodeIfPresent(String.self, forKey: .prefix)
	}

}