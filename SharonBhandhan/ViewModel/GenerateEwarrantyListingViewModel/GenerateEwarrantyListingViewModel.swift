//
//  GenerateEwarrantyListingViewModel.swift
//  CenturyPromise
//
//  Created by Arokia IT on 9/9/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit



class GenerateEwarrantyListingViewModel: PopUpDelegate{
    func popUpAlertDidTap2(_ vc: PopUp2ViewController) {}
    
    func popUpAlertDidTap(_ vc: PopUp2ViewController) {}
    
    
    var vc:GnerateEWarrantyViewController?
    var finalSoapMessage = ""
    var myprofiledetails = MyprofileDetailsModels()
    var ewarrantyResponse = GenerateSubmissionEwarrantyModels()
    
    func soapMessage(codeDetails:[GenuineCodeSaveModels], ActorId:String,Address:String,AreaId:String,CityId:String,CustomerName:String,EmailId:String,MobileNum:String,StateId:String,productId:String,count: Int){
//        self.vc!.startLoading()
//        self.finalSoapMessage = ""
//
//        let contractorPart = """
//<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:lws="http://LWS.L1.Common.Contract.ServiceContracts" xmlns:lws1="http://schemas.datacontract.org/2004/07/LWS.L1.License.Common.Contract.BaseContracts" xmlns:lws2="http://schemas.datacontract.org/2004/07/LWS.L1.Common.Contract.DataContracts">
//""" + HEADER_part + """
//        <soapenv:Body>
//           <lws:SaveEWarrantyDetails>
//              <lws:objEWarrantySaveRequest>
//                 <lws1:ActionType>1</lws1:ActionType>
//                 <lws1:ActorId>\(ActorId)</lws1:ActorId>
//                 <lws2:Address>\(Address)</lws2:Address>
//                 <lws2:CityId>\(CityId)</lws2:CityId>
//                 <lws2:CustomerName>\(CustomerName)</lws2:CustomerName>
//                 <lws2:EmailId>\(EmailId)</lws2:EmailId>
//                 <lws2:MobileNum>\(MobileNum)</lws2:MobileNum>
//                 <lws2:StateId>\(StateId)</lws2:StateId>
//                 <lws2:lstEWarranty>
//        """
//        var repeatingCodePart: String = ""
//        if codeDetails.count != 0{
//        for item in codeDetails {
//            if productId == item.ProductId ?? "" {
//                repeatingCodePart =  repeatingCodePart + """
//                <lws2:EWarranty>
//                <lws2:BrandId>\(item.brandID ?? "")</lws2:BrandId>
//                <lws2:EWarrantyQty>\(count)</lws2:EWarrantyQty>
//                <lws2:ProductId>\(item.ProductId ?? "")</lws2:ProductId>
//                <lws2:ScannedCode>\(item.ScratchCode ?? "")</lws2:ScannedCode>
//                </lws2:EWarranty>
//                """
//            }
//        }
//        }
//        let lastPart = """
//                 </lws2:lstEWarranty>
//              </lws:objEWarrantySaveRequest>
//           </lws:SaveEWarrantyDetails>
//        </soapenv:Body>
//     </soapenv:Envelope>
//"""
//
//        self.finalSoapMessage = contractorPart + repeatingCodePart + lastPart
//        print( self.finalSoapMessage)
    }
    
    func EwarrantSubmissionAPI(indexpath:Int){
//        self.vc?.startLoading()
//        self.vc?.dismiss(animated: true, completion: nil)
//        self.ewarrantyResponse.returnMessage = ""
//        self.ewarrantyResponse.returnValue = ""
//        fromURL.almofireSOAPRequestForEWarrantySubmission(methodName: methodName.EwarrantySubmission_METHODNAME, soapMessage: self.finalSoapMessage) { (result, error) in
//            if result == nil{
//                self.vc!.view.makeToast("No Internet Connection", duration: 3.0, position: .top)
//                self.vc!.stopLoading()
//            }else{
//                if error == ""{
//                    self.vc!.stopLoading()
//                    self.ewarrantyResponse = (result as? GenerateSubmissionEwarrantyModels)!
//                    print(self.ewarrantyResponse.returnMessage ?? "")
//                    print(self.ewarrantyResponse.returnValue ?? "")
//                    if self.ewarrantyResponse.returnValue ?? "" == "1"{
//
//
//                        DispatchQueue.main.async{
//                            self.vc!.tempStoreCodesArray.remove(at: indexpath)
//                            self.vc!.generateTableView.reloadData()
//                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
//                            vc!.delegate = self
//                            vc!.titleInfo = ""
//                            vc!.itsFrom = "EwarrantySuccess"
//                            vc!.descriptionInfo = "E-Warranty generated successfully.You can download the E-Warranty in Download E-warranty Section"
//                            vc!.modalPresentationStyle = .overCurrentContext
//                            vc!.modalTransitionStyle = .crossDissolve
//                            self.vc!.present(vc!, animated: true, completion: nil)
//                        }
//                    }else{
//                        DispatchQueue.main.async{
//                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
//                            vc!.delegate = self
//                            self.vc!.stopLoading()
//                            vc!.titleInfo = ""
//                            vc!.itsFrom = "EwarrantyFailed"
//                            vc!.descriptionInfo = "E-Warranty generation failed.Please try after sometime"
//                            vc!.modalPresentationStyle = .overCurrentContext
//                            vc!.modalTransitionStyle = .crossDissolve
//                            self.vc!.present(vc!, animated: true, completion: nil)
//                        }
//                    }
//
//                }else{
//                    print(error?.description ?? "")
//                    self.vc!.stopLoading()
//
//                }
//            }
//        }
    }
    
    func  ApicallingMethod(userID:String){
//        self.vc!.startLoading()
//        fromURL.almofireSOAPRequestProfileDetails(methodName: methodName.GetProfileCustomerDetails_METHODNAME, userID: userID) { (result, error) in
//            if result == nil{
//                DispatchQueue.main.async{
//                    self.vc!.stopLoading()
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
//                    vc!.delegate = self
//                    vc!.titleInfo = ""
//                    vc!.itsFrom = ""
//                    vc!.descriptionInfo = "No Internet. Please check your Internet Connection"
//                    vc!.modalPresentationStyle = .overCurrentContext
//                    vc!.modalTransitionStyle = .crossDissolve
//                    self.vc!.present(vc!, animated: true, completion: nil)
//                }
//                return
//            }else{
//                self.myprofiledetails = result as! MyprofileDetailsModels
//                self.vc?.selectedMemberTypeID = self.myprofiledetails.CustomertypeID ?? "0"
//                self.vc?.selectedStateID = self.myprofiledetails.stateID ?? "0"
//                self.vc?.selectedCityID = self.myprofiledetails.cityid ?? "0"
//                self.vc?.selectedsMemberTypeName = self.myprofiledetails.Customertype ?? ""
//                self.vc?.selectedStateName = self.myprofiledetails.statename ?? ""
//                self.vc?.selectedCityName = self.myprofiledetails.City ?? ""
//                self.vc!.stopLoading()
//
//            }
//        }
    }
}
