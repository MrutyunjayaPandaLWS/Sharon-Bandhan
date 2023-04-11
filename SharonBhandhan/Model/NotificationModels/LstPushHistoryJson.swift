/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstPushHistoryJson : Codable {
	let createdBy : Int?
	let createdDate : String?
	let imagesURL : String?
	let isActive : Int?
	let isRead : Int?
	let jCreatedDate : String?
	let loyaltyId : String?
	let modifiedBy : Int?
	let pushHistoryId : Int?
	let pushId : String?
	let pushMessage : String?
	let pushType : String?
	let sourceType : String?
	let title : String?

	enum CodingKeys: String, CodingKey {

		case createdBy = "CreatedBy"
		case createdDate = "CreatedDate"
		case imagesURL = "ImagesURL"
		case isActive = "IsActive"
		case isRead = "IsRead"
		case jCreatedDate = "JCreatedDate"
		case loyaltyId = "LoyaltyId"
		case modifiedBy = "ModifiedBy"
		case pushHistoryId = "PushHistoryId"
		case pushId = "PushId"
		case pushMessage = "PushMessage"
		case pushType = "PushType"
		case sourceType = "SourceType"
		case title = "Title"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		createdBy = try values.decodeIfPresent(Int.self, forKey: .createdBy)
		createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
		imagesURL = try values.decodeIfPresent(String.self, forKey: .imagesURL)
		isActive = try values.decodeIfPresent(Int.self, forKey: .isActive)
		isRead = try values.decodeIfPresent(Int.self, forKey: .isRead)
		jCreatedDate = try values.decodeIfPresent(String.self, forKey: .jCreatedDate)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		modifiedBy = try values.decodeIfPresent(Int.self, forKey: .modifiedBy)
		pushHistoryId = try values.decodeIfPresent(Int.self, forKey: .pushHistoryId)
		pushId = try values.decodeIfPresent(String.self, forKey: .pushId)
		pushMessage = try values.decodeIfPresent(String.self, forKey: .pushMessage)
		pushType = try values.decodeIfPresent(String.self, forKey: .pushType)
		sourceType = try values.decodeIfPresent(String.self, forKey: .sourceType)
		title = try values.decodeIfPresent(String.self, forKey: .title)
	}

}