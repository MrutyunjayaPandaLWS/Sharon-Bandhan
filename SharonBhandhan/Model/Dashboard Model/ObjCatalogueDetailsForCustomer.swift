/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ObjCatalogueDetailsForCustomer : Codable {
	let catalogueId : Int?
	let catalogueImage : String?
	let catalogueName : String?
	let pointsBalance : Int?
	let pointsRequired : Int?
	let pointsRequiredToRedeem : Int?
	let redemptionType : Int?

	enum CodingKeys: String, CodingKey {

		case catalogueId = "CatalogueId"
		case catalogueImage = "CatalogueImage"
		case catalogueName = "CatalogueName"
		case pointsBalance = "PointsBalance"
		case pointsRequired = "PointsRequired"
		case pointsRequiredToRedeem = "PointsRequiredToRedeem"
		case redemptionType = "RedemptionType"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		catalogueId = try values.decodeIfPresent(Int.self, forKey: .catalogueId)
		catalogueImage = try values.decodeIfPresent(String.self, forKey: .catalogueImage)
		catalogueName = try values.decodeIfPresent(String.self, forKey: .catalogueName)
		pointsBalance = try values.decodeIfPresent(Int.self, forKey: .pointsBalance)
		pointsRequired = try values.decodeIfPresent(Int.self, forKey: .pointsRequired)
		pointsRequiredToRedeem = try values.decodeIfPresent(Int.self, forKey: .pointsRequiredToRedeem)
		redemptionType = try values.decodeIfPresent(Int.self, forKey: .redemptionType)
	}

}