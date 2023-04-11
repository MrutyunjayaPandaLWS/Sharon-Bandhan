
import Foundation
struct RedemptionCategoryModels : Codable {
	let getCatalogueCategoryDetailsResult : GetCatalogueCategoryDetailsResult?

	enum CodingKeys: String, CodingKey {

		case getCatalogueCategoryDetailsResult = "GetCatalogueCategoryDetailsResult"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		getCatalogueCategoryDetailsResult = try values.decodeIfPresent(GetCatalogueCategoryDetailsResult.self, forKey: .getCatalogueCategoryDetailsResult)
	}

}
