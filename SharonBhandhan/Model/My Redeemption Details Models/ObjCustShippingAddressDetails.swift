
import Foundation
struct ObjCustShippingAddressDetails : Codable {
	let actionType : Int?
	let actorId : Int?
	let actorRole : String?
	let isActive : Bool?
	let token : String?
	let address1 : String?
	let address2 : String?
	let addressId : Int?
	let cityId : Int?
	let cityName : String?
	let countryId : Int?
	let countryName : String?
	let landmark : String?
	let stateId : Int?
	let stateName : String?
	let zip : String?
	let addressType : String?
	let districid : Int?
	let email : String?
	let fullName : String?
	let mobile : String?
	let redemptionId : Int?
	let shippingAddressId : Int?

	enum CodingKeys: String, CodingKey {

		case actionType = "ActionType"
		case actorId = "ActorId"
		case actorRole = "ActorRole"
		case isActive = "IsActive"
		case token = "Token"
		case address1 = "Address1"
		case address2 = "Address2"
		case addressId = "AddressId"
		case cityId = "CityId"
		case cityName = "CityName"
		case countryId = "CountryId"
		case countryName = "CountryName"
		case landmark = "Landmark"
		case stateId = "StateId"
		case stateName = "StateName"
		case zip = "Zip"
		case addressType = "AddressType"
		case districid = "Districid"
		case email = "Email"
		case fullName = "FullName"
		case mobile = "Mobile"
		case redemptionId = "RedemptionId"
		case shippingAddressId = "ShippingAddressId"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
		actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
		actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		address1 = try values.decodeIfPresent(String.self, forKey: .address1)
		address2 = try values.decodeIfPresent(String.self, forKey: .address2)
		addressId = try values.decodeIfPresent(Int.self, forKey: .addressId)
		cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
		countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
		countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
		landmark = try values.decodeIfPresent(String.self, forKey: .landmark)
		stateId = try values.decodeIfPresent(Int.self, forKey: .stateId)
		stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
		zip = try values.decodeIfPresent(String.self, forKey: .zip)
		addressType = try values.decodeIfPresent(String.self, forKey: .addressType)
		districid = try values.decodeIfPresent(Int.self, forKey: .districid)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		redemptionId = try values.decodeIfPresent(Int.self, forKey: .redemptionId)
		shippingAddressId = try values.decodeIfPresent(Int.self, forKey: .shippingAddressId)
	}

}
