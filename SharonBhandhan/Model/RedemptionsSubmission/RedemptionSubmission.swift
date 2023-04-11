

import Foundation
struct RedemptionSubmission : Codable {
    let returnMessage : String?
    let returnValue : Int?
    let totalRecords : Int?
    let membershipID : String?
    let objCatalogueList : String?
    let pdfLink : String?
    let redemptionReferenceNumber : String?
    let redemptionStatus : String?
    let responseCode : String?
    let uniqueID : String?
    let userId : Int?

    enum CodingKeys: String, CodingKey {

        case returnMessage = "ReturnMessage"
        case returnValue = "ReturnValue"
        case totalRecords = "TotalRecords"
        case membershipID = "MembershipID"
        case objCatalogueList = "ObjCatalogueList"
        case pdfLink = "PdfLink"
        case redemptionReferenceNumber = "RedemptionReferenceNumber"
        case redemptionStatus = "RedemptionStatus"
        case responseCode = "ResponseCode"
        case uniqueID = "UniqueID"
        case userId = "UserId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
        returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
        totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
        membershipID = try values.decodeIfPresent(String.self, forKey: .membershipID)
        objCatalogueList = try values.decodeIfPresent(String.self, forKey: .objCatalogueList)
        pdfLink = try values.decodeIfPresent(String.self, forKey: .pdfLink)
        redemptionReferenceNumber = try values.decodeIfPresent(String.self, forKey: .redemptionReferenceNumber)
        redemptionStatus = try values.decodeIfPresent(String.self, forKey: .redemptionStatus)
        responseCode = try values.decodeIfPresent(String.self, forKey: .responseCode)
        uniqueID = try values.decodeIfPresent(String.self, forKey: .uniqueID)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }

}
