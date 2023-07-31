//
//  DashBoardViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import LanguageManager_iOS
    
class DashBoardViewModel{
    
    weak var VC:DashBoardViewController?
    var requestAPIs = RestAPI_Requests()
    
    func dashboardAPICall(parameters: JSON, completion: @escaping (DashboardModels?) -> ()) {
        self.VC?.startLoading()
        self.requestAPIs.dashboard_API(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
                
            }
            
        }
    }
    
    
    
    
    func dashboardImagesAPICall(parameters: JSON, completion: @escaping (DashboardImagesModels?) -> ()) {
        self.VC?.startLoading()
        self.requestAPIs.dashboardBanner_API(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
                
            }
            
        }
    }
    func userStatus(parameters: JSON, completion: @escaping (UserStatusModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.userIsActive(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                        
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
                
            }
        }
        
    }
    
    
    func submitCodesApi(parameters: JSON, completion: @escaping (ScannedandUploadCodesModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.submitCodesApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
                
            }
        }
    }
    
    
    
    //MARK: - Image Submission
    func imageSubmissionAPI(base64: String) {
        DispatchQueue.main.async {
              self.VC?.startLoading()
         }

        
        let parameters = [
            "ActorId": "\(self.VC?.userID ?? "")",
            "ObjCustomer": [
                "DisplayImage": "\(base64)",
                "LoyaltyId": "\(self.VC?.loyaltyIDData ?? "")"
            ]
        ]as [String : Any]
        
        print(parameters,"imageAPI")
        self.requestAPIs.imageSavingAPI(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        print(result?.returnMessage ?? "", "ReturnMessage")
                        if result?.returnMessage ?? "" == "1"{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                                vc!.delegate = self
                                vc!.titleInfo = ""
                                
                                vc!.descriptionInfo = "Profile image updated successfully".localiz()
                                vc!.modalPresentationStyle = .overFullScreen
                                vc!.modalTransitionStyle = .crossDissolve
                                self.VC?.present(vc!, animated: true, completion: nil)
                            }
//                            NotificationCenter.default.post(name: .goToDashBoardAPI, object: nil)
                        }else{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                                vc!.delegate = self
                                vc!.titleInfo = ""
                                
                                vc!.descriptionInfo = "Profile image update Failed".localiz()
                                vc!.modalPresentationStyle = .overFullScreen
                                vc!.modalTransitionStyle = .crossDissolve
                                self.VC?.present(vc!, animated: true, completion: nil)
                            }
                        }
                        self.VC?.stopLoading()
                    }
                }else{
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
                
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
            }
        }
    }
    
}
