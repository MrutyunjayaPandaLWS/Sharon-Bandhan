//
//  ProfileImageUpdateModel.swift
//  SharonBhandhan
//
//  Created by admin on 19/05/23.
//

import Foundation

struct ProfileImageUpdateModel : Codable {
    let returnMessage : String?
    let returnValue : Int?
    let totalRecords : Int?

    enum CodingKeys: String, CodingKey {

        case returnMessage = "ReturnMessage"
        case returnValue = "ReturnValue"
        case totalRecords = "TotalRecords"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
        returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
        totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
    }

}
