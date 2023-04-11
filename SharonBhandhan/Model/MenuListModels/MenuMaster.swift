
import Foundation
struct MenuMaster : Codable {
	let actionType : Int?
	let actorId : Int?
	let actorRole : String?
	let isActive : Bool?
	let token : String?
	let customerIsActive : Bool?
	let idMenu : Int?
	let iduser : Int?
	let menuIcon : String?
	let menuName : String?
	let menuSourceId : Int?
	let menuType : String?
	let menuURL : String?
	let parentID : Int?
	let roleId : Int?
	let row : Int?
	let status : String?

	enum CodingKeys: String, CodingKey {

		case actionType = "ActionType"
		case actorId = "ActorId"
		case actorRole = "ActorRole"
		case isActive = "IsActive"
		case token = "Token"
		case customerIsActive = "CustomerIsActive"
		case idMenu = "IdMenu"
		case iduser = "Iduser"
		case menuIcon = "MenuIcon"
		case menuName = "MenuName"
		case menuSourceId = "MenuSourceId"
		case menuType = "MenuType"
		case menuURL = "MenuURL"
		case parentID = "ParentID"
		case roleId = "RoleId"
		case row = "Row"
		case status = "Status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
		actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
		actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		customerIsActive = try values.decodeIfPresent(Bool.self, forKey: .customerIsActive)
		idMenu = try values.decodeIfPresent(Int.self, forKey: .idMenu)
		iduser = try values.decodeIfPresent(Int.self, forKey: .iduser)
		menuIcon = try values.decodeIfPresent(String.self, forKey: .menuIcon)
		menuName = try values.decodeIfPresent(String.self, forKey: .menuName)
		menuSourceId = try values.decodeIfPresent(Int.self, forKey: .menuSourceId)
		menuType = try values.decodeIfPresent(String.self, forKey: .menuType)
		menuURL = try values.decodeIfPresent(String.self, forKey: .menuURL)
		parentID = try values.decodeIfPresent(Int.self, forKey: .parentID)
		roleId = try values.decodeIfPresent(Int.self, forKey: .roleId)
		row = try values.decodeIfPresent(Int.self, forKey: .row)
		status = try values.decodeIfPresent(String.self, forKey: .status)
	}

}
