/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstTermsAndCondition : Codable {
	let actionType : Int?
	let actorId : Int?
	let actorRole : String?
	let isActive : Bool?
	let token : String?
	let color : String?
	let createDate : String?
	let fileName : String?
	let hTML : String?
	let language : String?
	let languageId : Int?
	let segmentId : Int?
	let segmentName : String?
	let segmentType : String?
	let statusName : String?
	let tCName : String?
	let termsAndConditionsId : Int?
	let wEFDate : String?

	enum CodingKeys: String, CodingKey {

		case actionType = "ActionType"
		case actorId = "ActorId"
		case actorRole = "ActorRole"
		case isActive = "IsActive"
		case token = "Token"
		case color = "Color"
		case createDate = "CreateDate"
		case fileName = "FileName"
		case hTML = "HTML"
		case language = "Language"
		case languageId = "LanguageId"
		case segmentId = "SegmentId"
		case segmentName = "SegmentName"
		case segmentType = "SegmentType"
		case statusName = "StatusName"
		case tCName = "TCName"
		case termsAndConditionsId = "TermsAndConditionsId"
		case wEFDate = "WEFDate"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
		actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
		actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		color = try values.decodeIfPresent(String.self, forKey: .color)
		createDate = try values.decodeIfPresent(String.self, forKey: .createDate)
		fileName = try values.decodeIfPresent(String.self, forKey: .fileName)
		hTML = try values.decodeIfPresent(String.self, forKey: .hTML)
		language = try values.decodeIfPresent(String.self, forKey: .language)
		languageId = try values.decodeIfPresent(Int.self, forKey: .languageId)
		segmentId = try values.decodeIfPresent(Int.self, forKey: .segmentId)
		segmentName = try values.decodeIfPresent(String.self, forKey: .segmentName)
		segmentType = try values.decodeIfPresent(String.self, forKey: .segmentType)
		statusName = try values.decodeIfPresent(String.self, forKey: .statusName)
		tCName = try values.decodeIfPresent(String.self, forKey: .tCName)
		termsAndConditionsId = try values.decodeIfPresent(Int.self, forKey: .termsAndConditionsId)
		wEFDate = try values.decodeIfPresent(String.self, forKey: .wEFDate)
	}

}