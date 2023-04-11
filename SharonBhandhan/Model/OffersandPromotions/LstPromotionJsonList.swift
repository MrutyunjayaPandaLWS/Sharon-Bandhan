

import Foundation
struct LstPromotionJsonList : Codable {
	let promotionId : Int?
	let actionUrl : String?
	let albumImageID : Int?
	let allowUnReserve : Bool?
	let approvalStatus : String?
	let approvalStatusID : Int?
	let canClaim : Bool?
	let canComment : Bool?
	let canReverse : Bool?
	let canView : Bool?
	let categoryId : Int?
	let categoryName : String?
	let claim : String?
	let cliamIdUsageStatus : Bool?
	let comment : String?
	let emailID : String?
	let firstName : String?
	let footer : String?
	let fullName : String?
	let isApprovable : Bool?
	let isClaimed : Bool?
	let isReservable : Bool?
	let isReserved : Bool?
	let is_Expired : Bool?
	let lastName : String?
	let memberId : String?
	let memberName : String?
	let mobileNo : String?
	let outletName : String?
	let pointBalance : Int?
	let proImage : String?
	let proLongDesc : String?
	let proShortDesc : String?
	let promotionName : String?
	let promotionTypeName : String?
	let promotion_Type : Int?
	let pushUserActionID : Int?
	let redeemLocationAll : Bool?
	let remarks : String?
	let reserve : String?
	let targetCustomers : Int?
	let title : String?
	let totalBlocks : Int?
	let totalClaims : Int?
	let totalComment : Int?
	let totalRecords : Int?
	let totalResponses : Int?
	let totalViews : Int?
	let url : String?
	let validFrom : String?
	let validTo : String?
	let validity : String?
	let view : String?
	let views : Int?
	let is_Active : Bool?

	enum CodingKeys: String, CodingKey {

		case promotionId = "PromotionId"
		case actionUrl = "ActionUrl"
		case albumImageID = "AlbumImageID"
		case allowUnReserve = "AllowUnReserve"
		case approvalStatus = "ApprovalStatus"
		case approvalStatusID = "ApprovalStatusID"
		case canClaim = "CanClaim"
		case canComment = "CanComment"
		case canReverse = "CanReverse"
		case canView = "CanView"
		case categoryId = "CategoryId"
		case categoryName = "CategoryName"
		case claim = "Claim"
		case cliamIdUsageStatus = "CliamIdUsageStatus"
		case comment = "Comment"
		case emailID = "EmailID"
		case firstName = "FirstName"
		case footer = "Footer"
		case fullName = "FullName"
		case isApprovable = "IsApprovable"
		case isClaimed = "IsClaimed"
		case isReservable = "IsReservable"
		case isReserved = "IsReserved"
		case is_Expired = "Is_Expired"
		case lastName = "LastName"
		case memberId = "MemberId"
		case memberName = "MemberName"
		case mobileNo = "MobileNo"
		case outletName = "OutletName"
		case pointBalance = "PointBalance"
		case proImage = "ProImage"
		case proLongDesc = "ProLongDesc"
		case proShortDesc = "ProShortDesc"
		case promotionName = "PromotionName"
		case promotionTypeName = "PromotionTypeName"
		case promotion_Type = "Promotion_Type"
		case pushUserActionID = "PushUserActionID"
		case redeemLocationAll = "RedeemLocationAll"
		case remarks = "Remarks"
		case reserve = "Reserve"
		case targetCustomers = "TargetCustomers"
		case title = "Title"
		case totalBlocks = "TotalBlocks"
		case totalClaims = "TotalClaims"
		case totalComment = "TotalComment"
		case totalRecords = "TotalRecords"
		case totalResponses = "TotalResponses"
		case totalViews = "TotalViews"
		case url = "Url"
		case validFrom = "ValidFrom"
		case validTo = "ValidTo"
		case validity = "Validity"
		case view = "View"
		case views = "Views"
		case is_Active = "is_Active"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		promotionId = try values.decodeIfPresent(Int.self, forKey: .promotionId)
		actionUrl = try values.decodeIfPresent(String.self, forKey: .actionUrl)
		albumImageID = try values.decodeIfPresent(Int.self, forKey: .albumImageID)
		allowUnReserve = try values.decodeIfPresent(Bool.self, forKey: .allowUnReserve)
		approvalStatus = try values.decodeIfPresent(String.self, forKey: .approvalStatus)
		approvalStatusID = try values.decodeIfPresent(Int.self, forKey: .approvalStatusID)
		canClaim = try values.decodeIfPresent(Bool.self, forKey: .canClaim)
		canComment = try values.decodeIfPresent(Bool.self, forKey: .canComment)
		canReverse = try values.decodeIfPresent(Bool.self, forKey: .canReverse)
		canView = try values.decodeIfPresent(Bool.self, forKey: .canView)
		categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
		categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
		claim = try values.decodeIfPresent(String.self, forKey: .claim)
		cliamIdUsageStatus = try values.decodeIfPresent(Bool.self, forKey: .cliamIdUsageStatus)
		comment = try values.decodeIfPresent(String.self, forKey: .comment)
		emailID = try values.decodeIfPresent(String.self, forKey: .emailID)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		footer = try values.decodeIfPresent(String.self, forKey: .footer)
		fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
		isApprovable = try values.decodeIfPresent(Bool.self, forKey: .isApprovable)
		isClaimed = try values.decodeIfPresent(Bool.self, forKey: .isClaimed)
		isReservable = try values.decodeIfPresent(Bool.self, forKey: .isReservable)
		isReserved = try values.decodeIfPresent(Bool.self, forKey: .isReserved)
		is_Expired = try values.decodeIfPresent(Bool.self, forKey: .is_Expired)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		memberId = try values.decodeIfPresent(String.self, forKey: .memberId)
		memberName = try values.decodeIfPresent(String.self, forKey: .memberName)
		mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
		outletName = try values.decodeIfPresent(String.self, forKey: .outletName)
		pointBalance = try values.decodeIfPresent(Int.self, forKey: .pointBalance)
		proImage = try values.decodeIfPresent(String.self, forKey: .proImage)
		proLongDesc = try values.decodeIfPresent(String.self, forKey: .proLongDesc)
		proShortDesc = try values.decodeIfPresent(String.self, forKey: .proShortDesc)
		promotionName = try values.decodeIfPresent(String.self, forKey: .promotionName)
		promotionTypeName = try values.decodeIfPresent(String.self, forKey: .promotionTypeName)
		promotion_Type = try values.decodeIfPresent(Int.self, forKey: .promotion_Type)
		pushUserActionID = try values.decodeIfPresent(Int.self, forKey: .pushUserActionID)
		redeemLocationAll = try values.decodeIfPresent(Bool.self, forKey: .redeemLocationAll)
		remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
		reserve = try values.decodeIfPresent(String.self, forKey: .reserve)
		targetCustomers = try values.decodeIfPresent(Int.self, forKey: .targetCustomers)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		totalBlocks = try values.decodeIfPresent(Int.self, forKey: .totalBlocks)
		totalClaims = try values.decodeIfPresent(Int.self, forKey: .totalClaims)
		totalComment = try values.decodeIfPresent(Int.self, forKey: .totalComment)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		totalResponses = try values.decodeIfPresent(Int.self, forKey: .totalResponses)
		totalViews = try values.decodeIfPresent(Int.self, forKey: .totalViews)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		validFrom = try values.decodeIfPresent(String.self, forKey: .validFrom)
		validTo = try values.decodeIfPresent(String.self, forKey: .validTo)
		validity = try values.decodeIfPresent(String.self, forKey: .validity)
		view = try values.decodeIfPresent(String.self, forKey: .view)
		views = try values.decodeIfPresent(Int.self, forKey: .views)
		is_Active = try values.decodeIfPresent(Bool.self, forKey: .is_Active)
	}

}
