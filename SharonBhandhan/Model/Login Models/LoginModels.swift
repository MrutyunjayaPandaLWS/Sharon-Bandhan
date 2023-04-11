

import Foundation
struct LoginModels : Codable {
	let merchantImageDetails : String?
	let userId : Int?
	let userList : [UserList]?
	let lstMerchantImageDetails : String?
	let objUserDetailedInfo : String?

	enum CodingKeys: String, CodingKey {

		case merchantImageDetails = "MerchantImageDetails"
		case userId = "UserId"
		case userList = "UserList"
		case lstMerchantImageDetails = "lstMerchantImageDetails"
		case objUserDetailedInfo = "objUserDetailedInfo"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		merchantImageDetails = try values.decodeIfPresent(String.self, forKey: .merchantImageDetails)
		userId = try values.decodeIfPresent(Int.self, forKey: .userId)
		userList = try values.decodeIfPresent([UserList].self, forKey: .userList)
		lstMerchantImageDetails = try values.decodeIfPresent(String.self, forKey: .lstMerchantImageDetails)
		objUserDetailedInfo = try values.decodeIfPresent(String.self, forKey: .objUserDetailedInfo)
	}

}
