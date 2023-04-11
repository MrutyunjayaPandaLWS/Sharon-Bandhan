

import Foundation
struct DashboardImagesModels : Codable {
	let objImageGalleryList : [ObjImageGalleryList]?

	enum CodingKeys: String, CodingKey {

		case objImageGalleryList = "ObjImageGalleryList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		objImageGalleryList = try values.decodeIfPresent([ObjImageGalleryList].self, forKey: .objImageGalleryList)
	}

}
