/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstDreamGift : Codable {
    let actionType : Int?
    let actorId : Int?
    let actorRole : String?
    let isActive : Bool?
    let token : String?
    let address : String?
    let avgEarningPoints : Int?
    let contractorName : String?
    let dreamGiftDescription : String?
    let dreamGiftId : Int?
    let dreamGiftName : String?
    let earlyExpectedDate : String?
    let earlyExpectedPoints : Int?
    let expectedDate : String?
    let giftImage : String?
    let giftStatusId : Int?
    let giftType : String?
    let is_Redeemable : Int?
    let jCreatedDate : String?
    let jDesiredDate : String?
    let lateExpectedDate : String?
    let lateExpectedPoints : Int?
    let loyaltyID : String?
    let mobile : String?
    let pointsBalance : Int?
    let pointsRequired : Int?
    let remark : String?
    let role : String?
    let status : String?
    let tdsPoints : Int?
    let totRow : Int?

    enum CodingKeys: String, CodingKey {

        case actionType = "ActionType"
        case actorId = "ActorId"
        case actorRole = "ActorRole"
        case isActive = "IsActive"
        case token = "Token"
        case address = "Address"
        case avgEarningPoints = "AvgEarningPoints"
        case contractorName = "ContractorName"
        case dreamGiftDescription = "DreamGiftDescription"
        case dreamGiftId = "DreamGiftId"
        case dreamGiftName = "DreamGiftName"
        case earlyExpectedDate = "EarlyExpectedDate"
        case earlyExpectedPoints = "EarlyExpectedPoints"
        case expectedDate = "ExpectedDate"
        case giftImage = "GiftImage"
        case giftStatusId = "GiftStatusId"
        case giftType = "GiftType"
        case is_Redeemable = "Is_Redeemable"
        case jCreatedDate = "JCreatedDate"
        case jDesiredDate = "JDesiredDate"
        case lateExpectedDate = "LateExpectedDate"
        case lateExpectedPoints = "LateExpectedPoints"
        case loyaltyID = "LoyaltyID"
        case mobile = "Mobile"
        case pointsBalance = "PointsBalance"
        case pointsRequired = "PointsRequired"
        case remark = "Remark"
        case role = "Role"
        case status = "Status"
        case tdsPoints = "TdsPoints"
        case totRow = "TotRow"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
        actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
        actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        avgEarningPoints = try values.decodeIfPresent(Int.self, forKey: .avgEarningPoints)
        contractorName = try values.decodeIfPresent(String.self, forKey: .contractorName)
        dreamGiftDescription = try values.decodeIfPresent(String.self, forKey: .dreamGiftDescription)
        dreamGiftId = try values.decodeIfPresent(Int.self, forKey: .dreamGiftId)
        dreamGiftName = try values.decodeIfPresent(String.self, forKey: .dreamGiftName)
        earlyExpectedDate = try values.decodeIfPresent(String.self, forKey: .earlyExpectedDate)
        earlyExpectedPoints = try values.decodeIfPresent(Int.self, forKey: .earlyExpectedPoints)
        expectedDate = try values.decodeIfPresent(String.self, forKey: .expectedDate)
        giftImage = try values.decodeIfPresent(String.self, forKey: .giftImage)
        giftStatusId = try values.decodeIfPresent(Int.self, forKey: .giftStatusId)
        giftType = try values.decodeIfPresent(String.self, forKey: .giftType)
        is_Redeemable = try values.decodeIfPresent(Int.self, forKey: .is_Redeemable)
        jCreatedDate = try values.decodeIfPresent(String.self, forKey: .jCreatedDate)
        jDesiredDate = try values.decodeIfPresent(String.self, forKey: .jDesiredDate)
        lateExpectedDate = try values.decodeIfPresent(String.self, forKey: .lateExpectedDate)
        lateExpectedPoints = try values.decodeIfPresent(Int.self, forKey: .lateExpectedPoints)
        loyaltyID = try values.decodeIfPresent(String.self, forKey: .loyaltyID)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        pointsBalance = try values.decodeIfPresent(Int.self, forKey: .pointsBalance)
        pointsRequired = try values.decodeIfPresent(Int.self, forKey: .pointsRequired)
        remark = try values.decodeIfPresent(String.self, forKey: .remark)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        tdsPoints = try values.decodeIfPresent(Int.self, forKey: .tdsPoints)
        totRow = try values.decodeIfPresent(Int.self, forKey: .totRow)
    }

}
