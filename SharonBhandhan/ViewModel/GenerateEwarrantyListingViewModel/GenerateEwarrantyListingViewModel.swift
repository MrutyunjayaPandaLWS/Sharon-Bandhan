//
//  GenerateEwarrantyListingViewModel.swift
//  CenturyPromise
//
//  Created by Arokia IT on 9/9/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit
import LanguageManager_iOS


class GenerateEwarrantyListingViewModel: PopUpDelegate{
    func popUpAlertDidTap2(_ vc: PopUp2ViewController) {
        if vc.itsFrom == "EwarrantySuccess"{
            for controller in (self.vc?.navigationController!.viewControllers)! as Array {
                if controller.isKind(of: DownloadEWarrantyListViewController.self) {
                    self.vc?.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        }
        
    }
    
//    func popUpAlertDidTap(_ vc: PopUp2ViewController) {}
    
    
    var vc:GnerateEWarrantyViewController?
    var finalSoapMessage = ""
    var myprofiledetails : MyProfileModels?
    var ewarrantyResponse : ewarrentSubmissionModels?
    var requestAPIs = RestAPI_Requests()

    
    func EwarrantSubmissionAPI(indexpath:Int,parameter: JSON){
        self.vc?.startLoading()
        self.vc?.dismiss(animated: true, completion: nil)
        self.ewarrantyResponse?.returnMessage = ""
        self.ewarrantyResponse?.returnValue = 0
        requestAPIs.ewarentySubmissionApi(parameters: parameter) {  (result, error) in
            if result == nil{
                self.vc!.view.makeToast("No Internet Connection", duration: 3.0, position: .top)
                self.vc!.stopLoading()
            }else{
                if error == nil{
                    self.vc!.stopLoading()
                    self.ewarrantyResponse = (result as? ewarrentSubmissionModels)!
                    print(self.ewarrantyResponse?.returnMessage ?? "")
                    print(self.ewarrantyResponse?.returnValue ?? 0)
                    if self.ewarrantyResponse?.returnValue ?? 0 == 1{


                        DispatchQueue.main.async{
//                            self.vc!.tempStoreCodesArray.remove(at: indexpath)
                            self.vc!.generateTableView.reloadData()
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.itsFrom = "EwarrantySuccess"
                            vc!.descriptionInfo = "E-Warranty generated successfully.You can download the E-Warranty in Download E-warranty Section".localiz()
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.vc!.present(vc!, animated: true, completion: nil)
                        }
                    }else{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                            vc!.delegate = self
                            self.vc!.stopLoading()
                            vc!.titleInfo = ""
                            vc!.itsFrom = "EwarrantyFailed"
                            vc!.descriptionInfo = "E-Warranty generation failed.Please try after sometime".localiz()
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.vc!.present(vc!, animated: true, completion: nil)
                        }
                    }

                }else{
                    print(error?.localizedDescription ?? "")
                    self.vc!.stopLoading()

                }
            }
        }
    }
    
    func  ApicallingMethod(userID: Int){
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
    
    
    func myProifleDetails(parameters: JSON){
        self.vc?.startLoading()
        self.requestAPIs.myProfile(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    self.myprofiledetails = result
                    guard self.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?.count != 0 else{
                        self.vc!.stopLoading()
                        return
                    }

                    DispatchQueue.main.async {
                        self.vc?.selectedMemberTypeID = "\(self.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].customerTypeID ?? 0)"
                        self.vc?.selectedStateID = "\(self.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].stateId ?? 0)"
                        self.vc?.selectedCityID = "\(self.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].cityId ?? 0)"
                        self.vc?.selectedsMemberTypeName = self.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].customerType ?? ""
                        self.vc?.selectedStateName = self.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].stateName ?? ""
                        self.vc?.selectedCityName = self.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].cityName ?? ""
                        self.vc!.stopLoading()
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.vc?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.vc?.stopLoading()
                }

        }
    }
    
    }
}
