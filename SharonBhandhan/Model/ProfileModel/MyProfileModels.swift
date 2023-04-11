

import Foundation
struct MyProfileModels : Codable {
	let getCustomerDetailsMobileAppResult : GetCustomerDetailsMobileAppResult?

	enum CodingKeys: String, CodingKey {

		case getCustomerDetailsMobileAppResult = "GetCustomerDetailsMobileAppResult"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		getCustomerDetailsMobileAppResult = try values.decodeIfPresent(GetCustomerDetailsMobileAppResult.self, forKey: .getCustomerDetailsMobileAppResult)
	}

}
