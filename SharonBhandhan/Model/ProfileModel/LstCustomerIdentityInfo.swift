

import Foundation
struct LstCustomerIdentityInfo : Codable {
	let identityDocument : String?
	let identityID : Int?
	let identityName : String?
	let identityNo : String?
	let identityType : String?
	let identityTypeID : Int?
	let isNewIdentity : Bool?

	enum CodingKeys: String, CodingKey {

		case identityDocument = "IdentityDocument"
		case identityID = "IdentityID"
		case identityName = "IdentityName"
		case identityNo = "IdentityNo"
		case identityType = "IdentityType"
		case identityTypeID = "IdentityTypeID"
		case isNewIdentity = "IsNewIdentity"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		identityDocument = try values.decodeIfPresent(String.self, forKey: .identityDocument)
		identityID = try values.decodeIfPresent(Int.self, forKey: .identityID)
		identityName = try values.decodeIfPresent(String.self, forKey: .identityName)
		identityNo = try values.decodeIfPresent(String.self, forKey: .identityNo)
		identityType = try values.decodeIfPresent(String.self, forKey: .identityType)
		identityTypeID = try values.decodeIfPresent(Int.self, forKey: .identityTypeID)
		isNewIdentity = try values.decodeIfPresent(Bool.self, forKey: .isNewIdentity)
	}

}
