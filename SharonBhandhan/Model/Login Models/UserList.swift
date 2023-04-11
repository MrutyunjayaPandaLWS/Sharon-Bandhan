

import Foundation
struct UserList : Codable {
	let password : String?
	let userName : String?
	let actionType : Int?
	let name : String?
	let result : Int?
	let status : String?
	let userId : Int?
	let c_MerchantId : Int?
	let cityName : String?
	let commonUserMobile : String?
	let commonUserName : String?
	let country : String?
	let countryCode : String?
	let currency : String?
	let custAccountNumber : String?
	let custAccountType : String?
	let customerGrade : String?
	let customerTypeID : Int?
	let dOB : String?
	let email : String?
	let encrypted_OTP_PIN : String?
	let isBlacklisted : Int?
	let isDelete : Int?
	let isDormant : Int?
	let isGeofenceActive : Int?
	let isOnHold : Int?
	let isUserActive : Int?
	let language : String?
	let locationCountryID : Int?
	let locationId : Int?
	let locationName : String?
	let locationType : String?
	let memberSince : String?
	let merchantEmailID : String?
	let merchantId : Int?
	let merchantMobileNo : String?
	let merchantName : String?
	let merchant_logo : String?
	let mobile : String?
	let parentLocationId : Int?
	let parentLocationName : String?
	let pinStatus : Int?
	let prefix : String?
	let roleName : String?
	let superParentLocationId : Int?
	let userGender : String?
	let userImage : String?
	let userLastName : String?
	let userType : String?
	let verifiedStatus : Int?

	enum CodingKeys: String, CodingKey {

		case password = "Password"
		case userName = "UserName"
		case actionType = "ActionType"
		case name = "Name"
		case result = "Result"
		case status = "Status"
		case userId = "UserId"
		case c_MerchantId = "C_MerchantId"
		case cityName = "CityName"
		case commonUserMobile = "CommonUserMobile"
		case commonUserName = "CommonUserName"
		case country = "Country"
		case countryCode = "CountryCode"
		case currency = "Currency"
		case custAccountNumber = "CustAccountNumber"
		case custAccountType = "CustAccountType"
		case customerGrade = "CustomerGrade"
		case customerTypeID = "CustomerTypeID"
		case dOB = "DOB"
		case email = "Email"
		case encrypted_OTP_PIN = "Encrypted_OTP_PIN"
		case isBlacklisted = "IsBlacklisted"
		case isDelete = "IsDelete"
		case isDormant = "IsDormant"
		case isGeofenceActive = "IsGeofenceActive"
		case isOnHold = "IsOnHold"
		case isUserActive = "IsUserActive"
		case language = "Language"
		case locationCountryID = "LocationCountryID"
		case locationId = "LocationId"
		case locationName = "LocationName"
		case locationType = "LocationType"
		case memberSince = "MemberSince"
		case merchantEmailID = "MerchantEmailID"
		case merchantId = "MerchantId"
		case merchantMobileNo = "MerchantMobileNo"
		case merchantName = "MerchantName"
		case merchant_logo = "Merchant_logo"
		case mobile = "Mobile"
		case parentLocationId = "ParentLocationId"
		case parentLocationName = "ParentLocationName"
		case pinStatus = "PinStatus"
		case prefix = "Prefix"
		case roleName = "RoleName"
		case superParentLocationId = "SuperParentLocationId"
		case userGender = "UserGender"
		case userImage = "UserImage"
		case userLastName = "UserLastName"
		case userType = "UserType"
		case verifiedStatus = "VerifiedStatus"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		password = try values.decodeIfPresent(String.self, forKey: .password)
		userName = try values.decodeIfPresent(String.self, forKey: .userName)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		result = try values.decodeIfPresent(Int.self, forKey: .result)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		userId = try values.decodeIfPresent(Int.self, forKey: .userId)
		c_MerchantId = try values.decodeIfPresent(Int.self, forKey: .c_MerchantId)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
		commonUserMobile = try values.decodeIfPresent(String.self, forKey: .commonUserMobile)
		commonUserName = try values.decodeIfPresent(String.self, forKey: .commonUserName)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		custAccountNumber = try values.decodeIfPresent(String.self, forKey: .custAccountNumber)
		custAccountType = try values.decodeIfPresent(String.self, forKey: .custAccountType)
		customerGrade = try values.decodeIfPresent(String.self, forKey: .customerGrade)
		customerTypeID = try values.decodeIfPresent(Int.self, forKey: .customerTypeID)
		dOB = try values.decodeIfPresent(String.self, forKey: .dOB)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		encrypted_OTP_PIN = try values.decodeIfPresent(String.self, forKey: .encrypted_OTP_PIN)
		isBlacklisted = try values.decodeIfPresent(Int.self, forKey: .isBlacklisted)
		isDelete = try values.decodeIfPresent(Int.self, forKey: .isDelete)
		isDormant = try values.decodeIfPresent(Int.self, forKey: .isDormant)
		isGeofenceActive = try values.decodeIfPresent(Int.self, forKey: .isGeofenceActive)
		isOnHold = try values.decodeIfPresent(Int.self, forKey: .isOnHold)
		isUserActive = try values.decodeIfPresent(Int.self, forKey: .isUserActive)
		language = try values.decodeIfPresent(String.self, forKey: .language)
		locationCountryID = try values.decodeIfPresent(Int.self, forKey: .locationCountryID)
		locationId = try values.decodeIfPresent(Int.self, forKey: .locationId)
		locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
		locationType = try values.decodeIfPresent(String.self, forKey: .locationType)
		memberSince = try values.decodeIfPresent(String.self, forKey: .memberSince)
		merchantEmailID = try values.decodeIfPresent(String.self, forKey: .merchantEmailID)
		merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
		merchantMobileNo = try values.decodeIfPresent(String.self, forKey: .merchantMobileNo)
		merchantName = try values.decodeIfPresent(String.self, forKey: .merchantName)
		merchant_logo = try values.decodeIfPresent(String.self, forKey: .merchant_logo)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		parentLocationId = try values.decodeIfPresent(Int.self, forKey: .parentLocationId)
		parentLocationName = try values.decodeIfPresent(String.self, forKey: .parentLocationName)
		pinStatus = try values.decodeIfPresent(Int.self, forKey: .pinStatus)
		prefix = try values.decodeIfPresent(String.self, forKey: .prefix)
		roleName = try values.decodeIfPresent(String.self, forKey: .roleName)
		superParentLocationId = try values.decodeIfPresent(Int.self, forKey: .superParentLocationId)
		userGender = try values.decodeIfPresent(String.self, forKey: .userGender)
		userImage = try values.decodeIfPresent(String.self, forKey: .userImage)
		userLastName = try values.decodeIfPresent(String.self, forKey: .userLastName)
		userType = try values.decodeIfPresent(String.self, forKey: .userType)
		verifiedStatus = try values.decodeIfPresent(Int.self, forKey: .verifiedStatus)
	}

}
