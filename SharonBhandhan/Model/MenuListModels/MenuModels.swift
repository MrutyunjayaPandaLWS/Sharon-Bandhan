
import Foundation
struct MenuModels : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let groupMenuList : String?
	let menuList : String?
	let menuMaster : [MenuMaster]?
	let menuMaster1 : [String]?
	let menuMaster2 : String?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case groupMenuList = "GroupMenuList"
		case menuList = "MenuList"
		case menuMaster = "MenuMaster"
		case menuMaster1 = "MenuMaster1"
		case menuMaster2 = "MenuMaster2"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		groupMenuList = try values.decodeIfPresent(String.self, forKey: .groupMenuList)
		menuList = try values.decodeIfPresent(String.self, forKey: .menuList)
		menuMaster = try values.decodeIfPresent([MenuMaster].self, forKey: .menuMaster)
		menuMaster1 = try values.decodeIfPresent([String].self, forKey: .menuMaster1)
		menuMaster2 = try values.decodeIfPresent(String.self, forKey: .menuMaster2)
	}

}
