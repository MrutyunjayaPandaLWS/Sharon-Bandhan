//
//  ProfileModels.swift
//  Sharon Secure
//
//  Created by Arokia IT on 9/11/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import Foundation


class MyprofileDetailsModels: NSObject{
    var firstname:String!
    var MobileNo:String!
    var EmailId:String!
    var Address:String!
    var Country:String!
    var countryid:String!
    var City:String!
    var cityid:String!
    var Pin:String!
    var AddressId:String!
    var CustomerId:String!
    var CustomerDetailId:String!
    var dateofbirth:String!
    var loyaltyID:String!
    var CustomerUserName:String!
    var Customertype:String!
    var CustomertypeID:String!
    var pobox:String!
    var profileImage:String!
    var statename:String!
    var stateID:String!
    var locationID:String!
    var locationName:String!
    var locationCode:String!
    var QRCode:String!

}
class SaveProfileImageModels:NSObject{
    var ReturnMessage:String!
}
class UpdateProfileDetailsModels:NSObject{
    var resultvalue:String!
    var returnmessage:String!
}
