

import Foundation
struct StateList : Codable {
	let row : Int?
	let countryCode : String?
	let countryId : Int?
	let countryName : String?
	let countryType : String?
	let isActive : Bool?
	let mobilePrefix : String?
	let stateCode : String?
	let stateId : Int?
	let stateName : String?

	enum CodingKeys: String, CodingKey {

		case row = "Row"
		case countryCode = "CountryCode"
		case countryId = "CountryId"
		case countryName = "CountryName"
		case countryType = "CountryType"
		case isActive = "IsActive"
		case mobilePrefix = "MobilePrefix"
		case stateCode = "StateCode"
		case stateId = "StateId"
		case stateName = "StateName"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		row = try values.decodeIfPresent(Int.self, forKey: .row)
		countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
		countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
		countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
		countryType = try values.decodeIfPresent(String.self, forKey: .countryType)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		mobilePrefix = try values.decodeIfPresent(String.self, forKey: .mobilePrefix)
		stateCode = try values.decodeIfPresent(String.self, forKey: .stateCode)
		stateId = try values.decodeIfPresent(Int.self, forKey: .stateId)
		stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
	}

}
