

import Foundation
struct MyCartModels : Codable {
    let returnMessage : String?
    let returnValue : Int?
    let totalRecords : Int?
    let catalogueSaveCartDetailListResponse : [CatalogueSaveCartDetailListResponse1]?
    let totalCartCatalogue : Int?

    enum CodingKeys: String, CodingKey {

        case returnMessage = "ReturnMessage"
        case returnValue = "ReturnValue"
        case totalRecords = "TotalRecords"
        case catalogueSaveCartDetailListResponse = "CatalogueSaveCartDetailListResponse"
        case totalCartCatalogue = "TotalCartCatalogue"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
        returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
        totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
        catalogueSaveCartDetailListResponse = try values.decodeIfPresent([CatalogueSaveCartDetailListResponse1].self, forKey: .catalogueSaveCartDetailListResponse)
        totalCartCatalogue = try values.decodeIfPresent(Int.self, forKey: .totalCartCatalogue)
    }

}
