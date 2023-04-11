/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct MyRedemptionModels: Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let catalogueImageGallery : String?
	let locationCites : String?
	let objCatalogueCategoryList : String?
	let objCatalogueFixedPoints : String?
	let objCatalogueList : String?
	let objCatalogueRedemReqList : [ObjCatalogueRedemReqList]?
	let objCustShippingAddressDetails : String?
	let lstCatalogueProductAvailableCity : String?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case catalogueImageGallery = "CatalogueImageGallery"
		case locationCites = "LocationCites"
		case objCatalogueCategoryList = "ObjCatalogueCategoryList"
		case objCatalogueFixedPoints = "ObjCatalogueFixedPoints"
		case objCatalogueList = "ObjCatalogueList"
		case objCatalogueRedemReqList = "ObjCatalogueRedemReqList"
		case objCustShippingAddressDetails = "ObjCustShippingAddressDetails"
		case lstCatalogueProductAvailableCity = "lstCatalogueProductAvailableCity"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		catalogueImageGallery = try values.decodeIfPresent(String.self, forKey: .catalogueImageGallery)
		locationCites = try values.decodeIfPresent(String.self, forKey: .locationCites)
		objCatalogueCategoryList = try values.decodeIfPresent(String.self, forKey: .objCatalogueCategoryList)
		objCatalogueFixedPoints = try values.decodeIfPresent(String.self, forKey: .objCatalogueFixedPoints)
		objCatalogueList = try values.decodeIfPresent(String.self, forKey: .objCatalogueList)
		objCatalogueRedemReqList = try values.decodeIfPresent([ObjCatalogueRedemReqList].self, forKey: .objCatalogueRedemReqList)
		objCustShippingAddressDetails = try values.decodeIfPresent(String.self, forKey: .objCustShippingAddressDetails)
		lstCatalogueProductAvailableCity = try values.decodeIfPresent(String.self, forKey: .lstCatalogueProductAvailableCity)
	}

}
