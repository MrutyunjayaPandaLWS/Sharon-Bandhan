

import Foundation
struct MyRedeemptionDetailsModels : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let catalogueImageGallery : String?
	let locationCites : String?
	let objCatalogueCategoryList : String?
	let objCatalogueFixedPoints : String?
	let objCatalogueList : [MyRedeemptionDetailsData]?
	let objCatalogueRedemReqList : String?
	let objCustShippingAddressDetails : ObjCustShippingAddressDetails?
	let objDreamProduct : String?
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
		case objDreamProduct = "ObjDreamProduct"
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
		objCatalogueList = try values.decodeIfPresent([MyRedeemptionDetailsData].self, forKey: .objCatalogueList)
		objCatalogueRedemReqList = try values.decodeIfPresent(String.self, forKey: .objCatalogueRedemReqList)
		objCustShippingAddressDetails = try values.decodeIfPresent(ObjCustShippingAddressDetails.self, forKey: .objCustShippingAddressDetails)
		objDreamProduct = try values.decodeIfPresent(String.self, forKey: .objDreamProduct)
		lstCatalogueProductAvailableCity = try values.decodeIfPresent(String.self, forKey: .lstCatalogueProductAvailableCity)
	}

}
