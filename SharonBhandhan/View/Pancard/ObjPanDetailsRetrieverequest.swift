/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

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