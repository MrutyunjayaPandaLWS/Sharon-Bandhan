

import Foundation
struct GetCustomerDetailsMobileAppResult : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let lstCustomerIdentityInfo : [LstCustomerIdentityInfo]?
	let lstCustomerJson : [LstCustomerJson]?
	let lstCustomerOfficalInfoJson : [LstCustomerOfficalInfoJson]?
	let lstVehicleJson : [String]?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case lstCustomerIdentityInfo = "lstCustomerIdentityInfo"
		case lstCustomerJson = "lstCustomerJson"
		case lstCustomerOfficalInfoJson = "lstCustomerOfficalInfoJson"
		case lstVehicleJson = "lstVehicleJson"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		lstCustomerIdentityInfo = try values.decodeIfPresent([LstCustomerIdentityInfo].self, forKey: .lstCustomerIdentityInfo)
		lstCustomerJson = try values.decodeIfPresent([LstCustomerJson].self, forKey: .lstCustomerJson)
		lstCustomerOfficalInfoJson = try values.decodeIfPresent([LstCustomerOfficalInfoJson].self, forKey: .lstCustomerOfficalInfoJson)
		lstVehicleJson = try values.decodeIfPresent([String].self, forKey: .lstVehicleJson)
	}

}
