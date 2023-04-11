

import Foundation
struct LstScannedCode : Codable {
	let qRCode : String?

	enum CodingKeys: String, CodingKey {

		case qRCode = "QRCode"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		qRCode = try values.decodeIfPresent(String.self, forKey: .qRCode)
	}

}
