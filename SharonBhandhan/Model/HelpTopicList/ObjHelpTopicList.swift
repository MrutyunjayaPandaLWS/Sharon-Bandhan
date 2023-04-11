

import Foundation
struct ObjHelpTopicList : Codable {
	let createDate : String?
	let customerView : Bool?
	let escalationInHours : Int?
	let helpTopicId : Int?
	let helpTopicName : String?
	let iS_ACTIVE : Bool?
	let subHelpTopicId : Int?
	let subHelpTopicName : String?
	let type : Int?

	enum CodingKeys: String, CodingKey {

		case createDate = "CreateDate"
		case customerView = "CustomerView"
		case escalationInHours = "EscalationInHours"
		case helpTopicId = "HelpTopicId"
		case helpTopicName = "HelpTopicName"
		case iS_ACTIVE = "IS_ACTIVE"
		case subHelpTopicId = "SubHelpTopicId"
		case subHelpTopicName = "SubHelpTopicName"
		case type = "Type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
		customerView = try values.decodeIfPresent(Bool.self, forKey: .customerView)
		escalationInHours = try values.decodeIfPresent(Int.self, forKey: .escalationInHours)
		helpTopicId = try values.decodeIfPresent(Int.self, forKey: .helpTopicId)
		helpTopicName = try values.decodeIfPresent(String.self, forKey: .helpTopicName)
		iS_ACTIVE = try values.decodeIfPresent(Bool.self, forKey: .iS_ACTIVE)
		subHelpTopicId = try values.decodeIfPresent(Int.self, forKey: .subHelpTopicId)
		subHelpTopicName = try values.decodeIfPresent(String.self, forKey: .subHelpTopicName)
		type = try values.decodeIfPresent(Int.self, forKey: .type)
	}

}
