
import Foundation
struct ObjPanDetailsRetrieverequest : Codable {
	let actionType : Int?
	let actorId : Int?
	let actorRole : String?
	let isActive : Bool?
	let token : String?
	let dateOfBirth : String?
	let firstName : String?
	let isPanValid : Int?
	let lastName : String?
	let loyaltyId : String?
	let panImage : String?
	let panNumber : String?

	enum CodingKeys: String, CodingKey {

		case actionType = "ActionType"
		case actorId = "ActorId"
		case actorRole = "ActorRole"
		case isActive = "IsActive"
		case token = "Token"
		case dateOfBirth = "DateOfBirth"
		case firstName = "FirstName"
		case isPanValid = "IsPanValid"
		case lastName = "LastName"
		case loyaltyId = "LoyaltyId"
		case panImage = "PanImage"
		case panNumber = "PanNumber"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
		actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
		actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		isPanValid = try values.decodeIfPresent(Int.self, forKey: .isPanValid)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		panImage = try values.decodeIfPresent(String.self, forKey: .panImage)
		panNumber = try values.decodeIfPresent(String.self, forKey: .panNumber)
	}

}
