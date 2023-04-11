
import Foundation
struct RemoveGiftModels : Codable {
    let returnMessage : String?
    let returnValue : Int?
    let totalRecords : Int?
    let dreamGiftName : String?
    let memberName : String?
    let mobile : String?
    let points : String?

    enum CodingKeys: String, CodingKey {

        case returnMessage = "ReturnMessage"
        case returnValue = "ReturnValue"
        case totalRecords = "TotalRecords"
        case dreamGiftName = "DreamGiftName"
        case memberName = "MemberName"
        case mobile = "Mobile"
        case points = "Points"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
        returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
        totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
        dreamGiftName = try values.decodeIfPresent(String.self, forKey: .dreamGiftName)
        memberName = try values.decodeIfPresent(String.self, forKey: .memberName)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        points = try values.decodeIfPresent(String.self, forKey: .points)
    }

}
