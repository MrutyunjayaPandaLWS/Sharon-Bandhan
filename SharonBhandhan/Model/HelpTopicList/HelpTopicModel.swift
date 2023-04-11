

import Foundation
struct HelpTopicModel : Codable {
	let getHelpTopicsResult : GetHelpTopicsResult?

	enum CodingKeys: String, CodingKey {

		case getHelpTopicsResult = "GetHelpTopicsResult"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		getHelpTopicsResult = try values.decodeIfPresent(GetHelpTopicsResult.self, forKey: .getHelpTopicsResult)
	}

}
