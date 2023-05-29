//
//  CodeGenuineModels.swift
//  Sharon Secure
//
//  Created by Arokia IT on 9/9/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import Foundation

class CodeGenuineModels: NSObject{
    var ReturnMessage:String?
    var ProductName:String?
    var ProductId:String?
    var PrintDate:String?
    var ScratchCode:String?
    var Size:String?
    var Thickness:String?
    var PlantName:String?
    var PlantCode:String?
    var brandID:String?
    var membername:String?

}

class GenuineCodeSaveModels: NSObject{
    var ReturnMessage:String?
    var ProductName:String?
    var ProductId:String?
    var PrintDate:String?
    var ScratchCode:String?
    var Size:String?
    var Thickness:String?
    var PlantName:String?
    var PlantCode:String?
    var codeCount:Int?
    var brandID:String?
    var StatusID:String?
    var Membername:String?

    init(ReturnMessage:String?,ProductName:String?,ProductId:String?,PrintDate:String?,ScratchCode:String?,Size:String?,Thickness:String?,PlantName:String?,PlantCode:String?,codeCount:Int?,brandID:String?,StatusID:String?,Membername:String?) {
        self.PlantCode = PlantCode
        self.ReturnMessage = ReturnMessage
        self.ProductId = ProductId
        self.ProductName = ProductName
        self.ScratchCode = ScratchCode
        self.Size = Size
        self.Thickness = Thickness
        self.PlantName = PlantName
        self.PrintDate = PrintDate
        self.codeCount = codeCount
        self.brandID = brandID
        self.StatusID = StatusID
        self.Membername = Membername

    }
}
