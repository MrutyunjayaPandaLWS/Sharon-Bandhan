

import Foundation
struct ObjCustomerAllQueryJsonList : Codable {
	let comments : String?
	let createdDate : String?
	let customerTicketID : Int?
	let customerTicketRefNo : String?
	let deviceId : String?
	let helpTopic : String?
	let helpTopicID : Int?
	let jCreatedDate : String?
	let jLastModifiedDate : String?
	let lastModifiedDate : String?
	let memberId : String?
	let memberName : String?
	let mobile : String?
	let modifiedBy : String?
	let queryDetails : String?
	let querySource : String?
	let querySummary : String?
	let rating : String?
	let subHelpTopic : String?
	let subHelpTopicID : Int?
	let ticketStatus : String?
	let totalRows : Int?

	enum CodingKeys: String, CodingKey {

		case comments = "Comments"
		case createdDate = "CreatedDate"
		case customerTicketID = "CustomerTicketID"
		case customerTicketRefNo = "CustomerTicketRefNo"
		case deviceId = "DeviceId"
		case helpTopic = "HelpTopic"
		case helpTopicID = "HelpTopicID"
		case jCreatedDate = "JCreatedDate"
		case jLastModifiedDate = "JLastModifiedDate"
		case lastModifiedDate = "LastModifiedDate"
		case memberId = "MemberId"
		case memberName = "MemberName"
		case mobile = "Mobile"
		case modifiedBy = "ModifiedBy"
		case queryDetails = "QueryDetails"
		case querySource = "QuerySource"
		case querySummary = "QuerySummary"
		case rating = "Rating"
		case subHelpTopic = "SubHelpTopic"
		case subHelpTopicID = "SubHelpTopicID"
		case ticketStatus = "TicketStatus"
		case totalRows = "TotalRows"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		comments = try values.decodeIfPresent(String.self, forKey: .comments)
		createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
		customerTicketID = try values.decodeIfPresent(Int.self, forKey: .customerTicketID)
		customerTicketRefNo = try values.decodeIfPresent(String.self, forKey: .customerTicketRefNo)
		deviceId = try values.decodeIfPresent(String.self, forKey: .deviceId)
		helpTopic = try values.decodeIfPresent(String.self, forKey: .helpTopic)
		helpTopicID = try values.decodeIfPresent(Int.self, forKey: .helpTopicID)
		jCreatedDate = try values.decodeIfPresent(String.self, forKey: .jCreatedDate)
		jLastModifiedDate = try values.decodeIfPresent(String.self, forKey: .jLastModifiedDate)
		lastModifiedDate = try values.decodeIfPresent(String.self, forKey: .lastModifiedDate)
		memberId = try values.decodeIfPresent(String.self, forKey: .memberId)
		memberName = try values.decodeIfPresent(String.self, forKey: .memberName)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		modifiedBy = try values.decodeIfPresent(String.self, forKey: .modifiedBy)
		queryDetails = try values.decodeIfPresent(String.self, forKey: .queryDetails)
		querySource = try values.decodeIfPresent(String.self, forKey: .querySource)
		querySummary = try values.decodeIfPresent(String.self, forKey: .querySummary)
		rating = try values.decodeIfPresent(String.self, forKey: .rating)
		subHelpTopic = try values.decodeIfPresent(String.self, forKey: .subHelpTopic)
		subHelpTopicID = try values.decodeIfPresent(Int.self, forKey: .subHelpTopicID)
		ticketStatus = try values.decodeIfPresent(String.self, forKey: .ticketStatus)
		totalRows = try values.decodeIfPresent(Int.self, forKey: .totalRows)
	}

}
