//
//  ProfileViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import LanguageManager_iOS

class ProfileViewModel: popUpDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    

    weak var VC: ProfileViewController?
    var requestAPIs = RestAPI_Requests()
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var loyaltyID  = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    
    func myProifleDetails(parameters: JSON, completion: @escaping (MyProfileModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.myProfile(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
//                        self.VC?.stopLoading()
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
            "ActorId": "\(userID)",
            "ActionType": "159",
            "ObjCustomerJson": [
                "DisplayImage": "\(base64)",
                "LoyaltyId": "\(loyaltyID)"
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
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.itsComeFrom = "MyProfileImage"
                                vc!.descriptionInfo = "Profile image updated successfully".localiz()
                                vc!.modalPresentationStyle = .overFullScreen
                                vc!.modalTransitionStyle = .crossDissolve
                                self.VC?.present(vc!, animated: true, completion: nil)
                            }
//                            NotificationCenter.default.post(name: .goToDashBoardAPI, object: nil)
                        }else{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.itsComeFrom = "MyProfileImage"
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
                        print("Wrong Datas dsjhbdj")
                    }
                }
                
            }else{
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                    print("Wrong Data")
                }
            }
        }
    }
    
}
