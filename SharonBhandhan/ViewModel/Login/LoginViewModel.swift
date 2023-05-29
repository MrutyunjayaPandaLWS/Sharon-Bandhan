//
//  LoginViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class LoginViewModel{
    
    weak var VC:LoginViewController?
    var requestAPIs = RestAPI_Requests()
    
    func loginAPICall(parameters: JSON, completion: @escaping (LoginModels?) -> ()) {
        self.VC?.startLoading()
        self.requestAPIs.login_API(parameters: parameters) { (result, error) in
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
    
    
    func membershipIDVerification(parameters: JSON, completion: @escaping (MemberVerificationModels?) -> ()) {
        self.VC?.startLoading()
        self.requestAPIs.membershipIDVerification_API(parameters: parameters) { (result, error) in
            if error == nil {
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                        self.VC?.stopLoading()
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
//        self.VC?.stopLoading()
    }
}
